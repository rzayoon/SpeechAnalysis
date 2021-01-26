function [Y, x_hat] = lzasyn(x, vuv, LC, F0, g) 
    [len, fNum] = size(x);
    x_hat = zeros(len, fNum);
    for i = 1 : fNum
        src = zeros(len, 1);
        if (vuv(i) == 0) %pulse
            period = round(F0(i));
            pts = 1:period:len;
            if ~isempty(pts)
                src(pts) = sqrt(period);
            end
        else  %noise
       src = randn(len, 1);
        end
    x_hat(:,i) = -filter(1,LC(:,i) , sqrt(g(i))*src);  
    end
    step = len/2;
    n = fNum*step+step;
    Y = zeros(n,1);
    for i = 2 : fNum-1
        Y( (i-1)*step + (1 : len)) = Y( (i-1)*step + (1 : len)) + x_hat(:,i).*hamming(len);
    end
    Y = 10*Y; % юсюг gain
end
