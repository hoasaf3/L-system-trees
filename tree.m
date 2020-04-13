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
    axiom = [80, conf.w0];

    loc = [0; 0];

    figure(1)
    close all;
    iterate(conf, 1, pi/2, loc, axiom(1), axiom(2), p, 0);
    
    fprintf('************************ \n');
    fprintf('\n** Do you want more? ** \n');
    fprintf('************************ \n')
end    


% i=1;
% iters = conf.iters;
% while i<iters
%     conf.iters = i;
%     %close 1;
%     iterate(conf, 1, pi/2, loc, axiom(1), axiom(2));
%     i = i + 1;
%     pause(0.5);
% end

function [v] = calc_next(loc, angle, length)
    v= [loc(1)+length*cos(angle); loc(2) + length*sin(angle)];
end

function iterate(c, it, d, loc, s, w, p, mut)
    
    if it>c.iters
        return;
    end
    
    if s<c.min
        return;
    end
    
    color = [0 1-0.65^it 1];
    
    if mut
        color = [1, 0.8^mut, 0];
    else  
        if rand*100 < p
            mut=1;
            color = [1, 1, 0];
        end
    end
    
    next_loc = calc_next(loc, d, s);
    line([loc(1), next_loc(1)],[loc(2), next_loc(2)],'color',color, 'linewidth', w);
    loc = next_loc;
    
    if mut > 2^2
        return;
    end
    
    iterate(c, it+1, d + pi * c.alpha1/180, loc, s*c.r1, w*c.q^c.e, p, mut*2);
    iterate(c, it+1, d + pi * c.alpha2/180, loc, s*c.r2, w*(1-c.q)^c.e, p, mut*2);
end