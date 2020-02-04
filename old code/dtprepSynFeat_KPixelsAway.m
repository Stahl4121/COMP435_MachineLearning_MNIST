% Uses matrices generated from "dtprep.m"
clear
load testData
load trainData

trainSyn = zeros(size(trainData));
testSyn = zeros(size(testData));

% Copy over label values
trainSyn(:,1) = trainData(:,1);
testSyn(:,1) = testData(:,1);

imgSize = 28;
pixDist = 4;   %Will count num black pixels within this range away from the pixel

for i = 1:size(trainSyn,1)
    
    A = trainData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    
    for p = 2:size(trainSyn,2)
        r = floor((p-1)/imgSize);
        c = mod((p-1), 28);
        
        %Determine bounds of box selection
        top = max([(r-pixDist) (1)]);
        bottom = min([(r+pixDist) (28)]);
        left = max([(c-pixDist) (1)]);
        right = min([(c+pixDist) (28)]);
        
        trainSyn(i,p)= sum(sum(img(top:bottom, left:right)));
    end
end
for i = 1:size(testSyn,1)
    
    A = testData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    
    for p = 2:size(testSyn,2)
        r = floor((p-1)/imgSize);
        c = mod((p-1), 28);
        
        %Determine bounds of box selection
        top = max([(r-pixDist) (1)]);
        bottom = min([(r+pixDist) (28)]);
        left = max([(c-pixDist) (1)]);
        right = min([(c+pixDist) (28)]);
        
        testSyn(i,p)= sum(sum(img(top:bottom, left:right)));
    end
end

% Save data matrix to file
save trainSyn.mat trainSyn
save testSyn.mat testSyn

% Clear workspace and load data
%clear
load trainSyn
load testSyn