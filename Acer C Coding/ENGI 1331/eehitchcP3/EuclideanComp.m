function [ MostCompat, LeastCompat, MostCompatSect, LeastCompatSect ] = EuclideanComp( A,B )
%Function "EuclideanComp" finds the most compatible, least compatible, most
%compatible within the student's section and least compatible within the
%student's section using Euclidean.m
    disp('Function "EuclideanComp" finds the most compatible, least compatible, most compatible within the student''s section and least compatible within the student''s section using Euclidean.m'), disp(' ');
    
    %Calculate all distances
    [rows, columns] = size(B);
    b=1;
    for a=1:columns
        if A(1)==B(1,a)
        else
            length(b)=Euclidean(A(2:11),B(2:11,a));
            b=b+1;
        end
    end
    
    %Find most compatible overall
    for a=1:columns
        if Euclidean(A(2:11),B(2:11,a))==min(length)
            MostCompat = B(1,a);
        end
    end
    
    %Find least compatible overall
    for a=1:columns
        if Euclidean(A(2:11),B(2:11,a))==max(length)
            LeastCompat= B(1,a);
        end
    end
    
    %Find distances within section
    c=1;
    for a=1:columns
        if floor(A(1)/100)==floor(B(1,a)/100) && A(1) ~= B(1,a)
            lengthsection(c)=Euclidean(A(2:11),B(2:11,a));
            c=c+1;
        end
    end
    
    %Find most compatible within section
    for a=1:columns
        if Euclidean(A(2:11),B(2:11,a))==min(lengthsection) && floor(A(1)/100)==floor(B(1,a)/100)
            MostCompatSect= B(1,a);
        end
    end
    
    %Find least compatible within section
    for a=1:columns
        if Euclidean(A(2:11),B(2:11,a))==max(lengthsection) && floor(A(1)/100)==floor(B(1,a)/100)
            LeastCompatSect= B(1,a);
        end
    end
end

