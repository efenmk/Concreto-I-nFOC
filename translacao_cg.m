function [xt, yt, xst, yst] = translacao_cg(x, y, xs, ys)
    xg = Sy(x, y)/Ac(x,y);
    yg = Sx(x, y)/Ac(x, y);

    xt = x - xg;
    yt = y -yg;
    xst = xs - xg;
    yst = ys - yg;
end