% Logan Stahl and Miria Tan
% dataVis.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprep.m"
clear
load testData
load trainData

% Uses matrices generated from "NaiveBayesPrep.m"
load lblIdxsTrain
load lblCountsTrain

%Initialize output matrices
imgSize = 28;
meanFracByRow = zeros(10,imgSize);
meanFracByCol = zeros(10,imgSize);

for i = 1:size(trainData,1)
    lbl = trainData(i,1)+1;
    A = trainData(i,2:785);
    img = flipud(rot90(reshape(A, imgSize, [])));
    for r=1:imgSize
        c=r;
        meanFracByRow(lbl,r)= meanFracByRow(lbl,r) + sum(img(r,:))/sum(sum(img(:,:)));
        meanFracByCol(lbl,c)= meanFracByCol(lbl,c) + sum(img(:,c))/sum(sum(img(:,:)));
    end;
end;

for lbl=1:10
    totalCt = lblCountsTrain(lbl);
    meanFracByRow(lbl,:) = meanFracByRow(lbl,:)/totalCt;
    meanFracByCol(lbl,:) = meanFracByCol(lbl,:)/totalCt;
end;

    