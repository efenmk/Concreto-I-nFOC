%% Cálculo da área de concreto em nFOC | Concreto I | Antônio Garcia
function Ac = Ac (x, y)
    Ac = 0;
    for i = 1:(length(x)-1)
        ai = x(i,1)*y(i+1,1)-x(i+1,1)*y(i,1);
        Ac = Ac+ai;
    end
    Ac = Ac/2;
end