function [E,M,Z]=EMZ(s,L,R,window)
        N=length(s);
        N_E=floor(N/R);
        
        E=zeros(1,N_E);
        for n=1:floor((N-L)/R)
            for m=1:L
                E(n)=E(n)+s(m+(n-1)*R)^2*window(m);
            end
        end
        
        M=zeros(1,N_E);
        for n=1:floor((N-L)/R)
            for m=1:L
                M(n)=M(n)+abs(s(m+(n-1)*R))*window(m);
            end
        end
        
        sign=zeros(1,N);
        for i=1:N
            if s(i)>=0
                sign(i)=1;
            else
                sign(i)=-1;
            end
        end
        
        Z=zeros(1,N_E);
        for n=1:floor((N-L)/R)
            for m=2:L
                Z(n)=Z(n)+(abs(sign(m+R*(n-1))-sign(m-1+R*(n-1))))*window(m)/(2*L);
            end
        end      
end