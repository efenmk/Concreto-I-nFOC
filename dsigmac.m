function dsigmac = dsigmac(epsilon0, epsilonc2, n, sigmacd)
    if (epsilon0 < 0 || epsilon0>=2)
        dsigmac = 0;
    else
        dsigmac = (sigmacd*n*(1 - epsilon0/epsilonc2)^(n-1))*(1/epsilonc2);
    end
end