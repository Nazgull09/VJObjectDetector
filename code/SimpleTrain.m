% trains an ada-boost model on tiny faces
% adjust the parameters according to your available system memory
% nTrainPosData/nTrainNegData - Количество позитивных/негативных признаков
% W, H - Ширина и длина картинки.

for j=1:4

switch j
    case 1      %24x24
        nTrainPosData = 30;
        nTrainNegData = 50;
        nTestPosData = 30;
        nTestNegData = 50;
        nLevels = 10;
        W = 24;
        H = 24;
    case 2      %32x32
        nTrainPosData = 30;
        nTrainNegData = 50;
        nTestPosData = 30;
        nTestNegData = 50;
        nLevels = 10;
        W = 32;
        H = 32;
    case 3      %64x64
        nTrainPosData = 30;
        nTrainNegData = 50;
        nTestPosData = 30;
        nTestNegData = 50;
        nLevels = 10;
        W = 64;
        H = 64;
    case 4      %128x128
        nTrainPosData = 30;
        nTrainNegData = 50;
        nTestPosData = 30;
        nTestNegData = 50;
        nLevels = 10;
        W = 128;
        H = 128;
end


%Списки лиц/не лиц для обучения
switch j
    case 1
        posImageDir = '../data/TinyFaces24/FACES/';
        negImageDir = '../data/TinyFaces24/NFACES/';
    case 2
        posImageDir = '../data/TinyFaces32/FACES/';
        negImageDir = '../data/TinyFaces32/NFACES/';
    case 3
        posImageDir = '../data/TinyFaces64/FACES/';
        negImageDir = '../data/TinyFaces64/NFACES/';
    case 4
        posImageDir = '../data/TinyFaces128/FACES/';
        negImageDir = '../data/TinyFaces128/NFACES/';
end

%Массивы битмапов для обучения.
PTrainData = zeros(W, H, nTrainPosData);
NTrainData = zeros(W, H, nTrainNegData);


switch j
    case 1
        pfiles = dir([posImageDir '*.bmp']);
        nfiles = dir([negImageDir '*.bmp']);
    case 2
        pfiles = dir([posImageDir '*.jpg']);
        nfiles = dir([negImageDir '*.bmp']);
    case 3
        pfiles = dir([posImageDir '*.pgm']);
        nfiles = dir([negImageDir '*.jpg']);
    case 4
        pfiles = dir([posImageDir '*.pgm']);
        nfiles = dir([negImageDir '*.jpg']);
end


%Перемешиваем массивы
aa = 1:length(pfiles); a = randperm(length(aa)); trainPosPerm = aa(a(1:nTrainPosData));
aa = 1:length(nfiles); a = randperm(length(aa)); trainNegPerm = aa(a(1:nTrainNegData));

%Отсеиваем и выбираем только часть файлов для теста
testPosPerm = setdiff(1:length(pfiles), trainPosPerm);
testNegPerm = setdiff(1:length(nfiles), trainNegPerm);

PTestData = zeros(W, H, nTestPosData);
NTestData = zeros(W, H, nTestNegData);


switch j
    case 1
        for i=1:size(PTrainData,3)
            PTrainData(:,:,i) = rgb2gray(imread([posImageDir pfiles(trainPosPerm(i)).name]));
        end
        for i=1:size(NTrainData,3)
            NTrainData(:,:,i) = rgb2gray(imread([negImageDir nfiles(trainNegPerm(i)).name]));
        end
    case 2
        for i=1:size(PTrainData,3)
            PTrainData(:,:,i) = rgb2gray(imread([posImageDir pfiles(trainPosPerm(i)).name]));
        end
        for i=1:size(NTrainData,3)
            NTrainData(:,:,i) = rgb2gray(imread([negImageDir nfiles(trainNegPerm(i)).name]));
        end    
    case 3
        for i=1:size(PTrainData,3)
            PTrainData(:,:,i) = rgb2gray(imread([posImageDir pfiles(trainPosPerm(i)).name]));
        end
        for i=1:size(NTrainData,3)
            NTrainData(:,:,i) = rgb2gray(imread([negImageDir nfiles(trainNegPerm(i)).name]));
        end
    case 4
        for i=1:size(PTrainData,3)
            PTrainData(:,:,i) = rgb2gray(imread([posImageDir pfiles(trainPosPerm(i)).name]));
        end
        for i=1:size(NTrainData,3)
            NTrainData(:,:,i) = rgb2gray(imread([negImageDir nfiles(trainNegPerm(i)).name]));
        end
end

% Считываем imread-ом изображения правильные/неправильные для тренировки
disp('preparing training data...');
for i=1:size(PTrainData,3)
    PTrainData(:,:,i) = rgb2gray(imread([posImageDir pfiles(trainPosPerm(i)).name]));
end
for i=1:size(NTrainData,3)
    NTrainData(:,:,i) = rgb2gray(imread([negImageDir nfiles(trainNegPerm(i)).name]));
end

% Считываем для теста
disp('preparing test data...');
for i=1:size(PTestData,3)
    PTestData(:,:,i) = rgb2gray(imread([posImageDir pfiles(testPosPerm(i)).name]));
end
for i=1:size(NTestData,3)
    NTestData(:,:,i) = rgb2gray(imread([negImageDir nfiles(testNegPerm(i)).name]));
end

% Параметры классификатора
disp('training the model...');
Cparams = Train(PTrainData, NTrainData, PTestData, NTestData, nLevels);

% Сохраняем напрямую из памяти
switch j
    case 1
        save('../cache/Cparams1.mat', 'Cparams');
        disp('traing 24x24 complete');
    case 2
        save('../cache/Cparams2.mat', 'Cparams');
        disp('traing 29x32 complete');
    case 3
        save('../cache/Cparams3.mat', 'Cparams');
        disp('traing 56x64 complete');
    case 4
        save('../cache/Cparams4.mat', 'Cparams');
        disp('traing 112x128 complete');
end

end