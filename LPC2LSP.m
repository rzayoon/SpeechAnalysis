function [w, rts, frq] = LPC2LSP(a)
%output lsp�� angle, frq�� �׿� ���� ���ļ�
b = [a; 0];   % a = A(z)
b = b(end:-1:1);
p = [a; 0] - b;  % P(z)
q = [a; 0] + b;  % Q(z)
rtsp = roots(p);
rtsq = roots(q);       % theta
rts = [rtsp; rtsq];
rtsp = rtsp(imag(rtsp)>=0);
rtsq = rtsq(imag(rtsq)>=0);  % ��Ī�Ǵ� �� ����
angp = atan2(imag(rtsp), real(rtsp));  
angq = atan2(imag(rtsq), real(rtsq));  % arctan
lsp = sort([angp; angq]);        % ����
w = lsp(2:end-1);
frq = w.*(16000/(2*pi));       % Fs= 16000 �󿡼� lsp�� ���ļ�


end