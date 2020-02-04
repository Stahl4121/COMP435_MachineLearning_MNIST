% Logan Stahl
% MNIST_NaiveBayes_Synthetic.m
% COMP 435 Machine Learning
% 5/1/2019
%
% Uses matrices generated from "dtprepSynthetic.m"
load testSyn
load trainSyn

%Initialize output matrices
lblIdxsTrain = zeros(size(trainSyn,1),10);
lblCountsTrain = zeros(1,10);
priorProbs = zeros(1,10);
featMean = zeros(10,(size(trainSyn,2)-1));
featStd = zeros(10,(size(trainSyn,2)-1));
currLblIdx = zeros(size(trainSyn,1),1);
sumBayes = zeros(10,1);

% Get the count and prior probability of each label 0-9 in the train set
for i = 1:10
    lblIdxsTrain(:,i) = trainSyn(:,1)== (i-1);
    lblCountsTrain(i)= sum(lblIdxsTrain(:,i)); % Get count of the label value
    priorProbs(i)= lblCountsTrain(i)/size(trainSyn,1); % Calculate the prior probability
end;

for lbl = 1:10
    for f = 2:size(trainSyn,2)
        currLblIdx = logical(lblIdxsTrain(:,lbl));
        featMean(lbl,f-1)= mean(trainSyn(currLblIdx,f));
        featStd(lbl,f-1)= std(trainSyn(currLblIdx,f));
    end;
end;

%Now test the model with the train set and test set
numCorrect = 0;
idxCorrect = zeros(size(testSyn,1),1);

for r=1:size(testSyn,1)
    for lbl=1:10
        % Initialize Bayes sum of each label value to the prior probability
        sumBayes(lbl)=log10(priorProbs(lbl));
        
        for f=2:size(testSyn,2)
                sumBayes(lbl) = sumBayes(lbl)+log10(normpdf(testSyn(r,f),featMean(lbl,f-1),featStd(lbl,f-1)));
        end;
    end;
 
    [val, maxIdx] = max(sumBayes);
    
    if testSyn(r,1)== (maxIdx-1)
        numCorrect = numCorrect + 1;
        idxCorrect(r,1) = 1;
    end;
end;

accuracyTestSet = numCorrect/size(testSyn,1)

%Initialize output matrices
lblIdxsTest = zeros(size(testSyn,1),10);
lblCountsTest = zeros(1,10);
priorProbsTest = zeros(1,10);

% Get the count and prior probability of each label 0-9 in the test set
for i = 1:10
    lblIdxsTest(:,i) = testSyn(:,1)== (i-1);
    lblCountsTest(i)= sum(lblIdxsTest(:,i)); % Get count of the label value
    priorProbsTest(i)= lblCountsTest(i)/size(testSyn,1); % Calculate the prior probability
end;

% Store data about the misclassifications
correctCts = zeros(1,10);
probCorrect = zeros(1,10);
idxCorrect = logical(idxCorrect);
correctData = testSyn(idxCorrect,:);
labelIncIdx = zeros(size(correctData,1),10);

% Get the count and probability of failed of each label 0-9 in the test set
for i = 1:10
    labelIncIdx(:,i) = correctData(:,1) == (i-1);
    correctCts(i)= sum(labelIncIdx(:,i)); % Get count of the label value
    probCorrect(i)= correctCts(i)/lblCountsqTest(i); % Calculate the prop correct of each label
end;