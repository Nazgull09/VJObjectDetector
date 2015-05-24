% tests ada-boost face detector on a sample image

load('../cache/Cparams.mat');

figure;

tic

im = imread('../data/Test/Group-of-People.jpg');

dets1 = FastScanImage(Cparams, im, 0.4, 0.6, 1.1, false);

toc

load('../cache/Cparams1.mat');

figure;

tic

dets2 = FastScanImage(Cparams, im, 0.4, 0.6, 1.1, false);

toc

%load('../cache/Cparams2.mat');

%figure;

%tic

%dets3 = FastScanImage(Cparams, im, 0.4, 0.6, 1.1, false);

%toc

DisplayDetections(im, dets1,dets2);