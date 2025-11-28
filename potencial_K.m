function [K] = potencial_K(x,sigma_cd,e_c2,n,m)

if (m==1)
    if(x < 0)
        K = 0;
    else
        K = (1/3)*x^3 - (e_c2/(n + 1))*(0.5*x^2 - (e_c2)^2*(tk(x,e_c2,n,2) - tk(x,e_c2,n,3)));
    end
end

    K = sigma_cd*K;
end