% Verifica o ELU em nFOC

function elu = verificaELU_nFOC(epsiloncu, epsilonc2, x_vertices, y_vertices, x_aco, y_aco, epsilon0, kx, ky)
    ei_c = epsilon0 + ky*x_vertices - kx*y_vertices;
    ei_aco = epsilon0 + ky*x_aco - kx*y_aco;

    e_aco_min = min(ei_aco);
    e_c_max = max(ei_c);
    e_c_min = min(ei_c);
    elu = (e_c_max<=epsiloncu && e_aco_min>=-10 && e_c_max - (epsiloncu-epsilonc2)*(e_c_max-e_c_min)/epsiloncu<=epsilonc2);
end