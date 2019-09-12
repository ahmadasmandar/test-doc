# Software Documentation

The following document describes the Software used in the Train and Station µC (Microcontroller). It gives an overview of the functions/variables etc. and their runtime hierarchy and interaction. It is based on the [Hardware Documentation](https://gitlab.tu-ilmenau.de/FakMB/QBV/systems/legocity/legocity/blob/7c1d31d95c03e8a2fec4604575fd690efe0258b9/doc/hardware-doc/README.md).

## Notes on C/C++ Coding Standards

<details>
  <summary>Click to expand!</summary>

**Source and author: Jason Turner ("lefticus"): [Coding Standards](https://gist.github.com/lefticus/10191322) 
Last revision: 28.04.2014**



# C++ Coding Standards Part 0: Automated Code Analysis
<details>
  <summary>Click to expand!</summary>
  
Automated analysis is the main advantage to working with a modern statically typed compiled language like C++. Code analysis tools can inform us when we have implemented an operator overload with a non-canonical form, when we should have made a method const, or when the scope of a variable can be reduced.

In short, these tools catch the most commonly agreed best practice mistakes we are making and help educate us to write better code. We will be fully utilizing these tools.

## Compilers

All reasonable warning levels should be enabled. Some warning levels, such as GCC's `-Weffc++` warning mode can be too noisy and will not be recommended for normal compilation.

### GCC / Clang

A good combination of settings is `-Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic`

 * `-Wall -Wextra`: reasonable and standard
 * `-Wshadow`: warn the user if a variable declaration shadows another with the same name in the same scope
 * `-Wnon-virtual-dtor`: warn the user if a class with virtual functions has a non-virtual destructor. This can lead to hard to track down memory errors
 * `-pedantic`: warn about non-portable code, C++ that uses language extensions.

### MSVC

MSVC has fewer warning options, so all warnings should be enabled: `/W4`. `/Wall` could be considered, but does not seem to be recommended even by microsoft.

## Static Analyzers

Static analyzers look for errors that compilers do not look for, such as potential performance and memory issues.

### Cppcheck

[Cppcheck](http://cppcheck.sourceforge.net/) is free and opensource. It strives for 0 false positives and does a good job at it. Therefor all warning should be enabled: `-enable=all`

### Clang's Static Analyzer

Clang's analyzer's default options are good for the respective platform. It can be used directly [from cmake](http://garykramlich.blogspot.com/2011/10/using-scan-build-from-clang-with-cmake.html).

### MSVC's Static Analyzer

Can be enabled with the `/analyze` [command line option](http://msdn.microsoft.com/en-us/library/ms173498.aspx). For now we will stick with the default options.

## Code Coverage Analysis

A coverage analysis tool shall be run when tests are executed to make sure the entire application is being tested. Unfortunately, coverage analysis requires that compiler optimizations be disabled. This can result in significantly longer test execution times.

The most likely candidate for a coverage visualization is the [lcov](http://ltp.sourceforge.net/coverage/lcov.php) project. A secondary option is [coveralls](https://coveralls.io/), which is free for open source projects.


## Ignoring Warnings

If it is determined by team consensus that the compiler or analyzer is warning on something that is either incorrect or unavoidable, the team will disable the specific error to as localized part of the code as possible.

## Unit Tests

There should be a test enabled for every feature or bug fix that is committed. See also "Code Coverage Analysis."

</details>

# C++ Coding Standards Part 1: Style
<details>
  <summary>Click to expand!</summary>
  
Style guidelines are not overly strict. The important thing is that code is clear and readable with an appropriate amount of whitespace and reasonable length lines. A few best practices are also mentioned.

## Descriptive and Consistent Naming

C++ allows for arbitrary length identifier names, so there's no reason to be terse when naming variables. Use descriptive names, and be consistent in the style

 * `CamelCase`
 * `snake_case`
 
are common examples. snake_case has the advantage that it can also work with spell checkers, if desired.

### Common C++ Naming Conventions

 * Types start with capitals: `MyClass`
 * functions and variables start with lower case: `myMethod`
 * constants are all capital: `const int PI=3.14159265358979323;`

*Note that the C++ standard does not follow any of these guidelines. Everything in the standard is lowercase only.*

### Distinguish Private Object Data

Name private data with a `m_` prefix to distinguish it from public data.

### Distinguish Function Parameters

Name function parameters with an `t_` prefix.

### Well formed example

```cpp
class MyClass
{
public:
  MyClass(int t_data)
    : m_data(t_data)
  {
  }
  
  int getData() const
  {
    return m_data;
  }
  
private:
  int m_data;
};
```

## Distinguish C++ Files From C Files

C++ source file should be named `.cpp` or `.cc` NOT `.c`
C++ header files should be named `.hpp` NOT `.h`

## Use `nullptr`

C++11 introduces `nullptr` which is a special type denoting a null pointer value. This should be used instead of 0 or NULL to indicate a null pointer.

## Comments

Comment blocks should use `//`, not `/* */`. Using `//` makes it much easier to comment out a block of code while debugging.

```cpp
// this function does something
int myFunc()
{
}
```

To comment out this function block during debugging we might do:

```cpp
/*
// this function does something
int myFunc()
{
}
*/
```

which would be impossible if the function comment header used `/* */`

## Never Use `using` In a Header File

This causes the name space you are `using` to be pulled into the namespace of the header file.


## Include Guards

Header files must contain an distinctly named include guard to avoid problems with including the same header multiple times or conflicting with other headers from other projects

```cpp
#ifndef MYPROJECT_MYCLASS_HPP
#define MYPROEJCT_MYCLASS_HPP

namespace MyProject {
class MyClass {
};
}

#endif
```

## 2 spaces indent level. 

Tabs are not allowed, and a mixture of tabs and spaces is strictly forbidden. Modern autoindenting IDEs and editors require a consistent standard to be set.

```cpp
// Good Idea
int myFunction(bool t_b)
{
  if (t_b)
  {
    // do something
  }
}
```

## {} are required for blocks. 
Leaving them off can lead to semantic errors in the code.

```cpp
// Bad Idea
// this compiles and does what you want, but can lead to confusing
// errors if close attention is not paid.
for (int i = 0; i < 15; ++i)
  std::cout << i << std::endl;

// Bad Idea
// the cout is not part of the loop in this case even though it appears to be
int sum = 0;
for (int i = 0; i < 15; ++i)
  ++sum;
  std::cout << i << std::endl;
  
  
// Good Idea
// It's clear which statements are part of the loop (or if block, or whatever)
int sum = 0;
for (int i = 0; i < 15; ++i) {
  ++sum;
  std::cout << i << std::endl;
}
```

## Keep lines a reasonable length

```cpp
// Bad Idea
// hard to follow
if (x && y && myFunctionThatReturnsBool() && caseNumber3 && (15 > 12 || 2 < 3)) { 
}

// Good Idea
// Logical grouping, easier to read
if (x && y && myFunctionThatReturnsBool() 
    && caseNumber3 
    && (15 > 12 || 2 < 3)) { 
}
```


## Use "" For Including Local Files
... `<>` is [reserved for system includes](http://blog2.emptycrate.com/content/when-use-include-verses-include).

```cpp
// Bad Idea. Requires extra -I directives to the compiler
// and goes against standards
#include <string>
#include <includes/MyHeader.hpp>

// Worse Idea
// requires potentially even more specific -I directives and 
// makes code more difficult to package and distribute
#include <string>
#include <MyHeader.hpp>


// Good Idea
// requires no extra params and notifies the user that the file
// is a local file
#include <string>
#include "MyHeader.hpp"
```

## Initialize Member Variables
...with the member initializer list

```cpp
// Bad Idea
class MyClass
{
public:
  MyClass(int t_value)
  {
    m_value = t_value;
  }

private:
  int m_value;
};


// Good Idea
// C++'s memeber initializer list is unique to the language and leads to
// cleaner code and potential performance gains that other languages cannot 
// match
class MyClass
{
public:
  MyClass(int t_value)
    : m_value(t_value)
  {
  }

private:
  int m_value;
};
```

## Forward Declare when Possible

This:
```cpp
// some header file
class MyClass;

void doSomething(const MyClass &);
```

instead of:

```cpp
// some header file
#include "MyClass.hpp"

void doSomething(const MyClass &);
```

This is a proactive approach to simplify compilation time and rebuilding dependencies.

## Always Use Namespaces

There is almost never a reason to declare an identifier in the global namespaces. Instead, functions and classes should exist in an appropriately named namespaces or in a class inside of a namespace. Identifiers which are placed in the global namespace risk conflicting with identifiers from other (mostly C, which doesn't have namespaces) libraries.

## Avoid Compiler Macros

Compiler definitions and macros are replaced by the pre-processor before the compiler is ever run. This can make debugging very difficult because the debugger doesn't know where the source came from.

```cpp
// Good Idea
namespace my_project {
  class Constants {
  public:
    static const double PI = 3.14159;
  }
}

// Bad Idea
#define PI 3.14159;
```
</details>

# C++ Coding Standards Part 2: Performance and Safety
<details>
  <summary>Click to expand!</summary>

## Limit Variable Scope

Variables should be declared as late as possible, and ideally, only when it's possible to initialize the object. Reduced variable scope results in less memory being used, more efficient code in general, and helps the compiler optimize the code further.

```c++
// Good idea
for (int i = 0; i < 15; ++i)
{
  MyObject obj(i);
  // do something with obj
}

// Bad Idea
MyObject obj; // meaningless object initialization
for (int i = 0; i < 15; ++i)
{
  obj = MyObject(i); // unnecessary assignment operation
  // do something with obj
}
// obj is still taking up memory for no reason
```

## Use Exceptions Instead of Return Values to Indicate Error

Exceptions cannot be ignored. Return values, such as using `boost::optional`, can be ignored and if not checked can cause crashes or memory errors. An exception, on the other hand, can be caught and handled. Potentially all the way up the highest level of the application with a log and automatic restart of the application.

Stroustrup, the original designer of C++, [makes this point](http://www.stroustrup.com/bs_faq2.html#exceptions-why) much better than I ever could.

## Avoid raw memory access

Raw memory access, allocation and deallocation, are difficult to get correct in C++ without [risking memory errors and leaks](http://blog2.emptycrate.com/content/nobody-understands-c-part-6-are-you-still-using-pointers). C++11 provides tools to avoid these problems.

```cpp
// Bad Idea
MyClass *myobj = new MyClass;

// ...
delete myobj;


// Good Idea
std::shared_ptr<MyClass> myobj = make_shared<MyClass>();
// ... 
// myobj is automatically freed for you whenever it is no longer used.
```

## Avoid global data
... this includes singleton objects

Global data leads to unintended sideeffects between functions and can make code difficult or impossible to parallelize. Even if the code is not intended today for parallelization, there is no reason to make it impossible for the future.


## Prefer pre-increment to post-increment 
... when it is semantically correct. Pre-increment is [faster](http://blog2.emptycrate.com/content/why-i-faster-i-c) then post-increment because it does not require a copy of the object to be made.

```cpp
// Bad Idea
for (int i = 0; i < 15; i++)
{
  std::cout << i << std::endl;
}


// Good Idea
for (int i = 0; i < 15; ++i)
{
  std::cout << i << std::endl;
}

```



## Const as much as possible
`const` tells the compiler that a variable or method is immutable. This helps the compiler optimize the code and helps the developer know if a function side effects. Also, using `const &` prevents the compiler from copying data unnecessarily. [Here](http://kotaku.com/454293019) are some comments on const from John Carmack.

```cpp
// Bad Idea
class MyClass
{
public:
  MyClass(std::string t_value)
    : m_value(t_value)
  {
  }

  std::string get_value() 
  {
    return m_value;
  }

private:
  std::string m_value;
}


// Good Idea
class MyClass
{
public:
  MyClass(const std::string &t_value)
    : m_value(t_value)
  {
  }

  std::string get_value() const
  {
    return m_value;
  }

private:
  std::string m_value;
}
```


## Prefer Stack Operations to Heap Operations

Heap operations have performance penalties in mulithreaded environments on most platforms and can possibly lead to memory errors if not used carefully.

Modern C++11 has special move operations which are designed to enhances the performance of stack based data by reducing or eliminating copies, which can bring even the single threaded case on par with heap based operations.

</details>

# References and Further Reading


 * http://geosoft.no/development/cppstyle.html
 * http://google-styleguide.googlecode.com/svn/trunk/cppguide.xml (Note that google's standard document makes several recommendations which we will NOT be following. For example, they explicitly forbid the use of exceptions, which makes [RAII](http://blog2.emptycrate.com/content/nobody-understands-c-part-2-raii) impossible.)
 * http://www.parashift.com/c++-faq/
 * http://www.cplusplus.com/
 * http://sourceforge.net/apps/mediawiki/cppcheck/index.php?title=ListOfChecks
 * http://emptycrate.com/ 
</details>

