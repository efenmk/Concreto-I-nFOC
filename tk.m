function tk = tk(epsilon, c, n, k)
    if (epsilon >= 0 && epsilon < c)
        tk = 1/(n + k)*(1 - (1 - epsilon/c)^(n + k));
    elseif (epsilon >= c)
        tk = 1/(n + k);
    end
end