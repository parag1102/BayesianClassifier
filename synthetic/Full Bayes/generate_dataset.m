function d = generate_dataset()
    mu1 = [-2 0];
    mu2 = [2 0];
    sigma = [2 0; 0 3];
    d1 = mvnrnd(mu1, sigma, 500);
    d2 = mvnrnd(mu2, sigma, 500);
    coln1 = zeros(500, 1);
    coln2 = zeros(500, 1);
    for ind = 1:500
        coln2(ind,1) = coln2(ind,1) + 1;
    end
    d1 = [d1 coln1];
    d2 = [d2 coln2];
    d = [d1; d2];
 end