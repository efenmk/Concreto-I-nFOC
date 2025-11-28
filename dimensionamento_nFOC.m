%% Dimensionamento de área de aço de seções transversais nFOC | Concreto I | Antônio Garcia
function [At, d, e0, kx, ky] = dimensionamento_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, gamac, gamas, Nd, Mxd, Myd)
    % precisão de cálculo e máximo de iterações
    maxiter = 1000;
    prec = 1e-13;
    
    % propriedades da seção
    A = Ac(x_vertices, y_vertices); % área total
    n_barras = length(x_aco);
    Asmin = 0;
    Asmax = 0.04*A;

    % Passos iniciais do algoritmo da bissecção
    diametro_aco = zeros(n_barras); % Caso sem armadura

    [elu, ~, e0, kx, ky] = verificacao_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, diametro_aco, gamac, gamas, Nd, Mxd, Myd);
    if elu == true
        fprintf('DIMENSIONAMENTO COM ÁREA MÍNIMA POSSÍVEL, Área = 0 \n');
        fprintf('configuração de deformações (epsilon0, kx, ky) = (%f,%f,%f)\n', e0, kx,ky);
        d = d_aco(0, n_barras);
        At = 0;
        return
    else
        for i = 1:n_barras
            diametro_aco(i) = sqrt((Asmax)/(0.25*pi*n_barras));
        end
        [elu, ~, e0, kx, ky] = verificacao_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, diametro_aco, gamac, gamas, Nd, Mxd, Myd);
        if elu == false
            fprintf('DIMENSIONAMENTO COM ÁREA MÁXIMA IMPOSSÍVEL! Não há dimensionamento adequado');
            d = NaN;
            At = NaN;
            return
        end
    end

    % algoritmo de verificação (bissecção)
    iter = 1;
    Ae = Asmin;
    Ad = Asmax;

    while iter < maxiter
        As = 0.5*(Ae + Ad);
        for i = 1:n_barras
            diametro_aco(i) = sqrt((As)/(0.25*pi*n_barras));
        end
        [elu, ~, e0, kx, ky] = verificacao_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, diametro_aco, gamac, gamas, Nd, Mxd, Myd);
        if elu
            Ad = As; % novo limite superior (resiste)
        else
            Ae = As; % novo limite inferior (não resiste)
        end
        if abs(Ad - Ae) <= prec
            At = Ad; % sempre pegar o superior, a favor da segurança
            fprintf('DIMENSIONAMENTO POSSÍVEL, Área teórica = %f cm^2! \n', At*1e4);
            d = d_aco(At, n_barras);
            for i = 1:n_barras
                diametro_aco(i) = d;
            end
            [~, ~, e0, kx, ky] = verificacao_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, diametro_aco, gamac, gamas, Nd, Mxd, Myd);
            fprintf('O diâmetro comercial mais próximo é %.4f m\n', d);
            fprintf('Sua configuração de deformações para o diâmetro comercial mais próximo (epsilon0, kx, ky) = (%f,%f,%f)\n', e0, kx, ky);
            return
        end
        iter = iter + 1;
    end
end