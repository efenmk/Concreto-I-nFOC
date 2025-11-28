function sigmac = sigmac(epsilon, epsilonc2, sigmacd, n)
    if epsilon <= 0
        sigmac = 0;
    elseif epsilon <= epsilonc2
        sigmac = sigmacd*(1-(1-epsilon/epsilonc2)^n);
    elseif epsilon >= epsilonc2
        sigmac = sigmacd;
    end
end