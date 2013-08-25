function [data, class]  = nbayes_predict_ctg(data, prior_c1, prior_c2,prior_c3, prob_d1, prob_d2,prob_d3)
    ln_c1 = log(prior_c1);
    ln_c2 = log(prior_c2);
    ln_c3 = log(prior_c3);
    ln_d1 = log(prob_d1);
    ln_d2 = log(prob_d2);
    ln_d3 = log(prob_d3);
    s = size(data);
    class = zeros(s(1,1), 1);
    for row = 1:s(1,1)   
        prob_c1 = ln_c1;
        prob_c2 = ln_c2;
        prob_c3 = ln_c3;
        for col = 1:s(1,2)
            if(data(row,col)==0)
                prob_c1 = prob_c1 + ln_d1(col, 1);
                prob_c2 = prob_c2 + ln_d2(col, 1);
                prob_c3 = prob_c3 + ln_d3(col, 1);
            else
                prob_c1 = prob_c1 + ln_d1(col, 2);
                prob_c2 = prob_c2 + ln_d2(col, 2);
                prob_c3 = prob_c3 + ln_d3(col, 2);
            end
        end
        if(prob_c1 >= prob_c2 && prob_c1 >= prob_c3)
            class(row, 1) = 1;
        elseif(prob_c2 >= prob_c1 && prob_c2 >= prob_c3)
            class(row, 1) = 2;
        else
            class(row, 1) = 3;
        end
    end
    data = [data class];
end