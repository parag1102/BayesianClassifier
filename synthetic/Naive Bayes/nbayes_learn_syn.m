function [prior_c1,prior_c2,prob_d1,prob_d2] = nbayes_learn_syn(data)
    s = size(data);
    d1=[];
    d2=[];
    for ind = 1:s(1, 1)
        if(data(ind, s(1,2))==0)
            d1 = [d1 ; data(ind, 1:(s(1,2)-1))];
        else
            d2 = [d2 ; data(ind, 1:(s(1,2)-1))];
        end
    end
    s1=size(d1);
    s2=size(d2);
    prior_c1=s1(1,1)/s(1,1);
    prior_c2=s2(1,1)/s(1,1);
    
    mean_d1 = [-2 0];
    prob_d1 = zeros(s1(1,2),2);
    for col = 1:s1(1,2)
        countnz1=0;countz1=0;
        for row = 1:s1(1,1)
            if (d1(row,col) <= mean_d1(1,col))
                countz1=countz1+1;
            else
                countnz1=countnz1+1;
            end
        end
        prob_d1(col, 1) = (countz1+0.5)/(s1(1,1)+1);
        prob_d1(col, 2) = (countnz1+0.5)/(1+s1(1,1));
    end

    mean_d2 = [2, 0];
    prob_d2 = zeros(s2(1,2),2);
    for col = 1:s2(1,2)
        countnz=0;countz=0;
        for row = 1:s2(1,1)
            if (d2(row,col)<= mean_d2(1,col))
                countz=countz+1;
            else
                countnz=countnz+1;
            end
        end
        prob_d2(col, 1) = (countz+0.5)/(s2(1,1)+1);
        prob_d2(col, 2) = (countnz+0.5)/(1+s2(1,1));
    end
end