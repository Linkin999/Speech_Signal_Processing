function [waveform,t,frame,frame_t,magnitude,magnitude_w]=STSA_SingleFrame(filename,startsmp,framelength)
        [waveform,fs]=audioread(filename);
        t=0:1/fs:(length(waveform)-1)/fs;
        numberofsample=framelength/1000*fs;
        frame=zeros(1,numberofsample);
        frame_t=(startsmp-1)/fs:1/fs:(startsmp+numberofsample-2)/fs;
        ham=hamming(numberofsample)';
        for i=1:numberofsample
            frame(i)=waveform(startsmp+i-1)*ham(i);
        end
        x=fftshift(fft(frame));
        magnitude=abs(x);
        w=-pi:2*pi/(length(x)-1):pi;
        magnitude_w=w*fs/2/pi;
end