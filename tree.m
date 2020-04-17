close all; clc;

fprintf('\n');
fprintf('*************************************** \n');
fprintf('** Parametric D0L-system simulation  ** \n');
fprintf('*************************************** \n');

while true
    choice = input('Choose an option (a-i): ', 's');
    p = input('Choose mutation rate (0-100):', 's');
    p = str2double(p);
    conf=config(double(choice)-double('a')+1);
    
    figure(1)
    close all;

    string = [create_axiom(conf)];
    
    i = 1;
    while i<conf.iters
        string = iterate_string(string, conf, p);
        i = i +1;
        
        draw_string(string, conf.min);
        pause(0.5);
    end
    
    fprintf('************************ \n');
    fprintf('\n** Do you want more? ** \n');
    fprintf('************************ \n');
end    

function [v] = calc_end(start, direction, length)
    v = [start(1)+length*cos(direction); start(2) + length*sin(direction)];
end

function [axiom] = create_axiom(conf)
    axiom.type = 'A';
    axiom.s = 80;
    axiom.w = conf.w0;
    axiom.d = pi/2;
    axiom.line_start = [0; 0];
    axiom.line_end = calc_end(axiom.line_start, axiom.d, axiom.s);
    axiom.depth = 1;
    axiom.mut = 0;
end

function [mut] = generate_mutation(curr_mut, p)
    mut = curr_mut;
    if mut
        mut = mut + 1;
    else
        if rand*100 < p
            mut = 1;
        end
    end
end

function [left] = create_left(v, c, p)
    left.type = 'A';
    left.line_start = v.line_end;
    left.d = v.d + pi * c.alpha1/180;
    left.s = v.s * c.r1;
    left.line_end = calc_end(left.line_start, left.d, left.s);
    left.w = v.w* c.q^c.e;
    left.depth = v.depth + 1;
    left.mut = generate_mutation(v.mut, p);
end

function [right] = create_right(v, c, p)
    right.type = 'A';
    right.line_start = v.line_end;
    right.d = v.d + pi * c.alpha2/180;
    right.s = v.s * c.r2;
    right.line_end = calc_end(right.line_start, right.d, right.s);
    right.w = v.w * (1-c.q)^c.e;
    right.depth = v.depth + 1;
    right.mut = generate_mutation(v.mut, p);
end

function new_string = iterate_string(string, c, p)
    i=1;
    while i<=length(string)
        v=string(i);
        if strcmp(v.type, 'A') % extend           
            
            if v.s < c.min
                i = i + 1;
                continue;
            end
            
            if v.mut >= 3
                i = i + 1;
                continue;
            end
           
            string(i).type = 'F';  % update real string, not v
            string = [string(1:i) create_left(v,c, p) create_right(v,c, p) string(i+1:end)];
            i = i + 3;
        else
            i = i + 1;
        end
    end
    
    new_string = string;
end

function draw_string(string, min_length)
    for v=string         
        
        if v.s < min_length
            continue;
        end
        
        color = [0 1-0.64^v.depth 1];
        if v.mut
            color = [0 1-0.64^v.depth 0.64^v.mut];
        end
        line([v.line_start(1), v.line_end(1)], ...
             [v.line_start(2), v.line_end(2)], ...
             'color', color, 'linewidth', v.w);
        if v.mut == 3
            % draw fruits
            viscircles([v.line_end(1), v.line_end(2)], v.w/pi, 'Color' ,[1 .64 0]);
        end
    end
end