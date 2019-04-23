%This program runs a simulation of the SIR model on a network. The model
%parameters are as follows:
%       A - the adjacency matrix of the network
%       I - the initial number of infected individuals
%       p - probability of transmission
%       rec-day - number of recovery days
%       day - number of observation days
%       'SIR' or 'SIS' - indication of whether the model is SIR or SIS
%
%Code written by Mark Jayson Cortez for MATH 4315 UH.
%
%Illustration: [a b c]=epidemic(A,8,0.2,3,20,'SIR')
%
%The output is a set of vectors [nS nI nR] which records the number of
%susceptible, infected, and recovered individuals respectively. It also
%creates a movie which visualizes the dynamics.

function [nS nI nR]=epidemic(A,I,p,rec_day,day,type)
%%%%%%%%%%Initialization%%%%%%%%%%
N=length(A);
m=max(degree(graph(A)));
Infect=randperm(N,I);
att=zeros(2,N);
susceptible=zeros(N,m);
    for i=1:N
        if ismember(i,Infect)
        att(1,i)=1;    
        end    
    end

v = VideoWriter('record.avi');
v.FrameRate=10
open(v);

set(gca,'nextplot','replacechildren');
    for k=1:day 
    [infected recovered]=find_status(att,N);
    nI(k)=length(infected);
    nR(k)=length(recovered);
    nS(k)=N-nI(k)-nR(k);

        g=graph(A);
        h=plot(g,'layout','force');
        highlight(h,infected,'NodeColor','r')
        highlight(h,recovered,'NodeColor','g')
        M=getframe; 
        writeVideo(v,M);

    %%%%%%adjust number of days of infection
    for i=1:N
       if ismember(i,infected)
       att(2,i)=att(2,i)+1;    
       end    
    end
    
    susceptible=find_susceptible(susceptible,infected,att,A,N);
    
    %%%%%%disease transmission
    for i=1:N
        for j=1:m
            if not(susceptible(i,j)==0)
                if rand<p & att(1,susceptible(i,j))==0
                att(1,susceptible(i,j))=1;
                end
            end    
        end
    end
    
    %%%%%%recovery of those infected
    [infected recovered]=find_status(att,N);
    for i=1:N
       if ismember(i,infected) & att(2,i)==rec_day
            if type=='SIR'
            att(:,i)=[3;0];
            else
            att(:,i)=[0;0];
            end
       end 
    end    
    
    %reset dummy vectors
    infected=[];
    recovered=[];
    susceptible=zeros(N,m);
    end
close(v)  
end












