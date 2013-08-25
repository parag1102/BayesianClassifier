function [class]=fbayes_predict_ctg(test_data,mean1,mean2,mean3,covar1,covar2,covar3,prior1,prior2,prior3)
    s=size(test_data);
    q2_c1=pinv(covar1);
    q2_c2=pinv(covar2);
    q2_c3=pinv(covar3);
    det_c1=log(det(covar1))/2;
    det_c2=log(det(covar2))/2;
    det_c3=log(det(covar3))/2;
    cons=(s(1,2)*log(2*pi))/2;
    lprior1=log(prior1);
    lprior2=log(prior2);
    lprior3=log(prior3);
    tail1=lprior1-cons;
    tail2=lprior2-cons;
    tail3=lprior3-cons;

    class=zeros(s(1,1),1);
    for row= 1:s(1,1)
        q1_c1=test_data(row,:)-mean1;
        q1_c2=test_data(row,:)-mean2;
        q1_c3=test_data(row,:)-mean3;
        head1=((q1_c1)*q2_c1*(q1_c1)')/2;
        g1=-head1+tail1;
        head2=((q1_c2)*q2_c2*(q1_c2)')/2;
        g2=-head2+tail2;
        head3=((q1_c3)*q2_c3*(q1_c3)')/2;
        g3=-head3+tail3;
        max = 1;
        g = [g1 g2 g3]
        for ind=2:3
            if(g(1, ind) >= g(1,max))
                max=ind;
            end
        end
        class(row,1)=max;
    end
end