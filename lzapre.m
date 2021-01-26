function [y, x, data] = lzapre(x, a) 
%input
% x : audioread�� vector
% a : �� �������� ����
%output
% y : ����ȭ�� ������ȣ vector
% x : hamming windowing�� ��ȣ�� ���, �� ���� �ϳ��� �������� �ǹ�
% data : hamming windowing�Ǳ� ���� ���, 
n = length(x);
total = sum(x);
smean = total / n;
svar = sum((x-smean).^2);
y = (x-smean)./realsqrt(svar);
step = a/2;
fNum = floor((n-a)/step) + 1;
data = zeros(a, fNum);
x = zeros(a, fNum);
for i=1:fNum                                 % i Frame
   data(:,i) = y((1:a) + (i-1)*step);        % ������ ���� �ݾ� overlap
   x(:,i) = data(:,i).*hamming(a);           % ������ data�� hamming windowing
end
end
