function Js = jacobiana_aco(xs, ys, epsilonyd, fyd, diametro_aco, n_barras, e0, kx, ky)
    Js = [0, 0, 0; 0, 0, 0; 0, 0, 0];

    for i = 1:n_barras
        Asi = 0.25*pi*(diametro_aco(i)^2);
        esi = e0 + ky*xs(i,1)- kx*ys(i,1);

        Js(1,1) = Js(1,1) + dsigmasi(esi, epsilonyd, fyd)*Asi;
        Js(1,2) = Js(1,2) - dsigmasi(esi, epsilonyd, fyd)*ys(i,1)*Asi;
        Js(1,3) = Js(1,3) + dsigmasi(esi, epsilonyd, fyd)*xs(i,1)*Asi;
        Js(2,2) = Js(2,2) + dsigmasi(esi, epsilonyd, fyd)*(ys(i,1)^2)*Asi;
        Js(2,3) = Js(2,3) - dsigmasi(esi, epsilonyd, fyd)*(xs(i,1)*ys(i))*Asi;
        Js(3,3) = Js(3,3) + dsigmasi(esi, epsilonyd, fyd)*(xs(i,1)^2)*Asi;
    end
    Js(2,1) = Js(1,2);
    Js(3,2) = Js(2,3);
    Js(3,1) = Js(1,3);
    Js = -Js;
end