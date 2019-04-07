function [count_similar, count_different] = similarity(A, x, y)
    count_similar = zeros(x,y);
    count_different = zeros(x,y);
    for j=1:x
        for k=1:y
            current_agent = A(j,k);
            neighbours_index = get_neighbours_index(A,j,k);
            for i=1:1:length(neighbours_index)
                if current_agent == A(neighbours_index(i))
                    count_similar(j,k) = count_similar(j,k) + 1;
                else
                    count_different(j,k) = count_different(j,k) + 1;
                end
            end
        end
    end
end
