data = generate_dataset();
k = randperm(1000);
d1 = data(k(1:250), :);
d2 = data(k(251:500), :);
d3 = data(k(501:750), :);
d4 = data(k(751:1000), :);
[prior1, prior2, prob1, prob2] = nbayes_learn_syn([d1 ; d2 ; d3]);
[result, class] = nbayes_predict_syn(d4(:, 1:2), prior1, prior2, prob1, prob2);
tp=0;
tn=0;
fp=0;
fn=0;
for ind = 1:250
    if(class(ind,1)==1 && d4(ind, 3)==1)
        tp = tp + 1;
    elseif(class(ind,1)==0 && d4(ind, 3)==0)
        tn = tn + 1;
    elseif(class(ind,1)==1 && d4(ind, 3)==0)
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
micro_avg = (tp + tn)/250;