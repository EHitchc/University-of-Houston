function [ angle ] = SAM( A,B )
%Function "SAM" calculates the spectral angle between vectors A and B
    angle = acos(dot(A,B)/(norm(A)*norm(B)));
end

