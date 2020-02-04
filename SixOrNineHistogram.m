% Logan Stahl and Miriam Tan
% SixOrNineHistogram.m
% COMP 435 Machine Learning
% 5/3/2019

% Uses matrices generated from "dtprepSynthetic.m"
load testSyn
load trainSyn

% Uses matrices generated from "NaiveBayesPrep.m"
load lblIdxsTrain

six = trainSyn(logical(lblIdxsTrain(:,7)),7);
nine = trainSyn(logical(lblIdxsTrain(:,10)),7);

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

binWid = 0.05;

% Create histogram
histogram(six,'Parent',axes1,'BinWidth',binWid);
histogram(nine,'Parent',axes1,'BinWidth',binWid);

% Label histogram
ylabel({'Example Count'});
xlabel({'Ratio'});
title({'Ratio of First 15 Rows to Last 13 Rows'});
box(axes1,'on');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.756331542594014 0.639578833693304 0.101688411358404 0.262149028077754]);

