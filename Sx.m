function Sx = Sx(x, y)
    Sx = 0;
    for i = 1:(length(x)-1)
        si = x(i,1)*y(i+1,1) - x(i+1,1)*y(i,1);
        Sx = Sx+si*(y(i,1)+y(i+1,1));
    end
    Sx = Sx/6;
end