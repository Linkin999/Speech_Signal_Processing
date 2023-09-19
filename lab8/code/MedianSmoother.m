function y=MedianSmoother(x,n)
    y=x;
    for i =(n-1)/2+1:length(x)-(n-1)/2
        sub=x(i-(n-1)/2:i+(n-1)/2);
        y(i)=median(sub);
    end
%     for i =n:length(x)
%         sub=x(i-n+1:i);
%         y(i)=median(sub);
%     end
end