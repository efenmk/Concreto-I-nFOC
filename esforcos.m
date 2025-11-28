function [N, Mx, My, Nc, Mcx, Mcy] = esforcos(e0, kx, ky, n_barras, n_arestas, diametro_aco, x, y, xs, ys, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de)
    h = max(y)-min(y);

    % Contribuição do aço
    Ns = 0;
    Msx = 0;
    Msy = 0;

    for i = 1:n_barras
        ei = e0 + ky*xs(i,1)-kx*ys(i,1);
        Ns = Ns + sigmasi(ei, fyd, epsilonyd)*(pi*0.25*(diametro_aco(i,1))^2);
        Msx = Msx - sigmasi(ei, fyd, epsilonyd)*(pi*0.25*(diametro_aco(i,1))^2)*ys(i,1);
        Msy = Msy + sigmasi(ei, fyd, epsilonyd)*(pi*0.25*(diametro_aco(i,1))^2)*xs(i,1);
    end
    % Contribuição do concreto
    Nc = 0;
    Mcx = 0;
    Mcy = 0;

    if (abs(kx)*h > tol_k)
        for i = 1:n_arestas
            Nc = Nc + (x(i+1,1)- x(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 1, tol_de, i);
            Mcx = Mcx - (x(i+1,1) - x(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 3, tol_de, i);
            Mcy = Mcy + (x(i+1,1) - x(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 4, tol_de, i);
        end

        Nc = Nc/kx;
        Mcx = Mcx/kx;
        Mcy = Mcy/kx;
    elseif (abs(ky)*h > tol_k)
        for i = 1:n_arestas
            Nc = Nc + (y(i+1,1)- y(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 1, tol_de, i);
            Mcx = Mcx - (y(i+1,1) - y(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 2, tol_de, i);
            Mcy = Mcy + (y(i+1,1) - y(i,1))*funcoes_f(x, y, e0, kx, ky, sigmacd, epsilonc2, n, 5, tol_de, i);
        end

        Nc = Nc/ky;
        Mcx = Mcx/ky;
        Mcy = Mcy/ky;
    else
        Nc = sigmac(e0, epsilonc2, sigmacd, n)*Ac(x, y);
        Mcx = sigmac(e0, epsilonc2, sigmacd, n)*Sx(x, y);
        Mcy = sigmac(e0, epsilonc2, sigmacd, n)*Sy(x, y);
    end

    N = Nc + Ns;
    Mx = Mcx + Msx;
    My = Mcy + Msy;
end