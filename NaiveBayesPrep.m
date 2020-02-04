% Uses matrices generated from "dtprep.m"
load testData
load trainData

%Initialize output matrices
lblIdxsTest = zeros(size(testData,1),10);
lblCountsTest = zeros(1,10);
lblIdxsTrain = zeros(size(trainData,1),10);
lblCountsTrain = zeros(1,10);
priorProbs = zeros(1,10);
priorProbsTest = zeros(1,10);

% Get the count and prior probability of each label 0-9 in the train set
for lbl = 1:10
    lblIdxsTrain(:,lbl) = trainData(:,1)== (lbl-1);
    lblCountsTrain(lbl)= sum(lblIdxsTrain(:,lbl)); % Get count of the label value
    priorProbs(lbl)= lblCountsTrain(lbl)/size(trainData,1); % Calculate the prior probability
    
    lblIdxsTest(:,lbl) = testData(:,1)== (lbl-1);
    lblCountsTest(lbl)= sum(lblIdxsTest(:,lbl)); % Get count of the label value
    priorProbsTest(lbl)= lblCountsTest(lbl)/size(testData,1); % Calculate the prior probability
end;

save lblIdxsTrain.mat lblIdxsTrain
save lblCountsTrain.mat lblCountsTrain
save priorProbs.mat priorProbs
save priorProbsTest.mat priorProbsTest
save lblIdxsTest.mat lblIdxsTest
save lblCountsTest.mat lblCountsTest
