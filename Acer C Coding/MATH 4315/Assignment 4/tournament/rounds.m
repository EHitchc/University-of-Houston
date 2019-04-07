%MA40128 Game Theory Project- G.Taylor
function r=rounds(p)
%computes a number of rounds, assuming that the chance of a next round is
%always p. Clearly, breaks if p is 1 or more.
%Axelrod value for p is 0.99654
r=1;
x=rand(1);
while(x<p)
    r=r+1;
    x=rand(1);
end
