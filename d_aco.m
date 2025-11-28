% Verifica o diâmetro de aço comercial mais adequado para um arranjo em nFOC
function d = d_aco(As, n_barras)
    diametros_possiveis = [0, 0.01, 0.0125, 0.016, 0.02, 0.025, 0.032];
    for di = diametros_possiveis
        if n_barras*di^2*0.25*pi>=As
            d = di;
            return
        end
    end
    d = NaN;
end