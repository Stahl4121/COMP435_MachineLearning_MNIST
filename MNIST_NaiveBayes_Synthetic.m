% Logan Stahl and Miria Tan
% MNIST_NaiveBayes_Synthetic.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprepSynthetic.m"
load testSyn
load trainSyn

% Uses matrices generated from "NaiveBayesPrep.m"
load lblIdxsTrain
load lblCountsTrain
load priorProbs
load lblIdxsTrainTest
load lblCountsTest

synFeatToUse = [3 4 5 6 8 9]; %Choose the column indices of synthetic data to use for Naive Bayes

%Initialize output matrices
probYes = zeros(10,(size(trainSyn,2)-1));
probNo = zeros(10,(size(trainSyn,2)-1));
currLblIdx = zeros(size(trainSyn,1),1);
sumBayes = zeros(10,1);


for lbl = 1:10
    for f = 2:size(trainSyn,2)
        currLblIdx = logical(lblIdxsTrain(:,lbl));
        idxTemp = trainSyn(currLblIdx,f)==1;
        probYes(lbl,f-1)= sum(idxTemp)/lblCountsTrain(lbl);
        idxTemp = trainSyn(currLblIdx,f)==0;
        probNo(lbl,f-1)= sum(idxTemp)/lblCountsTrain(lbl);
    end;
end;

%Now test the model with the train set and test set
numCorrect = 0;
idxCorrect = zeros(size(testSyn,1),1);

for r=1:size(testSyn,1)
    for lbl=1:10
        % Initialize Bayes sum of each label value to the prior probability
        sumBayes(lbl)=log10(priorProbs(lbl));
        
        for i=1:size(synFeatToUse,2)
            f = synFeatToUse(i);
            if testSyn(r,f)==1
                sumBayes(lbl) = sumBayes(lbl)+log10(probYes(lbl,f-1));
            else
                sumBayes(lbl) = sumBayes(lbl)+log10(probNo(lbl,f-1));
            end;
        end;
    end;
 
    [val, maxIdx] = max(sumBayes);
    
    if testSyn(r,1)== (maxIdx-1)
        numCorrect = numCorrect + 1;
        idxCorrect(r,1) = 1;
    end;
end;

accuracyTestSet = numCorrect/size(testSyn,1)

% Store data about the misclassifications
correctCts = zeros(1,10);
probCorrect = zeros(1,10);
idxCorrect = logical(idxCorrect);
correctData = testSyn(idxCorrect,:);
lblCorIdx = zeros(size(correctData,1),10);

% Get the count and probability of correct classification of each label 0-9 in the test set
for lbl = 1:10
    lblCorIdx(:,lbl) = correctData(:,1) == (lbl-1);
    correctCts(lbl)= sum(lblCorIdx(:,lbl)); % Get count of the label value
    probCorrect(lbl)= correctCts(lbl)/lblCountsTest(lbl); % Calculate the prop correct of each label
end;