function [indexes] = get_neighbours_index(obj, x, y)
    indexes = [];

    [n,m] = size(obj);
    
    if x>1
        indexes = [ indexes sub2ind([n, m],x-1, y)];
        if y>1
            indexes =[ indexes sub2ind([n, m],x-1, y-1)];
        end
        if y<m
            indexes =[ indexes sub2ind([n, m],x-1, y+1)];
        end
    end

    if x<n
        indexes =[ indexes sub2ind([n, m],x+1, y)];
        if y>1
            indexes =[ indexes sub2ind([n, m],x+1, y-1)];
        end
        if y<m
            indexes =[ indexes sub2ind([n, m],x+1, y+1)];
        end
    end

    if y<m
        indexes =[ indexes sub2ind([n, m],x, y+1)];
    end

    if y<m && y>1
        indexes =[ indexes sub2ind([n, m],x, y-1)];
    end
end

        