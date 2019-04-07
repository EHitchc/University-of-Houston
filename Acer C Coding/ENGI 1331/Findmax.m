temperature = load('temperatures.txt');
data = load('DATA.TXT');
maximum = -1000;
for n = 1:length(data)
    if data(n)>maximum
        maximum = data(n);
    end
end
[nweeks,ndays]=size(temperature);
found = 0;

for week=1:nweeks
    count =0;
    for day=1:ndays
        if temperature(week,day)>80
            count=count+1;
        end
    end
    if count>3
        week
        found = found+1;
    end
end

found