%ENGI 1331 Exam 4B - Ethan Hitchcock - eehitchcock@uh.edu - eehitchc
clc, clear all, close all;
disp('ENGI 1331 Exam 4B - Ethan Hitchcock - eehitchcock@uh.edu - eehitchc');

%Serenity Now
disp(' '), disp('Serenity Now'), disp(' ');

%% Task 1
disp(' '), disp('Task 1'), disp(' ');

%load in minion.jpeg and assign it to TH
disp('load in minion.jpeg and assign it to TH'), disp(' ');
TH = imread('minion.jpeg');

%Create a new Figure and display TH
disp('Create a new Figure and display TH'), disp(' ');
figure(1);
image(TH);
title('Figure 1');

disp(' '), disp('Figure 1 displayed, Press any key to see Figure 2...'), disp(' '), pause;

%load in beach.jpeg and assign it to EW
disp('load in beach.jpeg and assign it to EW'), disp(' ');
EW = imread('beach.jpeg');

%Create a new Figure and display EW
disp('Create a new Figure and display EW'), disp(' ');
figure(2);
image(EW);
title('Figure 2');

disp(' '), disp('Figure 2 displayed, Press any key to continue...'), disp(' '), pause;

%% Task 2
disp(' '), disp('Task 2'), disp(' ');

%Mask the minion
disp('Mask the minion'), disp(' ');
TH_Mask = MaskImage(TH, 20, 0, 20);

%Replace EW(mask) with TH(mask)
disp('Replace EW(mask) with TH(mask)'), disp(' ');
EW_new = EW;
EW_new(TH_Mask) = TH(TH_Mask);

%Display the new image in Figure 3
disp('Display the new image in Figure 3'), disp(' ');
figure(3);
image(EW_new);
title('Figure 3');

disp(' '), disp('Figure 3 displayed, Press any key to continue...'), disp(' '), pause;

%% Task 3
disp(' '), disp('Task 3'), disp(' ');

%Load in noisy.jpeg and assign it to HS
disp('Load in noisy.jpeg and assign it to HS'), disp(' ');
HS = imread('noisy.jpeg');

%Remove the noise using a moving average
disp('Remove the noise using a moving average'), disp(' ');
HSClean = moving_Ethan(HS);
for i=1:3
    HSClean = moving_Ethan(HSClean);
end

%Display the noisy image
disp('Display the noisy image'), disp(' ');
figure(4);
image(HS);
title('Figure 4');

disp('Figure 4 displayed, Press any key to display Figure 5...'), disp(' '), pause;

%Display the new image in which the noise has been removed, moving average
%has been applied 5 times
disp('Display the new image in which the noise has been removed, moving average has been applied 4 times'), disp(' ');
figure(5);
image(HSClean);
title('Figure 5');

disp('Figure 5 displayed, Press any key to end script.'), pause;