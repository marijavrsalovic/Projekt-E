% Time points (hours)
time = [0 6 8 11 13 16 18 22 24];

% Energy discharge/charge profile (positive for discharge, negative for charge)
energy_profile = [0 +30 0 +15 -10 +30 -30 0 0];

% Create discrete step graph
figure;
stairs(time, energy_profile, 'LineWidth', 2, 'Color', [0.85 0.33 0.1]);
hold on;
plot(time, energy_profile, 'o', 'MarkerFaceColor', [0.85 0.33 0.1]);

% Add labels and formatting
xlabel('Time (hours)');
ylabel('Charge/Discharge Energy [%]');
title('EV Charge/Discharge Energy During the Day (Positive/Negative)');
grid on;

% Set limits and reference lines
xlim([0 24]);
ylim([-40 40]);
yline(0, '--k', 'Zero Line (No Charge/Discharge)', 'LabelVerticalAlignment', 'bottom');
legend('Charge/Discharge Energy', 'Location', 'best');
