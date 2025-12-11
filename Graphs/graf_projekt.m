% === Time vector (in minutes) ===
time = 0:5:180;  % every 5 minutes for 3 hours

% === Simulate oscillating charge/discharge pattern ===
% (positive = discharge, negative = charge)
rng(1);  % for reproducibility
oscillations = 8 * sin(0.3 * time) + 6 * cos(0.8 * time);  % oscillating pattern
trend = linspace(100, 0, length(time));                     % overall discharge trend
energy_profile = oscillations + trend;                      % combine trend + oscillation

% === Convert to rate of energy flow (positive=discharge, negative=charge) ===
energy_change = -diff(energy_profile);  % difference between points
energy_change = [energy_change 0];      % pad to keep same length

% === Plot the discrete charge/discharge energy flow ===
figure;
stairs(time, energy_change, 'LineWidth', 2, 'Color', [0.85 0.33 0.1]);

% === Formatting ===
xlabel('Time (minutes)');
ylabel('Charge / Discharge Energy [%]');
title('Discrete EV Charge–Discharge Energy Flow Over 3 Hours');
grid on;

% Reference lines
yline(0, '--k', 'Zero Line (No Charge/Discharge)', 'LabelVerticalAlignment', 'bottom');
xlim([0 180]);
ylim([-15 15]);

% Customize the x-axis ticks for more detailed display
xticks(0:1:180); % Show ticks for every minute on x-axis

legend('Charge/Discharge Flow', 'Location', 'best');
