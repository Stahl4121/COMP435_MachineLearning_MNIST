% Logan Stahl and Miriam Tan
% dtprepSynthetic.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprep.m"
clear
load testData
load trainData

trainSyn = zeros(size(trainData,1), 9);
testSyn = zeros(size(testData,1), 9);

% Copy over label values
trainSyn(:,1) = trainData(:,1);
testSyn(:,1) = testData(:,1);

% Calculate number of black pixels
for i = 1:size(trainSyn,1)
    trainSyn(i,2)= sum(trainData(i,2:size(trainData,2)));
end
for i = 1:size(testSyn,1)
    testSyn(i,2)= sum(testData(i,2:size(testData,2)));
end

% First synthetic feature: Number of black pixels < maxPixels
maxPixels = 100;
for i = 1:size(trainSyn,1)
    trainSyn(i,3)= sum(trainData(i,2:size(trainData,2))) < maxPixels;
end
for i = 1:size(testSyn,1)
    testSyn(i,3)= sum(testData(i,2:size(testData,2))) < maxPixels;
end

%Setup for next few synthetic features
imgSize = 28;
dataFracBlackByRowTrain = zeros(size(trainSyn,1),imgSize);

for i = 1:size(trainData,1)
    A = trainData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    for r=1:imgSize
        dataFracBlackByRowTrain(i,r)= sum(img(r,:))/sum(sum(img(:,:)));
    end;
end;

dataFracBlackByRowTest = zeros(size(testSyn,1),imgSize);

for i = 1:size(testData,1)
    A = testData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    for r=1:imgSize
        dataFracBlackByRowTest(i,r)= sum(img(r,:))/sum(sum(img(:,:)));
    end;
end;

% Second synthetic feature, if rows 9-11 >thresh --> Help Predict 7s
thresh = 0.08;
for i = 1:size(trainData,1)
    trainSyn(i,4) = (dataFracBlackByRowTrain(i,9) > thresh && dataFracBlackByRowTrain(i,10) > thresh && dataFracBlackByRowTrain(i,11) > thresh);
end
for i = 1:size(testData,1)
    testSyn(i,4) = (dataFracBlackByRowTest(i,9) > thresh && dataFracBlackByRowTest(i,10) > thresh && dataFracBlackByRowTest(i,11) > thresh);
end

% Third synthetic feature, if rows 15-17 >thresh --> Help Predict 4s
thresh = 0.08;
for i = 1:size(trainData,1)
    trainSyn(i,5) = (dataFracBlackByRowTrain(i,15) > thresh && dataFracBlackByRowTrain(i,16) > thresh && dataFracBlackByRowTrain(i,17) > thresh);
end
for i = 1:size(testData,1)
    testSyn(i,5) = (dataFracBlackByRowTest(i,15) > thresh && dataFracBlackByRowTest(i,16) > thresh && dataFracBlackByRowTest(i,17) > thresh);
end

% Fourth synthetic feature, if rows 8-10 <thresh --> Help Predict 6s
thresh = 0.04;
for i = 1:size(trainData,1)
    trainSyn(i,6) = (dataFracBlackByRowTrain(i,8) < thresh && dataFracBlackByRowTrain(i,9) < thresh && dataFracBlackByRowTrain(i,10) < thresh);
end
for i = 1:size(testData,1)
    testSyn(i,6) = (dataFracBlackByRowTest(i,8) < thresh && dataFracBlackByRowTest(i,9) < thresh && dataFracBlackByRowTest(i,10) < thresh);
end

% Setup for fifth synthetic feature
% calculates ratio of pixels in first 15 rows to last 13 rows
for i = 1:size(trainData,1)
    trainSyn(i,7) = (sum(dataFracBlackByRowTrain(i,1:15))/sum(dataFracBlackByRowTrain(i,16:28)));
end
for i = 1:size(testData,1)
    testSyn(i,7) = (sum(dataFracBlackByRowTest(i,1:15))/sum(dataFracBlackByRowTest(i,16:28)));
end

% Fifth and Sixth Synthetic Features
% 5th: The ratio between the first 15 rows and last 13 is less then 1
% 6th: The ratio between the first 15 rows and last 13 is greater than 1.25
for i = 1:size(trainData,1)
    trainSyn(i,8) = trainSyn(i,7) < 1;
    trainSyn(i,9) = trainSyn(i,7) > 1.25;
end
for i = 1:size(testData,1)
    testSyn(i,8) = testSyn(i,7) < 1;
    testSyn(i,9) = testSyn(i,7) > 1.25;
end



% Save data matrix to file
save trainSyn.mat trainSyn
save testSyn.mat testSyn

% Clear workspace and load data
clear
load trainSyn
load testSyn