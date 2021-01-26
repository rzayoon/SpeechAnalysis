
y = audioread('목여중1.wav');

%% control parameters
lpc_order = 10;                          % LPC 차수
m0 = 150;                                % AMDF 길이
t = 1/16000;
s = 0.032;                                % sec   320 = 0.02 / ( 1 / 16000)     512 = x /  (1 / 16000)  x = 512 samples.
leng = s/t;                              % 한 프레임의 길이 ( 20msec일 때 320sample)
Z_rate = 0.8;                            % VUV Detecting 위한 ZeroCrossing 최대값에 대한 threshold 비
E_rate = 0.1;                            % VUV Detecting 위한 Energy 최소값에 대한 threshold 비

%% 전처리 (정규화 & windowing frame)
[y1, x, data] = lzapre(y, leng);  
%[정규화된 신호, windowing 프레임 행렬, windowing안된 프레임 행렬(비교용)] 
% = function(원래 신호, 프레임길이)
%%

%% 특징 추출 (LPC 계수, Zero crossing, Energy, Pitch)
[LC, g, Z, E, AMDF, F0] = lzaextract(x, lpc_order, m0);
%lpcCoef : LPC 계수  g : 예측 오차 분산
% zcr : Zero Crossing  E : Energy
% AMDF : AMDF된 행렬  F0 : Pitch Period 프레임 내에서 유성음의 주기로 사용
%%

%% vuv detect
[vuv, vuv2] = lzavuv(x, Z, Z_rate, E, E_rate, F0, LC);
% vuv : 위에서 구한 feature들(ZCR,Energy)과 조정값(rate) 이용해 detecting한 VUV,
%       0(voiced), 1(unvoiced)
% vuv2 : LPC parameter를 활용해 detecting
%%

%% 합성
   [NEWY, xhat] = lzasyn(x, vuv, LC, F0, g);
   [NEWY2, xhat2] = lzasyn(x, vuv2, LC, F0, g);
% NEWY: vuv를 이용한 재합성 vector
% NEWY2: vuv2 이용한 재합성 vector
%%
num = 21; % number of interesting frame
w = LPC2LSP(LC(:,num));
disp(w');
a = LSP2LPC(w);
disp(a');