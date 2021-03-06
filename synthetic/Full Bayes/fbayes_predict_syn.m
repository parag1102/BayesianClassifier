function [class]=fbayes_predict_syn(test_data,mean1,mean2,covar1,covar2,prior1,prior2)
    s=size(test_data);
    q2_c1=inv(covar1);
    q2_c2=inv(covar2);
    det_c1=log(det(covar1))/2;
    det_c2=log(det(covar2))/2;
    cons=(s(1,2)*log(2*pi))/2;
    lprior1=log(prior1);
    lprior2=log(prior2);
    tail1=lprior1-cons-det_c1;
    tail2=lprior2-cons-det_c2;

    class=zeros(s(1,1),1);
    for row= 1:s(1,1)
        q1_c1=test_data(row,:)-mean1;
        q1_c2=test_data(row,:)-mean2;
        head1=((q1_c1)*q2_c1*(q1_c1)')/2;
        g1=-head1+tail1;
        head2=((q1_c2)*q2_c2*(q1_c2)')/2;
        g2=-head2+tail2;
        if(g1>g2)
            class(row,1)=0;
        else
            class(row,1)=1;
        end
    end
end