% Logan Stahl and Miriam Tan
% MNIST_NaiveBayes.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprep.m"
load testData
load trainData

% Uncomment to add in synthetic features (another area to uncomment is below)
% Uses matrices generated from "dtprepSynthetic.m"
% load trainSyn
% load testSyn

% Uses matrices generated from "NaiveBayesPrep.m"
load lblIdxsTrain
load lblCountsTrain
load priorProbs
load lblIdxsTrainTest
load lblCountsTest

%Initialize output matrices
probBlack = zeros(10,size(trainData,2)+1);
probWhite = zeros(10,size(trainData,2)+1);
currLblIdx = zeros(size(trainData,1),1);
sumBayes = zeros(10,1);

% Uncomment to add in synthetic features (another area to uncomment is below)
% temp = zeros(size(trainData,1),size(trainData,2)+6);
% temp(:,1:785)= trainData(:,:);
% temp(:,786)= trainSyn(:,3);
% temp(:,787)= trainSyn(:,4);
% temp(:,788)= trainSyn(:,5);
% temp(:,789)= trainSyn(:,6);
% temp(:,790)= trainSyn(:,8);
% temp(:,791)= trainSyn(:,9);
% trainData = temp;
% 
% temp = zeros(size(testData,1),size(testData,2)+6);
% temp(:,1:785)= testData(:,:);
% temp(:,786)= testSyn(:,3);
% temp(:,787)= testSyn(:,4);
% temp(:,788)= testSyn(:,5);
% temp(:,789)= testSyn(:,6);
% temp(:,790)= testSyn(:,8);
% temp(:,791)= testSyn(:,9);
% testData = temp;

for lbl = 1:10
    for i = 2:size(trainData,2)
        currLblIdx = logical(lblIdxsTrain(:,lbl));
        idxTemp = trainData(currLblIdx,i)==1;
        probBlack(lbl,i-1)= sum(idxTemp)/lblCountsTrain(lbl);
        idxTemp = trainData(currLblIdx,i)==0;
        probWhite(lbl,i-1)= sum(idxTemp)/lblCountsTrain(lbl);
    end;
end;

%Now test the model with the train set and test set
numCorrect = 0;
idxCorrect = zeros(size(testData,1),1);

for r=1:size(testData,1)
    for lbl=1:10
    % Initialize Bayes sum of each label value to the prior probability
    sumBayes(lbl)=log10(priorProbs(lbl));
    
        for p=2:size(testData,2)
            if testData(r,p)==1
                sumBayes(lbl) = sumBayes(lbl)+log10(probBlack(lbl,p-1));
            else
                sumBayes(lbl) = sumBayes(lbl)+log10(probWhite(lbl,p-1));
            end;
        end;
    end;
    
    [val, maxIdx] = max(sumBayes);
    if testData(r,1)== (maxIdx-1)
        numCorrect = numCorrect + 1;
        idxCorrect(r,1) = 1;
    end;
end;

accuracyTestSet = numCorrect/size(testData,1)

% Store data about the misclassifications
correctCts = zeros(1,10);
probCorrect = zeros(1,10);
idxCorrect = logical(idxCorrect);
correctData = testData(idxCorrect,:);
lblCorIdx = zeros(size(correctData,1),10);

% Get the count and probability of failed of each label 0-9 in the test set
for lbl = 1:10
    lblCorIdx(:,lbl) = correctData(:,1) == (lbl-1);
    correctCts(lbl)= sum(lblCorIdx(:,lbl)); % Get count of the label value
    probCorrect(lbl)= correctCts(lbl)/lblCountsTest(lbl); % Calculate the prop correct of each label
end;