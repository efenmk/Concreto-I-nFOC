%% Verificação seções transversais nFOC | Concreto I | Antônio Garcia
function [elu, verificacao, e0, kx, ky] = verificacao_nFOC(classe_concreto, classe_aco, x_vertices, y_vertices, x_aco, y_aco, diametro_aco, gamac, gamas, Nd, Mxd, Myd)
    % Geometria da seção
    n_arestas = length(x_vertices)-1;
    A_c = Ac(x_vertices, y_vertices);
    h = max(y_vertices)-min(y_vertices);
    n_barras = length(x_aco);

    % Adequação da circuição
    if Ac(x_vertices, y_vertices)<0
        flip(x_vertives);
        flip(y_vertices);
    end
    
    % Muda a origem para o CG da seção
    [x_vertices, y_vertices, x_aco, y_aco] = translacao_cg(x_vertices, y_vertices, x_aco, y_aco);
    
    % Tolerâncias para delta epsilon e kappas
    tol_de = 1e-3;
    tol_k = 1e-3;
    
    % Parâmetros dos materiais
    [sigmacd, epsilonc2, epsiloncu, n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas);
    
    % Esforços solicitantes
    gamaf = 1.4;
    
    % Armazenamento de soluções
    jac = false;
    
    % Iterações
    prec = 1e-5;
    maxiter = 100;
    i = 1;
    
    % Tolerância jacobiano
    tol = 1e-10;
    
    f = @(N, Mx, My) sqrt(((Nd-N)/(sigmacd*A_c))^2+((Mxd-Mx)/(sigmacd*A_c*h))^2 +((Myd-My)/(sigmacd*A_c*h))^2);
    
    e0 = 0;
    kx = 0;
    ky = 0;
    
    [N, Mx, My, Nc, Mcx, Mcy]= esforcos(e0, kx, ky, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
    
    while(f(N, Mx, My)>prec && i<=maxiter)
        % resultado = [N, Mx, My, Nc, Mcx, Mcy];
        % disp(resultado);
        % disp(i);
        Jc = jacobiana_concreto(x_vertices, y_vertices, e0, kx, ky, n_arestas, sigmacd, epsilonc2, n, tol_k, tol_de, Nc, Mcx, Mcy);
        Js = jacobiana_aco(x_aco, y_aco, epsilonyd, fyd, diametro_aco, n_barras, e0, kx, ky);
        J = Jc+Js;
        if(abs((1/(sigmacd*A_c*h))^2*det(J))<=tol)
            jac = true;
            break;
        else
            jac = false;
            fx = [Nd-N; Mxd-Mx;Myd-My];
            J_inv_f = inversor_matriz(J, fx);
            dx = -(1/det(J))*J_inv_f;
    
            e0 = e0+dx(1,1);
            kx = kx+dx(2,1);
            ky = ky+dx(3,1);
           
            [N, Mx, My, Nc, Mcx, Mcy]= esforcos(e0, kx, ky, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
        end
        i=i+1;
    end
    
    if(jac == false && f(N, Mx, My)<=prec && i<=maxiter)
        verificacao = 1;
        elu = verificaELU_nFOC(epsiloncu, epsilonc2, x_vertices, y_vertices, x_aco, y_aco, e0, kx, ky);
    else
        verificacao = 0;
        elu = 0;
    end
end