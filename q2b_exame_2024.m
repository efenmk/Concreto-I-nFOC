% Materiais
classe_concreto = 65;
classe_aco = 50;
gamac = 1.4;
gamas = 1.15;

% Esforços
Nd = 0.515;
Md = 0.01;

% Geometria
x = [0; 0.2; 0.2; 0; 0];
y = [0; 0; 0.2; 0.2; 0];
xs = [0.03; 0.03; 0.03; 0.17; 0.17; 0.17];
ys = [0.03; 0.1; 0.17; 0.03; 0.1; 0.17];
diametro_aco = [0.01; 0.01; 0.01; 0.01; 0.01; 0.01];
z = 2;

compressao_uniforme(classe_concreto, classe_aco, gamac, gamas, diametro_aco, x, y, xs, ys, z);

