function [a,err]=LPC(x,order)
        %x is the frame 
        R0=sum(x.^2);
        R_1_p=zeros(1,order);
        for k=1:order
            for m=0:length(x)-1-k
                R_1_p(k)=R_1_p(k)+x(m+1).*x(m+1+k);
            end
        end
        R_0_p=[R0 R_1_p(1:order-1)];
        A=toeplitz(R_0_p,R_0_p);
        a=(pinv(A))*R_1_p';
        
        
        %compute singal hat
        sig_hat=zeros(1,length(x));
        framepad=[zeros(1,order),x];
        for n=1:length(x)
            for k=1:order
                sig_hat(n)=sig_hat(n)+a(k).*framepad(order+n-k);
            end
        end
        err=x-sig_hat;
             
end