clc, clear all, close all;
waldo_full = imread('whereswaldo_big.jpg');
waldo = imread('whereswaldo.jpg');

[waldo_rows, waldo_columns, waldo_depth] = size(waldo);
[rows, columns, depth] = size(waldo_full);

error=0;
for i=1:rows-waldo_rows
    for j=1:columns-waldo_columns
        if waldo_full(i,j,:) == waldo(1,1,:)
            if waldo_full(i:i+waldo_rows-1,j:j+waldo_columns-1,:) == waldo
                error = 1;
                break
            end
        end
    end
    if error == 1
        break
    end
end

waldo_full(i:i+waldo_rows-1,j:j+waldo_columns-1,:) = 0;
image(waldo_full);