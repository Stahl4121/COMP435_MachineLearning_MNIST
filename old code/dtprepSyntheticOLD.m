% Uses matrices generated from "dtprep.m"
clear
load testData
load trainData

% load testDataRaw
% load trainDataRaw
% A=trainDataRaw(3,2:785);
% img = flipud(rot90(reshape(A, 28, [])));
% I = mat2gray(img,[255 0]);
% imshow(I)

numFeat = 5;
trainSyn = zeros(size(trainData,1), 1+numFeat);
testSyn = zeros(size(testData,1), 1+numFeat);

% Copy over label values
trainSyn(:,1) = trainData(:,1);
testSyn(:,1) = testData(:,1);

% First synthetic feature: Number of black pixels
for i = 1:size(trainSyn,1)
    trainSyn(i,2)= sum(trainData(i,2:size(trainData,2)));
end
for i = 1:size(testSyn,1)
    testSyn(i,2)= sum(testData(i,2:size(testData,2)));
end

%Setup for next 4 synthetic features
%Syn Feat 2:    NumBlackPixels in top {boundThresh*100}%
%Syn Feat 3:    NumBlackPixels in bottom {boundThresh*100}%
%Syn Feat 4:    NumBlackPixels in right {boundThresh*100}%
%Syn Feat 5:    NumBlackPixels in left {boundThresh*100}%

imgSize = 28;
boundThresh = 0.5;
boundRightBottom = round(boundThresh*imgSize);
boundLeftTop = imgSize - round(boundThresh*imgSize);

for i = 1:size(trainSyn,1)
    A = trainData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    
    trainSyn(i,3)= sum(sum(img(1:boundRightBottom,:)));
    trainSyn(i,4)= sum(sum(img(boundLeftTop:imgSize,:)));
    trainSyn(i,5)= sum(sum(img(:,1:boundRightBottom)));
    trainSyn(i,6)= sum(sum(img(:,boundLeftTop:imgSize)));
end
for i = 1:size(testSyn,1)
    A = trainData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    
    testSyn(i,3)= sum(sum(img(1:boundRightBottom,:)));
    testSyn(i,4)= sum(sum(img(boundLeftTop:imgSize,:)));
    testSyn(i,5)= sum(sum(img(:,1:boundRightBottom)));
    testSyn(i,6)= sum(sum(img(:,boundLeftTop:imgSize)));
end

% Save data matrix to file
save trainSyn.mat trainSyn
save testSyn.mat testSyn

% Clear workspace and load data
%clear
load trainSyn
load testSyn