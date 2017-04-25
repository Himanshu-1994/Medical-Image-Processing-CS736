function [fil] = myFilter(R,frac,filt)

N = size(R,1);
fft_len = 2^nextpow2(2*N);

R_f = fft(R,fft_len);

a = (0:fft_len/2)./(fft_len/2);
w = 2*pi*(0:size(a,2)-1)/fft_len;  
L = (frac)*pi;
switch filt
    case 'R'
    F = a(2:end);
    case 'S'
    F = a(2:end).*(sin(w(2:end)*pi/(2*L))./(w(2:end)*pi/(2*L)));
    case 'C' 
    F = a(2:end).*(cos(w(2:end)*pi/(2*L)));
end
F(w(2:end)>L) = 0;
Q = [0 F F(end-1:-1:1)].';
res = bsxfun(@times,R_f,Q);
fil = real(ifft(res));
fil(N+1:end,:) = [];