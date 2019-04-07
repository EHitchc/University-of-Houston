function [ xval ] = Intersections( C , xvariable )
%Function "Intersections" finds all the intersections between F1 and F2
%in the domain and returns these values in a vector
    disp('Function "Intersections" finds all the intersections between F1 and F2 in the domain and returns these values in a vector');
    n=1;
    for b = 1:length(xvariable)
        %Make sure the function only looks for intersection points within
        %the domain
        if fzero(@(x) MyFun(x)-polyval(C,x), xvariable(b))>xvariable(1) && fzero(@(x) MyFun(x)-polyval(C,x), xvariable(b))<xvariable(length(xvariable))
            xval(n) = fzero(@(x) MyFun(x)-polyval(C,x), xvariable(b));
            n = n+1;
        end
    end
    
    %To eliminate repeat variables use round and unique
    disp(' '), disp('To eliminate repeat variables use round (I have rounded to 5 decimal places) and unique');
    xval=round(xval,5);
    xval=unique(xval);
end

