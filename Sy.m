function Sy = Sy(x, y)
    Sy = 0;
    for i = 1:(length(x)-1)
        si = x(i,1)*y(i+1,1) - x(i+1,1)*y(i,1);
        Sy = Sy + si*(x(i,1)+x(i+1,1));
    end
    Sy = Sy/6;
end