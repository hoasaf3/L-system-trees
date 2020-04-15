function conf = config(index)
    conf_a.alpha1 = 35;
    conf_a.alpha2 = -35;
    conf_a.r1 = .75;
    conf_a.r2 = .77;
    conf_a.w0 = 30;
    conf_a.q = 0.50;
    conf_a.e = .40;
    conf_a.min = 0;
    conf_a.iters = 10;

    conf_b.alpha1 = 27;
    conf_b.alpha2 = -68;
    conf_b.r1 = .65;
    conf_b.r2 = .71;
    conf_b.w0 = 20;
    conf_b.q = 0.53;
    conf_b.e = .50;
    conf_b.min = 1.7;
    conf_b.iters=12;

    conf_c.alpha1 = 25;
    conf_c.alpha2 = -15;
    conf_c.r1 = .50;
    conf_c.r2 = .85;
    conf_c.w0 = 20;
    conf_c.q = 0.45;
    conf_c.e = .50;
    conf_c.min = 0.5;
    conf_c.iters=9;

    conf_d.r1 = .60;
    conf_d.r2 = .85;
    conf_d.alpha1 = 25;
    conf_d.alpha2 = -15;
    conf_d.w0 = 20;
    conf_d.q = .45;
    conf_d.e = .50;
    conf_d.min = 0.0;
    conf_d.iters=10;

    conf_e.r1 = .58;
    conf_e.r2 = .83;
    conf_e.alpha1 = 30;
    conf_e.alpha2 = 15;
    conf_e.w0 = 20;
    conf_e.q = .45;
    conf_e.e = .50;
    conf_e.min = 1.0;
    conf_e.iters=11;

    conf_f.r1 = .92; % fixme: it's ugly without rolling
    conf_f.r2 = .37;
    conf_f.alpha1 = 0;
    conf_f.alpha2 = 60;
    conf_f.w0 = 2;
    conf_f.q = .50;
    conf_f.e = .00;
    conf_f.min = 0.5;
    conf_f.iters=15;

    conf_g.r1 = .80;
    conf_g.r2 = .80;
    conf_g.alpha1 = 30;
    conf_g.alpha2 = -30;
    conf_g.w0 = 30;
    conf_g.q = .50;
    conf_g.e = .50;
    conf_g.min = 0.0;
    conf_g.iters = 10;

    conf_h.r1 = .95;
    conf_h.r2 = .75;
    conf_h.alpha1 = -5;
    conf_h.alpha2 = -30;
    conf_h.w0 = 40;
    conf_h.q = .60;
    conf_h.e = .45;
    conf_h.min = 25.0;
    conf_h.iters = 12;

    conf_i.r1 = .55;
    conf_i.r2 = .95;
    conf_i.alpha1 = -5;
    conf_i.alpha2 = 30;
    conf_i.w0 = 5;
    conf_i.q = .40;
    conf_i.e = .00;
    conf_i.min = 5.0;
    conf_i.iters = 12;

    configs = [conf_a conf_b conf_c conf_d conf_e  conf_f  conf_g  conf_h  conf_i];
    conf = configs(index);
end