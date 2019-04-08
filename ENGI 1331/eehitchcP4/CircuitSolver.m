function [ I1, I2, I3 ] = CircuitSolver( V1, V2, R1, R2, R3 )
%Solves equations for I1, I2 and I3
%V1 - I1R1 -I3R3 = 0
%V2 -I3R3 - I2R2 = 0
%I3 = I1-I2

    I1 = (-V2.*R3 + V1.*(R3+R2))./(R2.*R3+(R3+R2).*R1);
    I2 = (V2-I1.*R3)./(R3+R2);    
    I3 = I1+I2;
    
end

