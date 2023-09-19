function [s_n_r,e]=MySNR(xh,x)
          e=xh-x;
          s_n_r=10*log10(sum(x.^2)/sum(e.^2));
end