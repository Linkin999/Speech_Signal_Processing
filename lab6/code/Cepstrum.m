function [ccepstrum,rcepstrum]=Cepstrum(x,nfft)
    X=fftshift(fft(x,nfft));
    theta=unwrap(angle(X));
    X_log=complex(log(abs(X)),theta);
    ccepstrum=ifftshift(ifft(ifftshift(X_log),nfft));
    rcepstrum=ifftshift(ifft(ifftshift(log(abs(X))),nfft));
end