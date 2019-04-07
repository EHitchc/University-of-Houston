clc; clear; close all;
%MA40128 Game Theory Project- G.Taylor
%Runs an IPD tournament
%Requires a list of players and their strategies as vector Q
%Also requires a value R, the number of rounds
%and a payoff matrix PD
%Creates Z a tournament table
% and Scores a list of total scores 
%R=rounds(0.99654) %Use this for a tournament of random length
R=200;
Q=[1, 2, 3, 5] 
PD=[1,4;0,3]; %[defect, suckerwin; suckerlose, coop]
n=length(Q);
Z=zeros(n,n);
for i=1:n
    for j=1:n
        [A,B,a,b]=iteratedpd(R,Q(i),Q(j),PD);
        Z(i,j)=a;
    end
end
Z
for i=1:n
    Scores(i)=sum(Z(i,1:n));
end
Scores
