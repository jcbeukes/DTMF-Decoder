clear;
clc;
[y,Fs] = audioread('dtmf-genave-superfast-20-20-1646347904wav');
N = 100;
freqs = [697,770,852,941,1209,1336,1477];
inst_power = filter(ones(1,N)/N,1,y.*y);
threshold = 0.5*max(inst_power);
p_gt_t = zeros(1,length(y));
for i = (1:length(y))
    if(inst_power(i)>threshold)
        p_gt_t(i) = 1;
    else
        p_gt_t(i) = 0;
    end
end
clear i;
beginning = find(p_gt_t(2:length(y)) - p_gt_t(1:length(y)-1)== 1);
ending = find(p_gt_t(2:length(y)) - p_gt_t(1:length(y)-1)== -1);

len = ending - beginning + 1;
k = ceil(freqs' * len/Fs);

%rows represent the frequencies
%the columns represent the dtmf tones present in the signal

%We now find the value of the fft for a particular dtmf
%tone at the corresponding values of k, using goertzel algorithm

%goertzel algorithm for finding the fft of a particular 
% frequency wo = 2*pi*k/N
% fft = summation(y(n)*exp(-i*wo*n)) as n varies from 0:length of the data
num = 0;
for n = 1:length(beginning)

    %sum = 0;
    %for j = 0:len(n)-1
     %   sum = sum + y(beginning(n)+j)*exp(-i*2*pi*[0:len(3)-1]*j/len(3));
    %end
    %abs(sum(k(:,n)))
    %r = find(abs(sum(k(1:3,n))) == max(abs(sum(k(1:3,n)))));
    %c = find(abs(sum(k(4:6,n))) == max(abs(sum(k(4:6,n)))));
    %num = num*10+find_num(r,c);

x = y(beginning(n):ending(n));
fft2 = abs(fft(x));
a = find(fft2(k(1:4,n)) == max(fft2(k(1:4,n))));
b = find(fft2(k(5:7,n)) == max(fft2(k(5:7,n))));
num = num*10 +find_num(a,b);
end
num