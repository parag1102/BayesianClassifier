function [Mean_d1,Mean_d2,Covar_d1,Covar_d2,prior_c1,prior_c2]=fbayes_learning(training_data)
    s = size(training_data);
    d1=[];
    d2=[];
    for ind = 1:s(1, 1)
        if(training_data(ind, s(1,2))==0)
            d1 = [d1 ; training_data(ind, 1:(s(1,2)-1))];
        else
            d2 = [d2 ; training_data(ind, 1:(s(1,2)-1))];
        end
    end
    s1=size(d1);
    s2=size(d2);
    prior_c1=s1(1,1)/s(1,1);
    prior_c2=s2(1,1)/s(1,1);
    Covar_d1 = cov(d1);
    Covar_d2 = cov(d2);
    Mean_d1 = mean(d1);
    Mean_d2 = mean(d2);
end