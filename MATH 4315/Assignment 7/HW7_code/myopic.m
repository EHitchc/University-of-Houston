%This function performs a myopic search on a graph with adjacency matrix A.
%The parameters "start" and "target" are specifications of the initial and
%target nodes. These parameters should be valid node numbers, otherwise the
%program fails to compute the shortest path.
%
%Code written by Mark Jayson Cortez for MATH 4315 UH.
%
%Illustration
%Find a path from node 1 to 10 using this search. Execute
%
%myopic(1,10,A)
%
%The output is a graph showing the identified path. 

function h=myopic(start,target,A)
clear s
clear t
N=length(A);
G=graph(A);
d=distances(G);
current=start;
s(1)=start;
k=0;
if ismember(start,[1:N]) & ismember(target,[1:N])
    while current~=target
      k=k+1 ; 
      dummy=10^6;  
      for i=1:N
         if A(current,i)==1 & d(i,target)<dummy
             dummy=d(i,target);
             dcurrent=i;
         end 
      end
      current=dcurrent; 
      t(k)=current;

      %%%Generate a path through the identified nodes
        if current~=target  
        s(k+1)=current;
        end
    end    
    h=plot(G);
    highlight(h,s,t,'Edgecolor','r','LineWidth',1.5);
    disp('The path is given by')
    disp([start t])
    disp(sprintf('The length of the path is %d.',length(s))) 
else
    disp("Invalid input. Start or target node should take valid integral values.")
end    
end    
    



