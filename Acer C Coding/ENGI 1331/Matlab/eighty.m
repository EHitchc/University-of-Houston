clc
clear
Temps=load('temperatures.txt')
[nweeks,ndays]=size(Temps);
%outer loop initilization
found=0;
%outer loop control
for week=1:nweeks
    week
%outer loop body--inner loop initialization
count=0;
%outer loop body --inner loop control
for day=1:ndays
    week
    day
    pause
    %outer loop body -- innerloop body
    if Temps(week,day)>80
        count=count+1;
    end
end
%outer loop body -inner loop cleanup check count
if count>=3
    found=1;
    weeknumber=week;
    break;
end
end

outer loop cleanup
if found
    disp('1st week over 80 three times is   ')
    disp(weeknumber)
else
    disp('no weeks three days over 80')
end