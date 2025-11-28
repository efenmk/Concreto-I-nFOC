% Função que calcula os parâmetros dos materiais

function [sigmacd,epsilonc2,epsiloncu,n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas)
    % Parâmetros do concreto
    fck = classe_concreto;
    eta_c = 1; %fator de correção do efeito Rusch
    if (fck>40)
        eta_c=(40/fck)^(1/3);
    end

    sigmacd = eta_c*0.85*fck/gamac; % Multiplicar por eta_c para considerar o efeito rüsch
    n = 2;
    epsilonc2 = 2;
    epsiloncu = 3.5;

    if 50<fck
        epsilonc2 = 2 +0.085*(fck-50)^0.53;
        n = 1.4 + 23.4*((90-fck)/100)^4;
        epsiloncu = 2.6 + 35*(((90-fck)/100)^4);
    end

    % Parâmetros do aço
    Es = 210000;
    fyk = classe_aco*10;
    fyd = fyk/gamas;
    epsilonyd = 1000*fyd/Es;
end