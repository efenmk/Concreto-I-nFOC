%% Verificação de estabilidade de um pilar pelo método de diferenças finitas | Concreto I | Antônio Garcia
function [verificacao, f, j, yi, z_nodes, e0crit, kcrit] = verifica_pilar(classe_concreto, classe_aco, gamac, gamas, Nd, Md, diametro_aco, x, y, xs, ys, m, z, prec)

    [x, y, xs, ys] = translacao_cg(x, y, xs, ys); % Adequa as coordenadas ao CG
    
    dL = z/m; % comprimento de cada subdivisão do pilar
    z_nodes = (1:m)'*dL;

    %% Passo 1
    f = 0; % valor inicialmente atribuído para a flecha
    e = Md/Nd; % excentricidade de Nd

    maxiter = 100;
    j = 1;

    while j<maxiter
        yi = zeros(m,1);
        %% Passo 2
        Md = Nd*(e+f);
        [elu, ~, e0, k, ~] = verificacao_nFOC(classe_concreto, classe_aco, x, y, xs, ys, diametro_aco, gamac, gamas, Nd, -Md, 0);
        e0crit = e0; % A cada iteração igualamos e0 e kappa da seção 1 à e0 e kappa críticos, que são por vezes solicitados em exercícios
        kcrit = -k;
        if elu == 0
            verificacao = 0;
            f = NaN;
            return;
        end
        
        %% Passos 3 e 4
        % caso y1
        curv = -k/1000;
        yi(1,1) = curv*dL^2/2;
        Md = Nd*(e+f-yi(1));
        [elu, ~, e0, k, ~] = verificacao_nFOC(classe_concreto, classe_aco, x, y, xs, ys, diametro_aco, gamac, gamas, Nd, -Md, 0);
        if elu == 0
            verificacao = 0;
            f = NaN;
            return;
        end

        %caso y2
        curv = -k/1000;
        yi(2,1) = curv*dL^2 +2*yi(1);
        Md = Nd*(e+f-yi(2));
        [elu, ~, e0, k, ~] = verificacao_nFOC(classe_concreto, classe_aco, x, y, xs, ys, diametro_aco, gamac, gamas, Nd, -Md, 0);
        if elu == 0
            verificacao = 0;
            f = NaN;
            return;
        end

        i = 3; % contador que percorre a discretização do pilar (3 até m)
        while i<=m
            curv = -k/1000;
            yi(i, 1) = dL^2*curv+2*(yi(i-1, 1))-yi(i-2, 1);
            Md = Nd*(e+f-yi(i));
            [elu, ~, e0, k, ~] = verificacao_nFOC(classe_concreto, classe_aco, x, y, xs, ys, diametro_aco, gamac, gamas, Nd, -Md, 0);
            if elu == 0
                verificacao = 0;
                f = NaN;
                return;
            end
            i = i+1;
        end

        if abs(f-yi(m,1))<=prec
            verificacao = 1;
            return;
        else
            f = yi(m,1);
            j = j+1;
        end
    end
    verificacao = 0;  % não convergiu dentro do máximo de iterações
    f = NaN;
end