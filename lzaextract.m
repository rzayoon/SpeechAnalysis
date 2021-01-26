function [LC, g, Z, E, AMDF, F0] = lzaextract(x, order, m0)
[len, fNum] = size(x);
LC = ones(order+1, fNum);
g = zeros(fNum, 1);
Z = zeros(fNum, 1);
E = zeros(fNum, 1);
AMDF = zeros(m0, fNum);
F0 = zeros(fNum, 1);
for i=1:fNum
    %% LPC 계수
    %[LC(:,i), g(i)] = lpc(x(:,i), order);   % LPC 계수 저장 
   
    x_temp = x(:,i);
    b = x_temp(2:len);
    xz = [x_temp; zeros(order, 1)];
    A = zeros(len-1, order);
    for ct=1:order
        temp = circshift(xz, ct-1);
        A(:, ct) = temp(1:(len-1));
    end
    LC(2:order+1,i) = -A\b;    % A\b  = (A'*A) \ (A'*b) if row > col   (solver)
    e = b + A*LC(2:order+1,i);   
    g(i) = var(e);
    %% zerocrossing rate & Energy
    zero = 0;
    for j = 2:len 
        if x(j,i) * x(j-1,i) <= 0;
            zero = zero + 1;               
        end
    end
    Z(i) = zero;
    %% Energy
    E(i) = sqrt(sum(x(:,i).^2));
    %% AMDF for Pitch Period
        xi = x(:,i);
        Y = zeros(m0, 1);
        for m = 1 : m0
            diffx = zeros(len-m, 1);
            for n = 1 : len-m+1
                diffx(n) = abs(xi(n) - xi(n+m-1));
            end
            Y(m) = sum(diffx);
        end
        Y = Y / len;
        AMDF(:,i) = Y;
        [pks, locs] = findpeaks(-AMDF(:,i));
        [~, p] = max(pks);
        if (p)
            F0(i) = locs(p); 
        end
end
end
