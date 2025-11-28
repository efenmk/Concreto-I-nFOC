function [J] = potencial_J(x,sigma_cd,e_c2,n,m)

if (m==1)
    if(x < 0)
        J = 0;
    else
        J = 0.5*x^2 - (e_c2)^2*(tk(x,e_c2,n,1) - tk(x,e_c2,n,2));
    end
elseif (m==2)
    if(x < 0)
        J = 0;
    else
        J = (1/3)*x^3 - (e_c2)^3*(tk(x,e_c2,n,1) - 2*tk(x,e_c2,n,2) + tk(x,e_c2,n,3));
    end
end

    J = sigma_cd*J;
end