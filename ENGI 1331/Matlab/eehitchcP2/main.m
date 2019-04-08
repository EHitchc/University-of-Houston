clear all; clc; close all;
%ENGI 1331 Project 2 - Ethan Hitchcock - eehitchc
disp('ENGI 1331 Project 2 - Ethan Hitchcock - eehitchc');

%Problem 1: Altering an image
disp(' '), disp(' '), disp('Problem 1: Altering an image'), disp(' ');

%Task 1: Load in image named "beach.jpeg" then display image in Figure 1
disp('Task 1: Load in image named "beach.jpeg" then display image in Figure 1');

beach=imread('beach.jpeg');
figure(1); image(beach); title('Figure 1');

disp('Figure 1 displays image read in from project folder, Press any key to continue');
pause;

%Task 2: Ask the user for a number between 0 and 255 and subtract this
%number from every entry in image matrix from task 1
disp(' '), disp('Task 2: Ask the user for a number between 0 and 255 and subtract this number from every entry in image matrix from task 1');

inputsubtract = input('Please enter a number between 0 and 255   ')
beachsubtract = beach - inputsubtract;

figure(2); image(beachsubtract); title('Figure 2');

%Describe the effect in a sentence
disp('Figure 2 displays a darker version of the image, each entry in the image matrix has been reduced (minimum value after subtraction is 0)');
disp('Press any key to continue'), pause;

%Task 3: Ask the user for a number between 0 and 255 and add this number to
%every entry in image matrix from task 1
disp(' '), disp('Task 3: Ask the user for a number between 0 and 255 and add this number to every entry in image matrix from task 1');

inputadd = input('Please enter a number between 0 and 255   ')
beachadd = beach + inputadd;

figure(3); image(beachadd); title('Figure 3');

%Describe the effect in a sentence
disp('Figure 3 displays a brighter version of the image, each entry in the image matrix has been increased (maximum value after addition is 255)');
disp('Press any key to continue'), pause;

%Task 4: Load in the file named number.txt and multiply image matrix by the
%value in this file.
disp(' '), disp('Task 4: Load in the file named number.txt and multiply image matrix by the value in this file.');

loadmultiply = load('number.txt')
beachmultiply = loadmultiply * beach;

figure(4); image(beachmultiply); title('Figure 4');

%Describe the effect in a sentence
disp('Figure 4 displays a saturated version of the image, each entry in the image matrix has been multiplied by value in number.txt (maximum value after multiplication is 255)');
disp('Press any key to continue'), pause;

%Task 5: Convert your image from task 1 to an indexed image and then apply
%the 'autumn' colormap
disp(' '), disp('Task 5: Convert your image from task 1 to an indexed image and then apply the ''autumn'' colormap');

beachautumn = rgb2ind(beach, autumn);
figure(5);
colormap('autumn');
image(beachautumn);
title('Figure 5');
disp('Refer to Figure 5 for applied autumn colormap');
disp('Press any key to continue'), pause;


%Problem 2: Separating an Image into Layers
disp(' '), disp(' '), disp('Problem 2: Separating an Image into Layers'), disp(' ');

%Task 1: Load in image named minion.jpeg
disp('Task 1: Load in image named minion.jpeg');
minion = imread('minion.jpeg');
disp('Press any key to continue'), pause;

%Task 2: Separate the RGB image from task 1 into 3 two-dimensional matrices
%and use subplot to display the RGB image and each color layer in Figure 6
disp(' '), disp('Task 2: separate the RGB image from task 1 into 3 two-dimensional matrices and use subplot to display the RGB image and each color layer in Figure 6');

%Create a layer for R, G, and B
minionR=minion(:,:,1);
minionG=minion(:,:,2);
minionB=minion(:,:,3);

figure(6);
subplot(2,2,1), image(minion); title('Original');
subplot(2,2,2), image(minionR); title('Red Layer');
subplot(2,2,3), image(minionG); title('Green Layer');
subplot(2,2,4), image(minionB); title('Blue Layer');

disp('Press any key to continue'), pause;

%Task 3: Create a new matrix that does not include the green layer
disp(' '), disp('Task 3: Create a new matrix that does not include the green layer');

