function [w, rts, frq] = LPC2LSP(a)
%output lsp는 angle, frq는 그에 따른 주파수
b = [a; 0];   % a = A(z)
b = b(end:-1:1);
p = [a; 0] - b;  % P(z)
q = [a; 0] + b;  % Q(z)
rtsp = roots(p);
rtsq = roots(q);       % theta
rts = [rtsp; rtsq];
rtsp = rtsp(imag(rtsp)>=0);
rtsq = rtsq(imag(rtsq)>=0);  % 대칭되는 점 제외
angp = atan2(imag(rtsp), real(rtsp));  
angq = atan2(imag(rtsq), real(rtsq));  % arctan
lsp = sort([angp; angq]);        % 정렬
w = lsp(2:end-1);
frq = w.*(16000/(2*pi));       % Fs= 16000 상에서 lsp의 주파수


end