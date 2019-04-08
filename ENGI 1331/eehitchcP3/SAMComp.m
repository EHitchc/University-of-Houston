function [ MostCompat, LeastCompat, MostCompatSect, LeastCompatSect ] = SAMComp( A,B )
%Function "SAMComp" finds the most compatible, least compatible, most
%compatible within the student's section and least compatible within the
%student's section using SAM.m
    disp('Function "SAMComp" finds the most compatible, least compatible, most compatible within the student''s section and least compatible within the student''s section using SAM.m'), disp(' ');
    
    %Calculate all spectral angles
    [rows, columns] = size(B);
    b=1;
    for a=1:columns
        if A(1)==B(1,a)
        else
            angle(b)=SAM(A(2:11),B(2:11,a));
            b=b+1;
        end
    end
    
    %Find most compatible overall
    for a=1:columns
        if SAM(A(2:11),B(2:11,a))==min(angle)
            MostCompat = B(1,a);
        end
    end
    
    %Find least compatible overall
    for a=1:columns
        if SAM(A(2:11),B(2:11,a))==max(angle)
            LeastCompat= B(1,a);
        end
    end
    
    %Find angles within section
    c=1;
    for a=1:columns
        if floor(A(1)/100)==floor(B(1,a)/100) && A(1) ~= B(1,a)
            anglesection(c)=SAM(A(2:11),B(2:11,a));
            c=c+1;
        end
    end
    
    %Find most compatible within section
    for a=1:columns
        if SAM(A(2:11),B(2:11,a))==min(anglesection) && floor(A(1)/100)==floor(B(1,a)/100)
            MostCompatSect= B(1,a);
        end
    end
    
    %Find least compatible within section
    for a=1:columns
        if SAM(A(2:11),B(2:11,a))==max(anglesection) && floor(A(1)/100)==floor(B(1,a)/100)
            LeastCompatSect= B(1,a);
        end
    end
end

