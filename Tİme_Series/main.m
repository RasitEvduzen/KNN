clc,clear all,close all;
% KNN Algorithm Width Time Series
% 13-Feb-2020
%% Input Data
load henondata

PredictionHorizon = 25;
NumOfData = 1500;
R = 2;
T = []; Y = [];
for i=1:NumOfData-R
    T = [T; z(i:i+R-1)];
    Y = [Y; z(i+R)];
end


%% Create Algorithm

K = 15;   % K = 2n+1  n = 0,1,2,3,...
Zhat = z(1:NumOfData);

for i=1:PredictionHorizon
    testinput = [Zhat(end-R+1:end)];
    for j=1:size(T,1)
        point = T(j,:);
        D(j,1) = sqrt(sum((testinput-point).^2));
    end
    [V,I] = sort(D);
    KNNoutput = mean(Y(I(1:K)));
    Zhat = [Zhat, KNNoutput];
end

%% Plot Algorithm result
plot(z(NumOfData+1:NumOfData+PredictionHorizon),'r-o','linewidth',1.5); hold on,grid minor
plot(Zhat(NumOfData+1:NumOfData+PredictionHorizon),'k-*','linewidth',1);
legend('Henon Data','Prediction Data'),title('KNN Time Series Prediction')













