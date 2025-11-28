function dsigmasi = dsigmasi(epsilon, epsilonyd,fyd)
    if abs(epsilon) >= epsilonyd
        dsigmasi = 0;
    else
        dsigmasi = fyd/epsilonyd;
    end
end