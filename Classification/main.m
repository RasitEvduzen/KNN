clc,clear all,close all;
% KNN Algorithm Width Classification
% 13-Feb-2020
%% Input Data
B = 3;       % Data Complexity
N = 250;     % Number of Data
Tall = [];
for i = 1:N/2
    theta = pi/2+(i-1)*[(2*B-1)/N]*pi;
    Tall = [Tall, [theta*cos(theta);theta*sin(theta)]];
end
Tall = [Tall,-Tall];
Tmax = pi/2+[(N/2-1)*(2*B-1)/N]*pi;
T = [Tall]'/Tmax; 
Y = [-ones(1,N/2), ones(1,N/2)]'; 


%% Create Algorithm
noise = 0.01*randn(size(T,1),size(T,2));
T = T + noise;
SNR = snr(T,noise);

K = 5;   % K = 2n+1  n = 0,1,2,3,...
input = [];
output = [];
NumOfMisClass = 0;
for i=1:size(T,1)
    testpoint = T(i,:);
    for j=1:size(T,1)
        point = T(j,:);
        if j == i
            D(j,1) = inf;
        else
            D(j,1) = sqrt(sum((testpoint - point).^2));
        end
    end
    [V,I] = sort(D);
    KNNoutput = sign(sum(Y(I(1:K))));
    Realoutput = Y(i);
    if KNNoutput == Realoutput
    else
        NumOfMisClass = NumOfMisClass + 1;
    end
end

INPUT = []; OUTPUT = [];
for t1 = -1:0.01:1
    for t2 = -1:0.01:1
        testinput = [t1,t2];
        for j = 1:size(T,1)
            point = T(j,:);
            D(j,1) = sqrt(sum((testinput-point).^2));
        end
        [V,I] = sort(D);
        KNNoutput = sign(sum(Y(I(1:K))));
        INPUT = [INPUT; testinput];
        OUTPUT = [OUTPUT; KNNoutput];
    end
end

%% Plot Algorithm result
Iplus = find(OUTPUT == 1);
Iminus = find(OUTPUT == -1);
plot(INPUT(Iplus,1),INPUT(Iplus,2),'y.');hold on,axis([-1 1 -1 1])
plot(INPUT(Iminus,1),INPUT(Iminus,2),'m.');

Iplus = find(Y == 1);
Iminus = find(Y == -1);
plot(T(Iplus,1),T(Iplus,2),'r+');
plot(T(Iminus,1),T(Iminus,2),'ko');
title(['K= ',num2str(K),'  Number Of Miss Classification= ',num2str(NumOfMisClass),' SNR= ',num2str(SNR)])















