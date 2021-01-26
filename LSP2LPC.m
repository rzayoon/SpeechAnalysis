function a = LSP2LPC(w)
l = length(w);
q = cos(w);
P = [1, -1];
Q = [1, 1];
for k = 1 : l/2
    P = conv(P,[1, -2*q(2*k), 1]);
    Q = conv(Q,[1, -2*q(2*k-1), 1]);
end
a = (P + Q)/2 ;
a = (a(1:end-1))';
end

