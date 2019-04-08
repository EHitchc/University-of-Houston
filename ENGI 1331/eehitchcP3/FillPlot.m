function [ ] = FillPlot( C,x_int )
%Function "Fillplot" fills in the areas between F1 and F2 with a colour
    disp(' '), disp('Function "Fillplot" fills in the areas between F1 and F2 with a colour');
    hold on;
    indexedcolours = 'rgbymck';
    b=1;
    for a=1:length(x_int)-1
        x_area=[x_int(a):.05:x_int(a+1)];
        x_fill=[x_area, fliplr(x_area)];
        y1_area=polyval(C,x_area);
        y2_area=MyFun(x_area);
        y_fill=[y1_area, fliplr(y2_area)];
        fill(x_fill,y_fill, indexedcolours(b));
        
        %check to restart colour string or move to next colour
        if b<7
            b=b+1;
        elseif b==7
            b=1;
        end
    end
    hold off;
end

