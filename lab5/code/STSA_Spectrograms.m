function []=STSA_Spectrograms(filename,resamplerate,windowlengths,FFTlengths,magscale,range,color)
    [waveform,fs]=audioread(filename);
    
    if resamplerate~=0
        %[p,q]=rat(resamplerate,fs);
        %waveform=resample(waveform,p,q);
        fs=resamplerate;
    end
    numberofsample=windowlengths/1000*fs;
    ham=hamming(numberofsample)';
    
    [s,w,t]=spectrogram(waveform,ham,numberofsample*0.75,FFTlengths,fs,'yaxis');
    if magscale=='log'
        pcolor(t,w,20*log10(abs(s)));
        shading interp;
        c=colorbar;
        if range==0
            c.Label.String='Spectrum Magnitude(dB)';
        else
            caxis([-60 -60+range]);
            c.Label.String='Spectrum Magnitude(dB)';
        end
        
    else
        pcolor(t,w,abs(s));
        shading interp;
        c=colorbar;
        c.Label.String='Spectrum Magnitude';
    end
    
    if color=='gray'
        colormap('gray');
    else
    end
end