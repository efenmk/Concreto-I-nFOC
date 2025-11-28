function Ixx = Ixx(x, y)

    Ixx = 0;
    for i = 1:length(x)-1
        a_i = x(i,1)*y(i+1,1) - x(i+1,1)*y(i,1);
        Ixx = Ixx + a_i*((y(i,1))^2 + y(i,1)*y(i+1,1) + (y(i+1,1))^2);
    end
    
    Ixx = Ixx/12;
end