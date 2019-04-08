function [ areasL, areasM, areasR ] = RiemannAreas ( C,int,numincrements )
%Function "RiemannAreas" calculates the Riemann sums between the
%intersection points using different points on the curve
    disp('Function "RiemannAreas" calculates the Riemann sums between the intersection points using different points on the curve');
    for n = 1:length(int)-1
        a = int(n+1)-int(n);
        a = a/numincrements;
        
        %areasL
        areasL(n)=0;
        for m=0:numincrements-1
            areasL(n)=areasL(n) + a*abs(MyFun(int(n)+m*a)-polyval(C,int(n)+m*a));
        end
        
        %areasM
        areasM(n)=0;
        for m=0:numincrements-1
            areasM(n)=areasM(n) + a*abs(MyFun(a/2 + int(n) + m*a)-polyval(C,a/2 + int(n) + m*a));
        end
        
        %areasR
        areasR(n)=0;
        for m=1:numincrements
            areasR(n)=areasR(n) + a*abs(MyFun(int(n)+m*a)-polyval(C,int(n)+m*a));
        end
    end
end

