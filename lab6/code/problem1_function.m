function cepstrum=problem1_function(a,N,nfft)
        n=0:N-1;
        x=a.^n;
        [cepstrum,rcepstrum]=Cepstrum(x,nfft);
end