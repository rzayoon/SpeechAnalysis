
y = audioread('����1.wav');

%% control parameters
lpc_order = 10;                          % LPC ����
m0 = 150;                                % AMDF ����
t = 1/16000;
s = 0.032;                                % sec   320 = 0.02 / ( 1 / 16000)     512 = x /  (1 / 16000)  x = 512 samples.
leng = s/t;                              % �� �������� ���� ( 20msec�� �� 320sample)
Z_rate = 0.8;                            % VUV Detecting ���� ZeroCrossing �ִ밪�� ���� threshold ��
E_rate = 0.1;                            % VUV Detecting ���� Energy �ּҰ��� ���� threshold ��

%% ��ó�� (����ȭ & windowing frame)
[y1, x, data] = lzapre(y, leng);  
%[����ȭ�� ��ȣ, windowing ������ ���, windowing�ȵ� ������ ���(�񱳿�)] 
% = function(���� ��ȣ, �����ӱ���)
%%

%% Ư¡ ���� (LPC ���, Zero crossing, Energy, Pitch)
[LC, g, Z, E, AMDF, F0] = lzaextract(x, lpc_order, m0);
%lpcCoef : LPC ���  g : ���� ���� �л�
% zcr : Zero Crossing  E : Energy
% AMDF : AMDF�� ���  F0 : Pitch Period ������ ������ �������� �ֱ�� ���
%%

%% vuv detect
[vuv, vuv2] = lzavuv(x, Z, Z_rate, E, E_rate, F0, LC);
% vuv : ������ ���� feature��(ZCR,Energy)�� ������(rate) �̿��� detecting�� VUV,
%       0(voiced), 1(unvoiced)
% vuv2 : LPC parameter�� Ȱ���� detecting
%%

%% �ռ�
   [NEWY, xhat] = lzasyn(x, vuv, LC, F0, g);
   [NEWY2, xhat2] = lzasyn(x, vuv2, LC, F0, g);
% NEWY: vuv�� �̿��� ���ռ� vector
% NEWY2: vuv2 �̿��� ���ռ� vector
%%
num = 21; % number of interesting frame
w = LPC2LSP(LC(:,num));
disp(w');
a = LSP2LPC(w);
disp(a');