function [ area ] = AreaFunctions( C,int )
%Function "AreaFunctions" calculates the integral for the area between each
%intersection point
    disp('Function "AreaFunctions" calculates the integral for the area between each intersection point');
    for n=1:length(int)-1
        area(n) = abs(integral(@(x) MyFun(x)-polyval(C,x),int(n),int(n+1)));
    end
end

