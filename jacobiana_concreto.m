function Jc = jacobiana_concreto(x, y, e0, kx, ky, n_arestas, sigmacd, epsilonc2, n, tol_k, tol_de, Nc, Mcx, Mcy)
    h = max(y)-min(y);
    Jc = [0, 0, 0; 0, 0, 0; 0, 0, 0];
    
    if(abs(kx)*h > tol_k)
        for i = 1:n_arestas
            dx = x(i+1,1) - x(i,1);
            Jc(1,1) = Jc(1,1) + dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,6,tol_de,i);
            Jc(1,2) = Jc(1,2) - dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,7,tol_de,i);
            Jc(1,3) = Jc(1,3) + dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,8,tol_de,i);
            Jc(2,2) = Jc(2,2) + dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,9,tol_de,i);
            Jc(2,3) = Jc(2,3) - dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,10,tol_de,i);
            Jc(3,3) = Jc(3,3) + dx*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,11,tol_de,i);
        end
        Jc(1,2) = -Nc+Jc(1,2);
        Jc(2,2) = -2*Mcx+Jc(2,2);
        Jc(2,3) = -Mcy+Jc(2,3);
        Jc(2,1) = Jc(1,2);
        Jc(3,2) = Jc(2,3);
        Jc(3,1) = Jc(1,3);

        Jc = -Jc/kx;
    elseif(abs(ky)*h > tol_k)
        for i = 1:n_arestas
            dy = y(i,1) - y(i,1);
            Jc(1,1) = Jc(1,1) + dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,6,tol_de,i);
            Jc(1,2) = Jc(1,2) - dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,7,tol_de,i);
            Jc(1,3) = Jc(1,3) + dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,8,tol_de,i);
            Jc(2,2) = Jc(2,2) + dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,9,tol_de,i);
            Jc(2,3) = Jc(2,3) - dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,10,tol_de,i);
            Jc(3,3) = Jc(3,3) + dy*funcoes_f(x,y,e0,kx,ky,sigmacd,epsilonc2,n,11,tol_de,i);
        end
        Jc(1,3) = -Nc+Jc(1,2);
        Jc(2,3) = -Mcx+Jc(2,2);
        Jc(3,3) = -2*Mcy+Jc(2,3);
        Jc(2,1) = Jc(1,2);
        Jc(3,2) = Jc(2,3);
        Jc(3,1) = Jc(1,3);

        Jc = -Jc/ky;
    else
        Jc(1,1) = Ac(x,y);
        Jc(1,2) = Sx(x,y);
        Jc(1,3) = Sy(x,y);
        Jc(2,2) = Ixx(x,y);
        Jc(2,3) = -Ixy(x,y);
        Jc(3,3) = Iyy(x,y);
        Jc(2,1) = Jc(1,2);
        Jc(3,2) = Jc(2,3);
        Jc(3,1) = Jc(1,3);

        Jc = -Jc*dsigmac(e0, epsilonc2,n,sigmacd);
    end
end