function [Mean_d1,Mean_d2,Mean_d3,Covar_d1,Covar_d2,Covar_d3,prior_c1,prior_c2,prior_c3]=fbayes_learning_ctg(training_data)
    s = size(training_data);
    d1=[];
    d2=[];
    d3=[];
    for ind = 1:s(1, 1)
        if(training_data(ind, s(1,2))==1)
            d1 = [d1 ; training_data(ind, 1:(s(1,2)-1))];
        elseif(training_data(ind, s(1,2))==2)
            d2 = [d2 ; training_data(ind, 1:(s(1,2)-1))];
        else
             d3 = [d3 ; training_data(ind, 1:(s(1,2)-1))];
        end
    end
    s1=size(d1);
    s2=size(d2);
    s3=size(d3);
    prior_c1=s1(1,1)/s(1,1);
    prior_c2=s2(1,1)/s(1,1);
    prior_c3=s3(1,1)/s(1,1);
    Covar_d1 = cov(d1);
    Covar_d2 = cov(d2);
    Covar_d3 = cov(d3);
    Mean_d1 = mean(d1);
    Mean_d2 = mean(d2);
    Mean_d3 = mean(d3);
end