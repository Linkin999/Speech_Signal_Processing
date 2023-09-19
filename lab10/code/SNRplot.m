function [sig]=SNRplot(s,u,bits)
    factor=2.^(0:-1:-12)';
    sig=factor*s';
    sig=sig';
    SNR_uniform=zeros(1,13);
    SNR_u=zeros(1,13);
    deviation=std(sig);
    for i=1:13
        signal_i=sig(:,i);
        signal_q=fxquant(mulaw(signal_i,u),bits,'round','sat');
        signal_expand=mulawinv(signal_q,u);
        SNR_uniform(i)=MySNR(fxquant(signal_i,bits,'round','sat'),signal_i);
        SNR_u(i)=MySNR(signal_expand,signal_i);
    end
    semilogx(1./deviation,SNR_u);hold on;
    semilogx(1./deviation,SNR_uniform,'--');
    xlabel('1/sigma');
    ylabel('SNR(dB)');
end