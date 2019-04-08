function [plocations] = Peaks(elevations)
    [y,x] = size(elevations);
    counter=1;
    for i=2:y-1
        for j=2:x-1
            if elevations(i,j)>(elevations(i-1,j)+100) && elevations(i,j)>(elevations(i+1,j)+100) && elevations(i,j)>(elevations(i,j-1)+100) && elevations(i,j)>(elevations(i,j+1)+100)
                plocations(counter,:) = [i;j];
                counter = counter + 1;
            end
        end
    end
end