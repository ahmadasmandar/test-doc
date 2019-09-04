% this is a standalone script to display a live video stream of the FIR cam
% in full screen mode

param = parameter();
cam = param.camera_infrared();
imaqmex('feature', '-previewFullBitDepth', true);
figure('units','normalized','outerposition',[0 0 1 1])
cam.preview(@infrared_adjust);
view(-90,90);
axis equal;
axis tight;
colormap('jet');
zoom(1.175);
