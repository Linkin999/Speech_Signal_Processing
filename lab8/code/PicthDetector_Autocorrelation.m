function [pitch_period,pitch_period_medianfilter,score_log,score_log_medianfilter]=PicthDetector_Autocorrelation(s,fsout,gender)
    if (gender=="male")
        pdhigh=floor(fsout/75);%向下取整
        pdlow=ceil(fsout/200);%向上取整
    else
        pdhigh=floor(fsout/150);
        pdlow=ceil(fsout/300);
    end
    N=length(s);
    L=400;
    R=100;
    h=1:floor((N-L)/R);
    au=zeros(length(h),(L+pdhigh)*2-1);
    pitch_period=zeros(1,length(h));
    score=zeros(1,length(h));
    for n=1:floor((N-L)/R)
        s1=s((n-1)*R+1:(n-1)*R+L);
        s2=s((n-1)*R+1:(n-1)*R+L+pdhigh);
        au(n,:)=xcorr(s1,s2);
        temp=au(n,:);
        med=temp(round((length(temp)-1)/2):end);
        [score(n),maxvalue]=max(med(pdlow:pdhigh));
        pitch_period(n)=maxvalue+pdlow-1;
    end
    score_log=log10(score);
    threshold=max(score_log)*0.75;
    for n=1:floor((N-L)/R)
        if score_log(n)<threshold
            pitch_period(n)=0;
        end
    end
    pitch_period_medianfilter=MedianSmoother(pitch_period,5);
    score_log_medianfilter=MedianSmoother(score_log,5);
    
    
    
end