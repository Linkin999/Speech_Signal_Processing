function [p1_median,pd1_median]=PictnDetector_Cepstrum(s,fs,gender)
    if (gender=="male")
        nlow=40;
        nhigh=167;
    else
        nlow=28;
        nhigh=67;
    end
    
    nfft=4000;
    N=length(s);
    L=400;R=100;
    
    pthr1=4;
    h=1:floor((N-L)/R);
    reliable=zeros(1,length(h));

    %real cepstrum
    rceps=zeros(length(h),nfft);
    p1=zeros(1,length(h));
    p2=zeros(1,length(h));
    pd1=zeros(1,length(h));
    pd2=zeros(1,length(h));
    
    for n=1:floor((N-L)/R)
        X=fft(s((n-1)*R+1:(n-1)*R+L).*hamming(L),nfft);
%         theta=unwrap(angle(X));
%         X_log=complex(log(abs(X)),theta);
%         
%         rceps(n,:)=fftshift(ifft(X_log,nfft));
        rceps(n,:)=fftshift(ifft(log(abs(X)),nfft));
        temp=rceps(n,:);
        temp(isnan(temp))=0;
        temp=temp(nfft/2+1:end);
        [p1(n),pd1(n)]=max(temp(nlow:nhigh));
        pd1(n)=pd1(n)+nlow-1;
        temp(pd1(n)-4:pd1(n)+4)=0;
        [p2(n),pd2(n)]=max(temp(nlow:nhigh));
        pd2(n)=pd2(n)+nlow-1;
        if (p1(n)/p2(n)>=pthr1)
            reliable(n)=1;
        end
    end

    for n=1:floor((N-L)/R)
        if (reliable(n)==1)
            i=1;j=1;
            while((n+i<length(pd1))&&((abs(pd1(n+i)-pd1(n+i-1))<=0.1*pd1(n+i-1))||(abs(pd2(n+i)-pd2(n+i-1))<=0.1*pd2(n+i-1))))
                reliable(n+i)=1;
                i=i+1;
            end
            while((n-j>0)&&((abs(pd1(n-j)-pd1(n-j+1))<=0.1*pd1(n-j+1))||(abs(pd2(n-j)-pd2(n-j+1))<=0.1*pd2(n-j+1))))
                reliable(n-j)=1;
                j=j+1;
            end
        end
    end
    
    for n=1:floor((N-L)/R)
        if(reliable(n)==0)
            pd1(n)=0;
        end
    end

    p1_median=MedianSmoother(p1,5);
    pd1_median=MedianSmoother(pd1,5);
end
