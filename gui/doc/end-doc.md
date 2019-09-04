# End-User Document 
![Demo-Ver](svgs/demov1.svg)
![Matlab-Ver](svgs/versions.svg)
## **Demo-Modus**

Das hapute Ziel des **Demomodus** ist, das ganze System und alle Komponenten zu testen und einen guten Überblick über seine Funktionalität zu geben.  
Das Modus wird von einem durch **Matlab-GUI und AppDesigner** erstellten Prdogramm gesteurt.
Das Programm besteht hauptsichlich aus 2 Teilen, Dem Programm-Initialisition und Zugkontrol Teil `1` am rechten Seite und dem Kameras Kontrol Teil `2` Abb (1).

![Abb1](images/oberflacheAktiv.PNG  "Nutzer Bedienoberfläche")
---

## **Programm Initialisieren**

Das Programm muss initialisiert werden, indem man erst die **COM-Port verbinden** Taste drückt. Dann wird die **Demo Modus** Taste aktiviert. danach muss die **Kameras initialisieren** Taste gedrückt werden. Die beiden Tasten befinden sich in der oberern rechten Seite von der Bedienoberfläche *(Teil 1)* Abb (2). Es dauert ungefähr 10 Sekunden, bevor das System bereit ist.  

![Abb2](images/kontro1.png "Kontrol 1")  

Wenn man die **Demo Modus** Taste bevor **Kamerasinitialisieren** Taste drückt, bekommt er einen `Fehler` Abb (3).

![Abb3](images/demoFehler.PNG "Fehler") 

---

## **QR-Code Kamera**

![Abb3](images/QR1.PNG "QR code Kamera")  

Diese Kamera dient zur Erkennung eines QR-Codes, das sich auf einem Wagen befindet.

|Taste| Funktion|
|-----|---------|
|Livebild| die Kamera zeigt die Bildkomposition über den Bildschirm|
|Stopp|Kamera Ausschalten|
|Einzelbild|ein Foto aufnehmen und auf dem Bildschirm zeigen|
|Erkennen|QR-Code im Bild erkenen und In der Textuelle unten Zeigen|

![Abb4](images/QRerkennen.PNG "QR code erkennen")  

---
