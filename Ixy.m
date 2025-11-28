function Ixy = Ixy(x, y)

    Ixy = 0;
    for i = 1:length(x)-1
        a_i = x(i,1)*y(i+1,1) - x(i+1,1)*y(i,1);
        Ixy = Ixy + a_i*(x(i,1)*y(i+1,1) + 2*(x(i,1)*y(i,1) + x(i+1,1)*y(i+1,1)) + x(i+1,1)*y(i,1));
    end
    
    Ixy = Ixy/24;
end