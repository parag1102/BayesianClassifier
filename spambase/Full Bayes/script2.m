load spambase.data;
k = randperm(4601);
d1 = spambase(k(1:1150), :);
d2 = spambase(k(1151:2300), :);
d3 = spambase(k(2301:3450), :);
d4 = spambase(k(3451:4601), :);
[Mean_d1,Mean_d2,Covar_d1,Covar_d2,prior_c1,prior_c2] = fbayes_learning([d1 ; d2 ; d3]);
[class] = fbayes_predict(d4(:, 1:57), Mean_d1,Mean_d2,Covar_d1,Covar_d2,prior_c1,prior_c2);

tp=0;
tn=0;
fp=0;
fn=0;
for ind = 1:1151
    if(class(ind,1)==1 && d4(ind, 58)==1)
        tp = tp + 1;
    elseif(class(ind,1)==0 && d4(ind, 58)==0)
        tn = tn + 1;
    elseif(class(ind,1)==1 && d4(ind, 58)==0)
        fp = fp + 1;
    else
        fn = fn + 1;
    end
end
precision = tp / (tp + fp);
recall = tp / (tp + fn);
pns = tn / (fn + tn);
f1 = 2*precision*recall/(precision+recall);
macro_avg = (precision + pns)/2;
micro_avg = (tp + tn)/1150;