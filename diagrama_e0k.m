%Plotagem do diagrama e0, k
classe_concreto = 30;
classe_aco = 50;
gamac = 1.4;
gamas = 1.15;

% Parâmetros dos materiais
[sigmacd, epsilonc2, epsiloncu, n, fyd, epsilonyd] = parametros(classe_concreto, classe_aco, gamac, gamas);

% Geometria da seção
h = 0.32;
b = 0.2;
yt = 0.16;
yb = -0.16;
y_min = -0.11;
y_max = 0.11;

diameter_s = 0.01;
ys = [-0.11 0 0.11];
As = pi*(diameter_s/2)^2;
nbarras = [2 2 2];
Asi = As*nbarras;

%definimos os pontos aqui e as retas:
Polo_10 = @(x,y) -10 -y*x;
Polo_Ecu = @(x,y) epsiloncu - y*x;
Polo_Ec2_esquerda = @(x,y) epsilonc2 - (y + h*(epsiloncu - epsilonc2)/epsiloncu)*x;
Polo_Ec2_direita = @(x,y) epsilonc2 - (y - h*(epsiloncu - epsilonc2)/epsiloncu)*x;

eixo_C = (epsiloncu+10)/(yt - y_min);
eixo_B = epsiloncu/h;
eixo_E = (epsiloncu+10)/(yb - y_max);
eixo_F = -epsiloncu/h;

%k
x_ab = linspace(0,eixo_B,1000);
x_bc = linspace(eixo_B, eixo_C,1000);
x_dc = linspace (0,eixo_C,1000);
x_de = linspace(eixo_E,0,1000);
x_ef = linspace(eixo_E,eixo_F,1000);
x_fa = linspace(eixo_F,0,1000);

% e0
y_ab = Polo_Ec2_direita(x_ab, yt);
y_bc = Polo_Ecu(x_bc, yt);
y_dc = Polo_10(x_dc, y_min);
y_de = Polo_10(x_de, y_max);
y_ef = Polo_Ecu(x_ef, yb);
y_fa = Polo_Ec2_esquerda(x_fa, yb);

% Plotar os gráficos
figure;
hold on;
plot(x_ab, y_ab, 'b-', 'LineWidth', 2); % Polo_Ec2 em x_ab
plot(x_bc, y_bc, 'b-', 'LineWidth', 2); % Polo_Ecu em x_bc
plot(x_dc, y_dc, 'b-', 'LineWidth', 2); % Polo_10 em x_dc
plot(x_de, y_de, 'b-', 'LineWidth', 2); % Polo_10 em x_de
plot(x_ef, y_ef, 'b-', 'LineWidth', 2); % Polo_Ecu em x_ef
plot(x_fa, y_fa, 'b-', 'LineWidth', 2); % Polo_Ec2 em x_fa
hold off;

% Configuração do gráfico
grid on;
title('Região Viável do ELU');
xlabel('k');
ylabel('e0');