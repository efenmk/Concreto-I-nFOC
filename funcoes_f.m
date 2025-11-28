function [f] = funcoes_f(x,y,e0,kappa_x,kappa_y,sigma_cd,e_c2,n,m,tol_delta_e,i)

delta_xi = x(i+1,1) - x(i,1);
delta_yi = y(i+1,1) - y(i,1);

ei = e0 + kappa_y*x(i,1) - kappa_x*y(i,1);
ei_1 = e0 + kappa_y*x(i+1,1) - kappa_x*y(i+1,1);
delta = ei_1 - ei;

hi = x(i,1)*ei_1 - x(i+1,1)*ei;
gi = y(i,1)*ei_1 - y(i+1,1)*ei;

sigma_i = sigmac(ei, e_c2, sigma_cd, n);

switch m
    case 1
        if (abs(delta) < tol_delta_e)
            f = potencial_I(ei,sigma_cd,e_c2,n,1);
        else
            f = (potencial_I(ei_1,sigma_cd,e_c2,n,2)-potencial_I(ei,sigma_cd,e_c2,n,2))/delta;
        end
    case 2
        if (abs(delta) < tol_delta_e)
            f = potencial_I(ei,sigma_cd,e_c2,n,1)*(y(i,1) + y(i+1,1))/2;
        else
            f = (1/delta^2)*(gi*(potencial_I(ei_1,sigma_cd,e_c2,n,2)- potencial_I(ei,sigma_cd,e_c2,n,2)) + delta_yi*(potencial_K(ei_1,sigma_cd,e_c2,n,1) - potencial_K(ei,sigma_cd,e_c2,n,1)));
        end
    case 3
        if (abs(delta) < tol_delta_e)
            f = funcoes_f(x,y,e0,kappa_x,kappa_y,sigma_cd,e_c2,n,2,tol_delta_e,i) + potencial_I(ei,sigma_cd,e_c2,n,2)/kappa_x;
        else
            f = funcoes_f(x,y,e0,kappa_x,kappa_y,sigma_cd,e_c2,n,2,tol_delta_e,i) + (1/kappa_x)*(potencial_I(ei_1,sigma_cd,e_c2,n,3)- potencial_I(ei,sigma_cd,e_c2,n,3))/delta;
        end
    case 4
        if (abs(delta) < tol_delta_e)
            f = potencial_I(ei,sigma_cd,e_c2,n,1)*(x(i,1) + x(i+1,1))/2;
        else
            f = (1/delta^2)*(hi*(potencial_I(ei_1,sigma_cd,e_c2,n,2)- potencial_I(ei,sigma_cd,e_c2,n,2)) + delta_xi*(potencial_K(ei_1,sigma_cd,e_c2,n,1) - potencial_K(ei,sigma_cd,e_c2,n,1)));
        end
    case 5
        if (abs(delta) < tol_delta_e)
            f = funcoes_f(x,y,e0,kappa_x,kappa_y,sigma_cd,e_c2,n,4,tol_delta_e,i) - potencial_I(ei,sigma_cd,e_c2,n,2)/kappa_y;
        else
            f = funcoes_f(x,y,e0,kappa_x,kappa_y,sigma_cd,e_c2,n,4,tol_delta_e,i) - (1/kappa_y)*(potencial_I(ei_1,sigma_cd,e_c2,n,3)- potencial_I(ei,sigma_cd,e_c2,n,3))/delta;
        end
    case 6
        if (abs(delta) < tol_delta_e)
            f = sigma_i;
        else
            f = (potencial_I(ei_1,sigma_cd,e_c2,n,1)-potencial_I(ei,sigma_cd,e_c2,n,1))/delta;
        end
    case 7
        if (abs(delta) < tol_delta_e)
            f = sigma_i*(y(i,1) + y(i+1,1))/2;
        else
            f = (1/delta^2)*(gi*(potencial_I(ei_1,sigma_cd,e_c2,n,1)- potencial_I(ei,sigma_cd,e_c2,n,1)) + delta_yi*(potencial_J(ei_1,sigma_cd,e_c2,n,1) - potencial_J(ei,sigma_cd,e_c2,n,1)));
        end
    case 8
        if (abs(delta) < tol_delta_e)
            f = sigma_i*(x(i,1) + x(i+1,1))/2;
        else
            f = (1/delta^2)*(hi*(potencial_I(ei_1,sigma_cd,e_c2,n,1)- potencial_I(ei,sigma_cd,e_c2,n,1)) + delta_xi*(potencial_J(ei_1,sigma_cd,e_c2,n,1) - potencial_J(ei,sigma_cd,e_c2,n,1)));
        end
    case 9
        if (abs(delta) < tol_delta_e)
            f = sigma_i*(y(i,1)^2 + y(i,1)*y(i+1,1) + y(i+1,1)^2)/3;
        else
            f = (1/delta^3)*(gi^2*(potencial_I(ei_1,sigma_cd,e_c2,n,1)- potencial_I(ei,sigma_cd,e_c2,n,1)) + 2*gi*delta_yi*(potencial_J(ei_1,sigma_cd,e_c2,n,1) - potencial_J(ei,sigma_cd,e_c2,n,1))+ delta_yi^2*(potencial_J(ei_1,sigma_cd,e_c2,n,2) - potencial_J(ei,sigma_cd,e_c2,n,2)));
        end
    case 10
        if (abs(delta) < tol_delta_e)
            f = sigma_i*(x(i,1)*y(i+1,1) + 2*(x(i,1)*y(i,1) + x(i+1,1)*y(i+1,1)) + x(i+1,1)*y(i,1))/6;
        else
            f = (1/delta^3)*(hi*gi*(potencial_I(ei_1,sigma_cd,e_c2,n,1)- potencial_I(ei,sigma_cd,e_c2,n,1)) + (gi*delta_xi + hi*delta_yi)*(potencial_J(ei_1,sigma_cd,e_c2,n,1) - potencial_J(ei,sigma_cd,e_c2,n,1))+ delta_yi*delta_xi*(potencial_J(ei_1,sigma_cd,e_c2,n,2) - potencial_J(ei,sigma_cd,e_c2,n,2)));
        end
    case 11
        if (abs(delta) < tol_delta_e)
            f = sigma_i*(x(i,1)^2 + x(i,1)*x(i+1,1) + x(i+1,1)^2)/3;
        else
            f = (1/delta^3)*(hi^2*(potencial_I(ei_1,sigma_cd,e_c2,n,1)- potencial_I(ei,sigma_cd,e_c2,n,1)) + 2*hi*delta_xi*(potencial_J(ei_1,sigma_cd,e_c2,n,1) - potencial_J(ei,sigma_cd,e_c2,n,1))+ delta_xi^2*(potencial_J(ei_1,sigma_cd,e_c2,n,2) - potencial_J(ei,sigma_cd,e_c2,n,2)));
        end
end