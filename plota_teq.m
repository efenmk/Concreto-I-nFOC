%% Plotagem da trajetória de equilíbrio para uma excentricidade fixa | Concreto I | Antônio Garcia
function plota_teq(classe_concreto, classe_aco, gamac, gamas, e, diametro_aco, x, y, xs, ys, m, z, prec)
    
    [sigmacd, ~, ~, ~, fyd, ~] = parametros(classe_concreto, classe_aco, gamac, gamas);
    A_c = Ac(x, y);
    Ast = sum(pi * diametro_aco.^2 / 4);
    Nmax = sigmacd*A_c + fyd*Ast;

    % Inicialização do algoritmo
    n_passos = 10;
    deltaN = Nmax/n_passos;
    i = 1;
    Nd(i) = 0;
    Md(i) = 0;
    N = 0;
    tol = 1e-10;
    cont = 1;
    while deltaN/Nmax >= tol
        for i=2:n_passos
            cont = cont + 1;
            N = N + deltaN;
            [verificacao, f, ~, ~, ~] = verifica_pilar(classe_concreto, classe_aco, gamac, gamas, N, e*N, diametro_aco, x, y, xs, ys, m, z, prec);
            if verificacao == true
                Nd(cont) = N;
                Md(cont) = N*(e+f);
                Ncr = Nd(cont);
            else
                fprintf("Aqui");
                break
            end
        end
        cont = cont-1;
        N = N-deltaN;
        deltaN = deltaN/10;
    end

    fprintf("Para a excentricidade %f m, a carga crítica é %f NM.", e, Ncr);
    % Plotagem  
    figure;
    plot(Nd(1:cont), Md(1:cont));
    xlabel('Força normal');
    ylabel('Momento');
    title('Trajetória de equilíbrio para uma excentricidade fixa');
    grid on;
end