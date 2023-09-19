function PlotAudioFile(x,fstart,N,M,fs)
        %x:signal
        %fstart:start sample
        %N:total sample
        %M:samples of each line
        %fs:samplerate
        lines=floor(N/M);% completed lines
        disp(lines);
        pages=floor(lines/4);%completed pages
        disp(pages);
        restoflines=lines-4*pages;
        restofsamples=N-M*lines;
        disp(restofsamples);
        for i=1:pages
            figure
            for j=1:4
                startsampleofeachline=fstart+4*M*(i-1)+M*(j-1);
                endsampleofeachline=fstart+4*M*(i-1)+M*j-1;
                cut=x(startsampleofeachline:endsampleofeachline);
                subplot(4,1,j);
                plot(startsampleofeachline/fs:1/fs:endsampleofeachline/fs,cut);
                xlabel('t(s)');
                ylabel('value');
                axis([startsampleofeachline/fs,endsampleofeachline/fs min(x) max(x)]);
            end
        end
        
        if restoflines~=0
            figure
            for i=1:restoflines
                startsample=fstart+4*M*pages+M*(i-1);
                endsample=startsample+M-1;
                cut=x(startsample:endsample);
                subplot(4,1,i);
                plot(startsample/fs:1/fs:endsample/fs,cut);
                xlabel('t(s)');
                ylabel('value');
                axis([startsample/fs endsample/fs min(x) max(x)]);
            end  
        end
        
        if restofsamples~=0
            subplot(4,1,restoflines+1);
            plot((fstart+N-restofsamples)/fs:1/fs:(fstart+N-1)/fs,x(fstart+N-restofsamples:fstart+N-1));
            xlabel('t(s)');
            ylabel('value');
            axis([(fstart+N-restofsamples)/fs (fstart+N-restofsamples+M-1)/fs min(x) max(x)]);
        end