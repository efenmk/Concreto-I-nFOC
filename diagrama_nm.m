%Plotagem do diagrama de esforços resultantes
classe_concreto = 90;
classe_aco = 50;
gamac = 1.4;
gamas = 1.15;

tol_k = 1e-3;
tol_de = 1e-3;

% Parâmetros dos materiais
[sigmacd, epsilonc2, epsiloncu, n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas);

% Geometria
x_vertices = [0; 0.2; 0.2; 0; 0];
y_vertices = [0; 0; 0.6; 0.6; 0];
n_arestas = length(x_vertices)-1;
diametro_aco = [0.025; 0.025; 0.025; 0.025; 0.025; 0.025];
x_aco = [0.04; 0.04; 0.04; 0.16; 0.16; 0.16];
y_aco = [0.04; 0.44; 0.56; 0.04; 0.44; 0.56];
n_barras = length(x_aco);
[x_vertices,y_vertices, x_aco, y_aco] = translacao_cg(x_vertices, y_vertices, x_aco, y_aco);

ytopo = max(y_vertices);
ybase = min(y_vertices);
ysmin = min(y_aco);
ysmax = max(y_aco);
h = ytopo-ybase;

A = [0.0 epsilonc2];
B = [epsiloncu/h epsiloncu*ytopo/h];
C = [(epsiloncu+10.0)/(ytopo-ysmin) epsiloncu-ytopo*(epsiloncu+10.0)/(ytopo-ysmin)];
D = [0 -10.0];
E = [(epsiloncu+10.0)/(ybase-ysmax) epsiloncu-ybase*(epsiloncu+10.0)/(ybase-ysmax)];
F = [-epsiloncu/h -epsiloncu*ybase/h];

pontos = 1000;
incremento= 1/(pontos -1);
i = 1;
v=zeros(1000);
u=zeros(1000);
for s = 0:incremento:1
    if s <= 1/6
        c1(1) = A(1);
        c1(2) = A(2);
        ca(1) = 6.0*(B(1)-A(1));
        ca(2) = 6.0*(B(2)-A(2));
        k = ca(1)*s + c1(1);
        epsilon0 = ca(2)*s + c1(2);
        [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
    else 
        if s<= 2/6
            c1(1) = 2.0*B(1)-C(1);
            c1(2) = 2.0*B(2)-C(2);
            ca(1) = 6.0*(C(1)-B(1));
            ca(2) = 6.0*(C(2)-B(2));
            k = ca(1)*s + c1(1);
            epsilon0 = ca(2)*s + c1(2);
            [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
        else 
            if s <= 3/6
                c1(1) = 3.0*C(1)-2.0*D(1);
                c1(2) = 3.0*C(2)-2.0*D(2);
                ca(1) = 6.0*(D(1)-C(1));
                ca(2) = 6.0*(D(2)-C(2));
                k = ca(1)*s + c1(1);
                epsilon0 = ca(2)*s + c1(2);
                [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
            else
                if s <= 4/6
                    c1(1) = 4.0*D(1)-3.0*E(1);
                    c1(2) = 4.0*D(2)-3.0*E(2);
                    ca(1) = 6.0*(E(1)-D(1));
                    ca(2) = 6.0*(E(2)-D(2));
                    k = ca(1)*s + c1(1);
                    epsilon0 = ca(2)*s + c1(2);
                    [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
                else
                    if s <= 5/6
                        c1(1) = 5.0*E(1)-4.0*F(1);
                        c1(2) = 5.0*E(2)-4.0*F(2);
                        ca(1) = 6.0*(F(1)-E(1));
                        ca(2) = 6.0*(F(2)-E(2));
                        k = ca(1)*s + c1(1);
                        epsilon0 = ca(2)*s + c1(2);
                        [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
                    else
                        if s <= 6/6
                            c1(1) = 6.0*F(1)-5.0*A(1);
                            c1(2) = 6.0*F(2)-5.0*A(2);
                            ca(1) = 6.0*(A(1)-F(1));
                            ca(2) = 6.0*(A(2)-F(2));
                            k = ca(1)*s + c1(1);
                            epsilon0 = ca(2)*s + c1(2);
                            [v(i), u(i),~,~,~,~] = esforcos(epsilon0, -k, 0, n_barras, n_arestas, diametro_aco, x_vertices, y_vertices, x_aco, y_aco, fyd, epsilonyd, n, sigmacd, epsilonc2, tol_k, tol_de);
                        end
                    end
                end
            end
        end
    end
    i = i+1;
end
plot(v, u);
hold on;
grid on;
title('Diagrama de Esforços Resultantes');
xlabel('N (Força Normal)');
ylabel('M (Momento Fletor)');