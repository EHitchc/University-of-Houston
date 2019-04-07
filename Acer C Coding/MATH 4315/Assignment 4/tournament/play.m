%MA40128 Game Theory Project- G.Taylor
%reads in player's own moves, opponents moves and a strategy. 
%Returns 1 to cooperate or 0 to defect.
%r is number of rounds
%Strategies implemented-
% 1= always defect
% 2= always cooperate
% 3= Tit-for-tat
% 4= GRIM (defect forever if opponent ever defects)
% 5= GRIM* (defect forever if opponent ever defects & defect last turn)
% Any other input implements RANDOM- 50% chance of either.
function x=play(player,opp,strategy,r) 
SotonM=[1,0,1,1,0,1,1,1];
SotonS=[0,1,0,0,1,0,0,0];
if(strategy==1) %always defect
    x=0;
elseif(strategy==2) %always cooperate
    x=1;
elseif(strategy==3) %titfortat
    if(length(opp)==0)
        x=1;
    else
        x=opp(length(opp));
    end
elseif(strategy==4) %GRIM
    if(length(opp)==0)
        x=1;
    else
        if(sum(opp)<length(opp))
            x=0;
        else
            x=1;
        end
    end
elseif(strategy==5) %GRIM*
    if(length(opp)==0)
        x=1;
    elseif(length(opp) == (r-1) ) %defect on last round
        x=0;
    else
        if(sum(opp)<length(opp))
            x=0;
        else
            x=1;
        end
    end

else %50/50 
    s=randn;
    if(s<0)
        x=0;
    else
        x=1;
    end
end