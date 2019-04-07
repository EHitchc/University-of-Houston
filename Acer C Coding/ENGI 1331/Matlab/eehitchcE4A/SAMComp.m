function [ MostCompat, LeastCompat ] = SAMComp( A,B )
%Function "SAMComp" finds the most compatible and least compatible using SAM.m
    disp('Function "SAMComp" finds the most compatible and least compatible using SAM.m'), disp(' ');
    
    %Calculate all spectral angles
    [rows, columns] = size(B);
    b=1;
    for a=1:rows
        angle(b)=SAM(A,B(a,2:11));
        b=b+1;
    end
    
    %Find most compatible overall
    for a=1:rows
        if SAM(A,B(a,2:11))==min(angle)
            MostCompat = B(a,1);
        end
    end
    
    %Find least compatible overall
    for a=1:rows
        if SAM(A,B(a,2:11))==max(angle)
            LeastCompat= B(a,1);
        end
    end
end

