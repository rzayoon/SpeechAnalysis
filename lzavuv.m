function [vuv, vuv2] = lzavuv(x, Z, Zr,E, Er, F0, LC)
%vuv detecting function
[~, fNum] = size(x);
vuv = zeros(fNum, 1);
MAX_Z = max(Z);
MAX_E = max(E);

for i = 1 : fNum
 
    if (Z(i) < MAX_Z*Zr && E(i) > MAX_E * Er && ( F0(i) < 140 && F0(i) > 30))
        vuv(i) = 0;   %voiced
    else
        vuv(i) = 1;  %unvoiced
    end
end
% vuv detecting using LPC
for i = 1 : fNum
        LPCrts = roots(LC(:,i));
        realrts = LPCrts(imag(LPCrts)==0);
        if (realrts)  % 실수인 LPC root 존재
            vuv2(i) = 1;   %voiced
        elseif (Z(i) > 80)  % zero-crossing 80 초과
            vuv2(i) = 1;   %voiced
        else
            vuv2(i) = 0;
        end
end

end