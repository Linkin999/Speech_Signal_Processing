function [waveform,t,ham_matrix,frames_ham,frames_ham_t,magnitude_ham,magnitude_ham_w]=STSA_MultiLengths(num,filename,startsmp,framelengths)
            [waveform,fs]=audioread(filename);
            t=0:1/fs:(length(waveform)-1)/fs;
            
            numberofsamples=zeros(1,num);
            
            ham_matrix=zeros(1,sum(framelengths)/1000*fs);
            frames_ham=zeros(1,sum(framelengths)/1000*fs);
            frames_ham_t=zeros(1,sum(framelengths)/1000*fs);
            magnitude_ham=zeros(1,sum(framelengths)/1000*fs);
            magnitude_ham_w=zeros(1,sum(framelengths)/1000*fs);
            
            sum_num=0;
            for i=1:num
                numberofsamples(i)=framelengths(i)/1000*fs;
                
                ham_matrix(sum_num+1:sum_num+numberofsamples(i))=hamming(numberofsamples(i))';
                transpose_waveform=waveform';
                temp=transpose_waveform(startsmp:startsmp+numberofsamples(i)-1);
                frames_ham(sum_num+1:sum_num+numberofsamples(i))=temp;
                frames_ham_t(sum_num+1:sum_num+numberofsamples(i))=(startsmp-1)/fs:1/fs:(startsmp+numberofsamples(i)-2)/fs;
                x=fftshift(fft(frames_ham(sum_num+1:sum_num+numberofsamples(i)).*ham_matrix(sum_num+1:sum_num+numberofsamples(i))));
                magnitude_ham(sum_num+1:sum_num+numberofsamples(i))=abs(x);
                w=-pi:2*pi/(length(x)-1):pi;
                magnitude_ham_w(sum_num+1:sum_num+numberofsamples(i))=w*fs/2/pi;
                
                sum_num=sum_num+numberofsamples(i);
                
            end
            %numberofsamples=framelength/1000*fs;
            %frame_t=(startsmp-1)/fs:1/fs:(startsmp-1+framelength)/fs
end