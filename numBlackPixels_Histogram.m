% Logan Stahl and Miria Tan
% numBlackPixels_Histogram.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprepSynthetic.m"
load testSyn
load trainSyn

% Uses matrices generated from "NaiveBayesPrep.m"
load lblIdxsTrain

zero = trainSyn(logical(lblIdxsTrain(:,1)),2);
one = trainSyn(logical(lblIdxsTrain(:,2)),2);
two = trainSyn(logical(lblIdxsTrain(:,3)),2);
three = trainSyn(logical(lblIdxsTrain(:,4)),2);
four = trainSyn(logical(lblIdxsTrain(:,5)),2);
five = trainSyn(logical(lblIdxsTrain(:,6)),2);
six = trainSyn(logical(lblIdxsTrain(:,7)),2);
seven = trainSyn(logical(lblIdxsTrain(:,8)),2);
eight = trainSyn(logical(lblIdxsTrain(:,9)),2);
nine = trainSyn(logical(lblIdxsTrain(:,10)),2);

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

binWid = 5;

% Create histogram
histogram(zero,'Parent',axes1,'BinWidth',binWid);
histogram(one,'Parent',axes1,'BinWidth',binWid);
histogram(two,'Parent',axes1,'BinWidth',binWid);
histogram(three,'Parent',axes1,'BinWidth',binWid);
histogram(four,'Parent',axes1,'BinWidth',binWid);
histogram(five,'Parent',axes1,'BinWidth',binWid);
histogram(six,'Parent',axes1,'BinWidth',binWid);
histogram(seven,'Parent',axes1,'BinWidth',binWid);
histogram(eight,'Parent',axes1,'BinWidth',binWid);
histogram(nine,'Parent',axes1,'BinWidth',binWid);

% Label histogram
ylabel({'Example Count'});
xlabel({'# Black Pixels'});
title({'# Black Pixels'});
box(axes1,'on');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.756331542594014 0.639578833693304 0.101688411358404 0.262149028077754]);

