data = xlsread('CTG_new.xlsx');
k = randperm(2126);
d1 = data(k(1:531), :);
d2 = data(k(532:1062), :);
d3 = data(k(1063:1594), :);
d4 = data(k(1595:2126), :);
[prior1, prior2,prior3, prob1, prob2,prob3] = nbayes_learn_ctg([d1 ; d2 ; d3]);
[result, class] = nbayes_predict_ctg(d4(:, 1:40), prior1, prior2,prior3, prob1, prob2,prob3);
T = zeros(3,3);
for ind = 1:532
    if(class(ind, 1)==1 && d4(ind, 41)==1)
        T(1,1)=T(1,1)+1;
    elseif(class(ind, 1)==1 && d4(ind, 41)==2)
        T(1,2)=T(1,2)+1;
    elseif(class(ind, 1)==1 && d4(ind, 41)==3)
        T(1,3)=T(1,3)+1;
    elseif(class(ind, 1)==2 && d4(ind, 41)==1)
        T(2,1)=T(2,1)+1;
    elseif(class(ind, 1)==2 && d4(ind, 41)==2)
        T(2,2)=T(2,2)+1;
    elseif(class(ind, 1)==2 && d4(ind, 41)==3)
        T(2,3)=T(2,3)+1;
    elseif(class(ind, 1)==3 && d4(ind, 41)==1)
        T(3,1)=T(3,1)+1;
    elseif(class(ind, 1)==3 && d4(ind, 41)==2)
        T(3,2)=T(3,2)+1;
    elseif(class(ind, 1)==3 && d4(ind, 41)==3)
        T(3,3)=T(3,3)+1;
    end
end
precision = T(1,1)/(T(1,1)+T(2,1)+T(3,1));
recall = T(1,1)/(T(1,1)+T(1,2)+T(1,3));
f1 = 2*precision*recall/(precision+recall);
pns = (T(2,2)+T(3,3))/(T(2,1)+T(2,2)+T(2,3)+T(3,1)+T(3,2)+T(3,3));
macro_avg = (precision+pns)/2;
micro_avg = (T(1,1)+T(2,2)+T(3,3))/532;