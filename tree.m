close all; clc;

fprintf('\n');
fprintf('*************************************** \n');
fprintf('** Parametric D0L-system simulation  ** \n');
fprintf('*************************************** \n');

while true
    choice = input('Choose an option (a-i): ', 's');
    conf=config(double(choice)-double('a')+1);
    
    figure(1)
    close all;

    string = [create_axiom(conf)];
    
    i = 1;
    while i<conf.iters
        string = iterate_string(string, conf);
        i = i +1;
        
        draw_string(string);
        pause(1);
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
end

function [left] = create_left(v, c)
    left.type = 'A';
    left.line_start = v.line_end;
    left.d = v.d + pi * c.alpha1/180;
    left.s = v.s * c.r1;
    left.line_end = calc_end(left.line_start, left.d, left.s);
    left.w = v.w* c.q^c.e;
    left.depth = v.depth + 1;
end

function [right] = create_right(v, c)
    right.type = 'A';
    right.line_start = v.line_end;
    right.d = v.d + pi * c.alpha2/180;
    right.s = v.s * c.r2;
    right.line_end = calc_end(right.line_start, right.d, right.s);
    right.w = v.w * (1-c.q)^c.e;
    right.depth = v.depth + 1;
end

function new_string = iterate_string(string, c)
    i=1;
    while i<=length(string)
        v=string(i);
        if strcmp(v.type, 'A') % extend           
            
            if v.s < c.min
                break;
            end
           
            string(i).type = 'F';  % update real string, not v
            string = [string(1:i) create_left(v,c) create_right(v,c) string(i+1:end)];
            i = i + 3;
        else
            i = i + 1;
        end
    end
    
    new_string = string;
end

function draw_string(string)
    for v=string
        line([v.line_start(1), v.line_end(1)], ...
             [v.line_start(2), v.line_end(2)], ...
             'color', [0 1-0.65^v.depth 1], 'linewidth', v.w);
    end
end