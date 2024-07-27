% Specify the file path
file_path = 'filteredsignal.txt';


% Read the CSV file into a table
table_data = readtable(file_path);

% Convert the table to an array
x = table2array(table_data);


while true
    
    
    % Plot Configuration
    fm = 10000; % Maximum display frequency.
    plot_title = 'Output Signal Spectrum';
    x_label = '$f$(Hz)';
    y_label = '$|Y(e^{j2\pi f})|_{dB}$';

    % Realization of FFT and normalization.
    fft_signal = fft(x);
    fft_length = length(fft_signal);
    fft_signal = abs(fft_signal)/fft_length;
    f0 = Fs/fft_length;
    f0max = (fft_length - 1)*f0;
    f = 0:f0:f0max;

    % Frequency signal correction.
    metade = fft_length/2;
    fp = f(1:metade);
    fft_signal_positive = fft_signal(1:metade);
    fn = f(metade+1:fft_length) - f0max - f0;
    fft_signal_negative = fft_signal(metade+1:fft_length);
    ft = [fn, fp];
    fft_signal_total = [fft_signal_negative', fft_signal_positive'];
    fft_signal_total = fft_signal_total';
    
  
    y_db = 20*log(fft_signal_total);
    
    % Display of the spectrum of the input signal.
    plot(ft, y_db); grid on;
    xlim([0 fm])
    ylim([-400 0])
    title(plot_title);
    hTitle = get(gca, 'title');
    set(hTitle, 'FontSize', 48, 'FontWeight', 'bold')
    xlabel(x_label, 'interpreter', 'latex','FontSize', 24);
    ylabel(y_label, 'interpreter', 'latex','FontSize', 24);
    drawnow
    
   
end

