function [y, x, data] = lzapre(x, a) 
%input
% x : audioread된 vector
% a : 한 프레임의 길이
%output
% y : 정규화된 음성신호 vector
% x : hamming windowing된 신호의 행렬, 각 열이 하나의 프레임을 의미
% data : hamming windowing되기 전의 행렬, 
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
   data(:,i) = y((1:a) + (i-1)*step);        % 프레임 마다 반씩 overlap
   x(:,i) = data(:,i).*hamming(a);           % 추출한 data를 hamming windowing
end
end
