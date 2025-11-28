function [I] = potencial_I(x,sigma_cd,e_c2,n,m)

if (m==1)
    if(x < 0)
        I = 0;
    else
        I = x - e_c2*tk(x,e_c2,n,1);
    end
elseif (m==2)
    if(x < 0)
        I = 0;
    else
        I = 0.5*x^2 - (e_c2/(n + 1))*(x - e_c2*tk(x,e_c2,n,2));
    end
elseif(m==3)
    if(x < 0)
        I = 0;
    else
        I = (1/6)*x^3 - (e_c2/(n + 1))*(0.5*x^2 - (e_c2/(n + 2))*(x - e_c2*tk(x,e_c2,n,3)));
    end
end

    I = sigma_cd*I;
end