function Iyy = Iyy(x, y)
    Iyy = 0;
    for i = 1:length(x)-1
        a_i = x(i,1)*y(i+1,1) - x(i+1,1)*y(i,1);
        Iyy = Iyy + a_i*((x(i,1))^2 + x(i,1)*x(i+1,1) + (x(i+1,1))^2);
    end
    
    Iyy = Iyy/12;
end