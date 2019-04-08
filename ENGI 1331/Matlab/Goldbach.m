function[sequence] = Goldbach(n)
    if size(n)==[1,1] & n>=0 & rem(n,1)==0
        sequence(1)=n;
        i=2;
        while n~=1
            if rem(n,1)==0 && n>=0 && rem(n,2)==0
                n=n./2;
                sequence(i)=n;
                i=i+1;
            elseif rem(n,1)==0 && n>=0 && rem(n,2)==1
                n=n.*3+1;
                sequence(i)=n;
                i=i+1;
            end
        end
    else
        sequence = [];
    end
    
end