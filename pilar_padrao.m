%% Verificação pelo método do Pilar Padrão | Concreto I | Antônio Garcia
function pilar_padrao(classe_concreto, classe_aco, gamac, gamas, diametro_aco, x, y, xs, ys, Nd, e, z)
    % Adequa as coordenadas ao CG
    [x, y, xs, ys] = translacao_cg(x, y, xs, ys); 
    
    % Parâmetros dos materiais
    [sigmacd, epsilonc2, epsiloncu, n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas);

    % Tolerância e incremento
    tol = 1e-10;
    incremento = 1e-5;
    
    le = 2*z;
    c = (le/pi)^2;
    
    % Processo iterativo
    M = 0;
    j = 1;
    % e0 = zeros(100000,1);
    % k = zeros(100000,1);
    % curv = zeros(100000,1);
    % Mr = zeros(100000,1);

    falha = false;
    while falha == false
        [elu, ~, e0(j), k(j), ~] = verificacao_nFOC(classe_concreto, classe_aco, x, y, xs, ys, diametro_aco, gamac, gamas, Nd, -M, 0);
        if elu == false && M>=e*Nd
            falha = true;
        else
            curv(j) = -k(j)/1000;
            Mr(j) = M;
            M = M + incremento;
            j = j+1;
        end
    end

    n = j - 1;
    curv = curv(1:n);
    Mr   = Mr(1:n);
    e0   = e0(1:n);
    k    = k(1:n);

    Me = Nd*(e + c*curv);

    plot(curv, Mr, 'g', curv, Me, 'b')
    xlabel("1/r em 1/m")
    ylabel("M em MN.m")
    title("Curvas momento-curvatura")

    [diff, i] = min(abs(Me-Mr));

    if diff <= 1e-3
        f = c*curv(i);
        fprintf("A flecha vale %f m. \n", f);
        fprintf("Distribuição de deformações na seção de base: e0 = %f, k = %f 1/m. \n", e0(i), -k(i));
    else
        fprintf("O pilar não se equilibra.")
    end
end