% =========================================================================
% Effect of Hamming window on spectral leakage
% Developed and tested for linear algebra project >:3
% =========================================================================
clear; clc; close all;

N = 256;              % total number of samples in the frame
n = 0:N-1;            % sample index

%% 1. discrete time-domain frame x[n]
% applies a freq that doesnt fit exactly into an integer number of cycles 
% to induce spectral leakage (and some low-level random noise too)
f0 = 10.5; 
x = sin(2*pi*f0*n/N) + 0.05*randn(1, N);

%% 2. hamming window w[n]
w = 0.54 - 0.46 * cos(2*pi*n / (N-1));

%% 3. multiply
x_windowed = x .* w;

%% 4. fft to calculate freq spectra
X_rect = abs(fft(x));             % fft with rectangular window
X_hamm = abs(fft(x_windowed));    % fft with hamming window

% convert to dB
X_rect_dB = 20*log10(X_rect / max(X_rect));
X_hamm_dB = 20*log10(X_hamm / max(X_hamm));
freq_axis = 0:(N/2-1); % first half of the freq bins

%% 5. visualization
figure('Position', [100, 100, 850, 650], 'Color', 'w');

% top left: original signal
subplot(2, 2, 1);
plot(n, x, 'b', 'LineWidth', 1.2);
title('Original Signal Frame (x[n])');
xlabel('Sample index (n)'); ylabel('Amplitude');
grid on; axis tight; ylim([-1.5 1.5]);

% top right: hamming window
subplot(2, 2, 2);
plot(n, w, 'r', 'LineWidth', 1.5);
title('Hamming Window (w[n])');
xlabel('Sample index (n)'); ylabel('Amplitude');
grid on; axis tight; ylim([0 1.1]);

% bottom left: windowed signal
subplot(2, 2, 3);
plot(n, x_windowed, 'Color', [0.5 0 0.8], 'LineWidth', 1.2);
title('Windowed Signal (x[n] \cdot w[n])');
xlabel('Sample index (n)'); ylabel('Amplitude');
grid on; axis tight; ylim([-1.5 1.5]);

% bottom right: comparison
subplot(2, 2, 4);
plot(freq_axis, X_rect_dB(1:N/2), 'b', 'LineWidth', 1.2); hold on;
plot(freq_axis, X_hamm_dB(1:N/2), 'Color', [0.5 0 0.8], 'LineWidth', 1.5);
title('Frequency Spectrum Comparison');
xlabel('Frequency Bin'); ylabel('Magnitude (dB)');
legend('Rectangular Window', 'Hamming Window', 'Location', 'northeast');
grid on; xlim([0 40]); ylim([-60 5]);