%Use cat to create a new RGB image
minionRB = cat(3,minionR,zeros(size(minionG)),minionB);

figure(7);
image(minionRB);
title('Figure 7');

%Is this method effective in replacing the background with another image?
disp(' '), disp('This method works best for images where the colour of the background is not present in the subject, as such it is relatively effective for the picture of the minion');
disp('Press any key to continue'), pause;


%Problem 3: Removing Background and Superimposing the Pictures
disp(' '), disp(' '), disp('Problem 3: Removing Background and Superimposing the Pictures'), disp(' ');

%Task 1: Create a new matrix that contains indices for the black values of
%the image from problem 2.
disp('Task 1: Create a new matrix that contains indices for the black values of the image from problem 2'), disp(' ');

mask=minionR>3&minionB>20;

disp('Press any key to continue'), pause;

%Task 2: Create a new matrix with 3 duplicated mask layers
disp(' '), disp('Task 2: Create a new matrix with 3 duplicated mask layers'), disp(' ');

minionmask=cat(3,mask,mask,mask);

disp('Press any key to continue'), pause;

%Task 3: Load the image tiedye.jpeg and impose it onto the minion
disp(' '), disp('Task 3: Load the image tiedye.jpeg and impose it onto the minion'), disp(' ');

tiedye = imread('tiedye.jpeg');
miniontiedye=minionRB;
miniontiedye(minionmask)=tiedye(minionmask);

figure(8);
image(miniontiedye);
title('Figure 8');

disp('Press any key to continue'), pause;

%Task 4: Superimpose the tiedyeminion onto the image in task 1 of problem 1
disp(' '), disp('Task 4: Superimpose the tiedyeminion onto the image in task 1 of problem 1'), disp(' ');

minionbeach=beach;
minionbeach(minionmask)=miniontiedye(minionmask);

figure(9);
image(minionbeach);
title('Figure 9');

disp('Press any key to continue'), pause;


%Problem 4: Sobel Edge Detection
disp(' '), disp(' '), disp('Problem 4: Sobel Edge Detection'), disp(' ');

%Task 1: Load the image crystals.jpeg and convert to grayscale
disp('Task 1: Load the image crystals.jpeg and convert to grayscale'), disp(' ');

crystals=imread('crystals.jpeg');

%Convert to grayscale using approximation
crystalsgrey=0.2989.*crystals(:,:,1)+0.5870.*crystals(:,:,2)+0.1140.*crystals(:,:,3);

figure(10); image(crystals); title('Figure 10');
figure(11); image(crystalsgrey); title('Figure 11');

disp('Press any key to continue'), pause;

%Task 2: Create two new matrices and define the sobel kernels
disp(' '), disp('Task 2: Create two new matrices and define the sobel kernels'), disp(' ');

Kh=[-1,-2,-1;0,0,0;1,2,1]
Kv=[-1,0,1;-2,0,2;-1,0,1]

disp('Press any key to continue'), pause;

%Task 3: "Convolve" the new image with the sobel kernels
disp(' '), disp('Task 3: "Convolve" the new image with the sobel kernels'), disp(' ');

x=conv2(double(crystalsgrey), double(Kh));
y=conv2(double(crystalsgrey), double(Kv));

disp('Press any key to continue'), pause;

%Task 4 - Use the image() command to display the horizontal edges and the
%vertical edges separately in Figure 12 and Figure 13 respectively
disp(' '), disp('Task 4 - Use the image() command to display the horizontal edges and the vertical edges separately in Figure 12 and Figure 13 respectively'), disp(' ');

figure(12); image(abs(x)); title('Figure 12');
figure(13); image(abs(y)); title('Figure 13');

disp('Press any key to continue'), pause;

%Task 5 - Display the combined image of the normalized vertical and
%horizontal edges in Figure 14
disp(' '), disp('Task 5 - Display the combined image of the normalized vertical and horizontal edges in Figure 14'), disp(' ');

figure(14); image((x.^2+y.^2).^0.5); title('Figure 14');

disp('Press any key to end script'), pause;