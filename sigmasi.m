function sigmasi = sigmasi(epsilon, fyd, epsilonyd)
    if epsilon <= - epsilonyd
        sigmasi = -fyd;
    elseif abs(epsilon) <= epsilonyd
        sigmasi = fyd*epsilon/epsilonyd;
    elseif epsilon > epsilonyd
        sigmasi = fyd;
    end
end