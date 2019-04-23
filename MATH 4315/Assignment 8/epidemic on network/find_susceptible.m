%Subfunction for the SIR network simulation. This finds the number of
%susceptible individuals in the network and saves the node name in a matrix
%
%For example a(i,:) are the individuals which are susceptible to the
%disease if node i is infected.

function a=find_susceptible(susceptible,Infect,att,A,N)
a=susceptible;
for i=1:N
    if ismember(i,Infect)
        count=0;
        for j=1:N
            if A(i,j)==1 & att(1,j)==0
            count=count+1;    
            a(i,count)=j;
            end
        end    
    end
end 
end