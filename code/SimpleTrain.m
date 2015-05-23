% trains an ada-boost model on tiny faces
% adjust the parameters according to your available system memory
% nTrainPosData/nTrainNegData - Количество позитивных/негативных признаков
% W, H - Ширина и длина картинки.


nTrainPosData = 4000;
nTrainNegData = 8000;
nTestPosData = 500;
nTestNegData = 1000;
nLevels = 100;
W = 19;
H = 19;


%Списки лиц/не лиц для обучения
posImageDir = '../data/TinyFaces/FACES/';
negImageDir = '../data/TinyFaces/NFACES/';

%Массивы битмапов для обучения.
PTrainData = zeros(W, H, nTrainPosData);
NTrainData = zeros(W, H, nTrainNegData);


pfiles = dir([posImageDir '*.bmp']);
nfiles = dir([negImageDir '*.bmp']);

%Перемешиваем массивы
aa = 1:length(pfiles); a = randperm(length(aa)); trainPosPerm = aa(a(1:nTrainPosData));
aa = 1:length(nfiles); a = randperm(length(aa)); trainNegPerm = aa(a(1:nTrainNegData));

%Отсеиваем и выбираем только часть файлов для теста
testPosPerm = setdiff(1:length(pfiles), trainPosPerm);
testNegPerm = setdiff(1:length(nfiles), trainNegPerm);

PTestData = zeros(W, H, nTestPosData);
NTestData = zeros(W, H, nTestNegData);

% Считываем imread-ом изображения правильные/неправильные для тренировки
disp('preparing training data...');
for i=1:size(PTrainData,3)
    PTrainData(:,:,i) = imread([posImageDir pfiles(trainPosPerm(i)).name]);
end
for i=1:size(NTrainData,3)
    NTrainData(:,:,i) = imread([negImageDir nfiles(trainNegPerm(i)).name]);
end

% Считываем для теста
disp('preparing test data...');
for i=1:size(PTestData,3)
    PTestData(:,:,i) = imread([posImageDir pfiles(testPosPerm(i)).name]);
end
for i=1:size(NTestData,3)
    NTestData(:,:,i) = imread([negImageDir nfiles(testNegPerm(i)).name]);
end

% find classifier parameters
disp('training the model...');
Cparams = Train(PTrainData, NTrainData, PTestData, NTestData, nLevels);

% Сохраняем напрямую из памяти
save('../cache/Cparams.mat', 'Cparams');
