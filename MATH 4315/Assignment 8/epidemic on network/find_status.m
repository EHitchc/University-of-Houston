%Subfunction for the SIR network simulation. This finds the infected and
%recovered individuals in the network and saves the node name in the
%vectors a and b respectively.

function [a b]=find_status(att,N)
a=[];
b=[];
for i=1:N
    if att(1,i)==1
    a=[a, i];
    elseif att(1,i)==3 
    b=[b, i];    
    end
end
end