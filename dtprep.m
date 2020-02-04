d1 = readtable("mnist_train.csv");
trainDataRaw = d1{:,:};
trainData = zeros(size(trainDataRaw));

% Changes pixel values from grayscale [0,255] into binary
for i = 1:size(trainData,1)
    for j = 2:size(trainData,2)
        pixel = trainDataRaw(i,j);
        if pixel > 10
            trainData(i,j) = 1;
        else
            trainData(i,j) = 0;
        end
    end
end

% Copy over label values
trainData(:,1) = trainDataRaw(:,1);

% Repeat for the test set
d1 = readtable("mnist_test.csv");
testDataRaw = d1{:,:};
testData = zeros(size(testDataRaw));

% Changes pixel values from grayscale [0,255] into binary
for i = 1:size(testData,1)
    for j = 2:size(testData,2)
        pixel = testDataRaw(i,j);
        if pixel > 10
            testData(i,j) = 1;
        else
            testData(i,j) = 0;
        end
    end
end

% Copy over label values
testData(:,1) = testDataRaw(:,1);

% Save data matrix to file
save trainData.mat trainData
save testData.mat testData
save trainDataRaw.mat trainDataRaw
save testDataRaw.mat testDataRaw

% Clear workspace and load data
clear
load trainData
load testData
load trainDataRaw
load testDataRaw