%MA40128 Game Theory Project- G.Taylor
%Wrapper for play.m, runs an iterated prisoner's dilemma 
%(or any symmetric 2 player, 2 option strategic form game between two
%players whose strategies are p1strat and p2strat
%(as interpreted by play.m, see that function's help file). 
%Play is for r rounds, with payout being based on the matrix 'payoff'
%[1,4;0,3] gives the weightings used in my report.
%Returns four arguments- the two lists of strategies (0=defect, 1=coop)
%and the two scores.  
function [X,Y,Xscore,Yscore]=iteratedpd(r,p1strat,p2strat,payoff)
mdefect=payoff(1,1);
mcoop=payoff(2,2);
suckerwin=payoff(1,2);
suckerlose=payoff(2,1);
X=[];
Y=[];
Xscore=0;
Yscore=0;
for i=1:r
    newX=play(X,Y,p1strat,r);
    newY=play(Y,X,p2strat,r);
    X=[X,newX];
    Y=[Y,newY];
    if(newX==0) %P1 defect
        if(newY==0)
            Xscore=Xscore+mdefect;
            Yscore=Yscore+mdefect;
        else
            Xscore=Xscore+suckerwin;
            Yscore=Yscore+suckerlose;
        end
    else %P1 cooperate
        if(newY==0)
            Xscore=Xscore+suckerlose;
            Yscore=Yscore+suckerwin;
        else
            Xscore=Xscore+mcoop;
            Yscore=Yscore+mcoop;
        end
    end
end

    