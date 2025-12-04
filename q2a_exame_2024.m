% Materiais
classe_concreto = 65;
classe_aco = 50;
gamac = 1.4;
gamas = 1.15;

% Esforços
Nd = 0.515;
Md = 0.01;
e = Md/Nd;

% Geometria
x = [0; 0.2; 0.2; 0; 0];
y = [0; 0; 0.2; 0.2; 0];
xs = [0.03; 0.03; 0.03; 0.17; 0.17; 0.17];
ys = [0.03; 0.1; 0.17; 0.03; 0.1; 0.17];
diametro_aco = [0.01; 0.01; 0.01; 0.01; 0.01; 0.01];
z = 2;

% Algoritmo
m = 1000;
prec = 1e-10;

%% Verificação diferenças finitas
[verificacao, f, count, yi, z_nodes, e0crit, kcrit] = verifica_pilar(classe_concreto, classe_aco, gamac, gamas, Nd, Md, diametro_aco, x, y, xs, ys, m, z, prec);
resultado = [verificacao; f; count; e0crit; kcrit];
disp(resultado);

% Plotagem (esse trecho deve estar comentado quando se usar a função plota_teq)
figure;
plot(100*yi, z_nodes);
xlabel('Deslocamento em cm');
ylabel('Altura da Seção em m');
title('Deformada do Pilar por diferenças finitas');
grid on;

figure;
%% Verificação pilar padrão
pilar_padrao(classe_concreto, classe_aco, gamac, gamas, diametro_aco, x, y, xs, ys, Nd, e, z);
