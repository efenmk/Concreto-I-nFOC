%% Verificação de pilar em Compressão Uniforme | Concreto I | Antônio Garcia
function compressao_uniforme(classe_concreto, classe_aco, gamac, gamas, diametro_aco, x, y, xs, ys, z)
    % Estimativa inicial para epsilon 0
    e0 = 0;
    
    % Parâmetros dos materiais
    [sigmacd, epsilonc2, ~, n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas);

    % Adequação ao CG
    [x, y, xs, ys] = translacao_cg(x, y, xs, ys);
    
    % Comprimento efetivo
    le = 2*z;
    
    % Vetores que armazenam os cálculos de Nr e Ncr
    i = 1;
    
    % Iteração
    while e0<=epsilonc2
        % Cálculo da rigidez à flexão
        EIc = dsigmac(e0, epsilonc2, n, sigmacd)*Ixx(x, y);
        EIs = 0;
        for k = 1:length(xs)
            EIs = EIs + ys(k)^2*diametro_aco(k)^2*0.25*pi;
        end
        EIs = EIs *dsigmasi(e0, epsilonyd, fyd);
        EI = 1000*(EIc+EIs);
        
        % Cálculo da normal crítica
        Ncr(i) = pi^2*EI/(le^2);
        
        % Cálculo da normal a partir da definição
        [Nr(i), ~, ~, ~, ~, ~] = esforcos(e0, 0, 0, length(xs), length(x)-1, diametro_aco, x, y, xs, ys, fyd, epsilonyd, n, sigmacd, epsilonc2, 1e-3, 1e-3);
        e0 = e0 + epsilonc2/10000;
        i = i + 1;
    end
    fprintf("A capacidade resistiva da seção está limitada a Nr = %.4f MN \n", Nr(i-1));
    
    [difference, j] = min(abs(Ncr(1:i-1)-Nr(1:i-1)));
    
    fprintf("A normal crítica da seção é Ncr = %.4f MN", Ncr(j));

end