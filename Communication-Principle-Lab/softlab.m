clear all
close all

N = 2 ^ 13;
L = 16;
M = N / L;
Rs = 2;
Ts = 1 / Rs;
t = -10 * Ts : Ts / N : 10 * Ts;
fs = L / Ts;
Bs = fs / 2;
T = N / fs;

t = - T/2 + [0 : N - 1] / fs;
f = - Bs + [0 : N - 1] / T;

alpha = 0.25;
Hcos = zeros(1, N);
ii = find(abs(f) > (1 - alpha) / (2 * Ts) & abs(f) <= (1 + alpha) / (2 * Ts));
Hcos(ii) = Ts / 2 * (1 + cos(pi * Ts / alpha * (abs(f(ii)) - (1 - alpha) / (2 * Ts))));
ii = find(abs(f) <= (1 - alpha) / (2 * Ts));
Hcos(ii) = Ts;

Hrcos = sqrt(Hcos);

xt = sinc(t / Ts).*(cos(alpha * pi * t / Ts)) ./ (1 - 4 * alpha ^ 2 * t .^2 / Ts ^ 2 + eps);

EP = zeros(1, N);
for loop = 1 : 2000
    a = sign(randn(1, M));
    s1 = zeros(1, N);
    s1(1 : L : N) = a * fs;
    S1 = t2f(s1, fs);
    S2 = S1 .* Hrcos;
    s2 = real(f2t(S2, fs));

    P = abs(S2).^2 / T;
    EP = EP * (1 - 1 / loop) + P / loop;
    if rem(loop, 100) == 0
        fprintf('\n %d', loop)
    end
end

N0 = 0.01;
nw = sqrt(N0 * Bs) * randn(1, N);

r = s2 + nw;

R = t2f(r, fs);
Y = R .* Hrcos;
y = real(f2t(Y, fs));

figure(1)
plot(t, xt)
axis([-10 10 -0.5 1.1])
xlabel('t')
ylabel('升余弦滚降系统的时域波形')
figure(2)
plot(f, EP)
xlabel('f(kHz)')
ylabel('power spectrum(W/kHz)')
axis([-2, 2, 0, max(EP)])
eyediagram(y, 3 * L, 3, 9)

function S = t2f(s,fs)
    N = length(s);
    T = 1 / fs * N;
    f = [-N/2 : (N/2 - 1)]/T;
    tmp1 = fft(s) / fs;
    tmp2 = N * ifft(s) / fs;
    S(1 : N/2) = tmp2(N/2 + 1 : -1 : 2);
    S(N/2 + 1 : N) = tmp1(1 : N/2);
    S = S .* exp(j * pi * f * T);
end

function s = f2t(S, fs)
    N = length(S);
    T = N / fs;
    t = [-(T/2) : 1/fs : (T/2 - 1/fs)];
    tmp1 = fft(S) / T;
    tmp2 = N * ifft(S) / T;
    s(1 : N / 2)=tmp1(N/2 + 1 : -1 : 2);
    s(N/2 + 1 : N) = tmp2(1 : N/2);
    s = s .* exp(-j * pi * t * fs);
end