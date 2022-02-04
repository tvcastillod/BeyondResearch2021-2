function [next, step] = move(particlePositions, pos, dir)
    if (dir == 'left')
        if pos > 1
            if particlePositions(pos-1) ~= 1
                next = pos - 1;
                step = -1;
            else
                next = pos;
                step = 0;
            end
        else
            if particlePositions(size(particlePositions,2)) ~= 1
                next = size(particlePositions,2); % move to the end
                step = size(particlePositions,2)-1; 
            else
                next = pos;
                step = 0;
            end
        end
    else
        if pos < size(particlePositions,2)
            if particlePositions(pos+1) ~= 1
                next = pos + 1;
                step = 1;
            else
                next = pos;
                step = 0;
            end
        else
            if particlePositions(1) ~= 1
                next = 1; % move to the beginning
                step = -size(particlePositions,2)+1;
            else
                next = pos;
                step = 0;
            end
        end
    end
end