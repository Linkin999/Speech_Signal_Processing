function [waveform,t,rectangular_matrix,frames_rectangular,frames_rectangular_t,magnitude_rectangular,magnitude_rectangular_w]=STSA_MultiLengths2(num,filename,startsmp,framelengths)
            [waveform,fs]=audioread(filename);
            t=0:1/fs:(length(waveform)-1)/fs;
            
            numberofsamples=zeros(1,num);
            
            rectangular_matrix=zeros(1,sum(framelengths)/1000*fs);
            frames_rectangular=zeros(1,sum(framelengths)/1000*fs);
            frames_rectangular_t=zeros(1,sum(framelengths)/1000*fs);
            magnitude_rectangular=zeros(1,sum(framelengths)/1000*fs);
            magnitude_rectangular_w=zeros(1,sum(framelengths)/1000*fs);
            
            sum_num=0;
            for i=1:num
                numberofsamples(i)=framelengths(i)/1000*fs;
                
                rectangular_matrix(sum_num+1:sum_num+numberofsamples(i))=rectwin(numberofsamples(i))';
                transpose_waveform=waveform';
                temp=transpose_waveform(startsmp:startsmp+numberofsamples(i)-1);
                frames_rectangular(sum_num+1:sum_num+numberofsamples(i))=temp;
                frames_rectangular_t(sum_num+1:sum_num+numberofsamples(i))=(startsmp-1)/fs:1/fs:(startsmp+numberofsamples(i)-2)/fs;
                x=fftshift(fft(frames_rectangular(sum_num+1:sum_num+numberofsamples(i)).*rectangular_matrix(sum_num+1:sum_num+numberofsamples(i))));
                magnitude_rectangular(sum_num+1:sum_num+numberofsamples(i))=abs(x);
                w=-pi:2*pi/(length(x)-1):pi;
                magnitude_rectangular_w(sum_num+1:sum_num+numberofsamples(i))=w*fs/2/pi;
                
                sum_num=sum_num+numberofsamples(i);
                
            end


end