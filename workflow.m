% =========================================================================
% MATLAB script to generate the Audio Denoising Workflow Diagram
% Developed for linear algebra / DSP project report
% =========================================================================
clear; clc; close all;

%% 1. Set up the figure
fig = figure('Position', [100, 100, 1200, 400], 'Color', 'w', 'Name', 'Denoising Workflow');
hold on; axis off;
xlim([0.5, 9.75]);
ylim([-1.5, 1.5]);

%% 2. Draw the main timeline axis and arrow
plot([0.5, 9.5], [0, 0], 'k-', 'LineWidth', 1.2, 'Color', [0.3 0.3 0.3]);
% Draw the arrowhead at the end of the timeline
patch([9.4, 9.55, 9.4], [0.05, 0, -0.05], [0.3 0.3 0.3], 'EdgeColor', 'none');

%% 3. Define the nodes data
% Text labels (using cell arrays for multiline text alignment)
labels = {
    {'Break Audio', 'into Chunks'}, ...
    {'Apply Window', 'Function'}, ...
    {'Convert to', 'Frequency', 'Domain'}, ...
    {'Estimate Noise', 'Spectrum'}, ...
    {'Compute Gain'}, ...
    {'Multiply Gain', 'with Spectrum'}, ...
    {'Transform', 'Back to Time', 'Domain'}, ...
    {'Overlap and', 'Add Chunks'}, ...
    {'Smooth Gains'}
};

% Position flags: 1 for Top placement, -1 for Bottom placement
pos_flag = [1, -1, 1, -1, 1, -1, 1, -1, 1];

% Colors carefully matched to the icons in the original image
colors = [
    0.18, 0.49, 0.85;  % 1. Blue (Break)
    0.35, 0.65, 0.81;  % 2. Light Blue (Window)
    0.31, 0.72, 0.40;  % 3. Green (Convert)
    0.55, 0.68, 0.29;  % 4. Olive (Estimate)
    0.91, 0.77, 0.17;  % 5. Yellow (Compute)
    0.90, 0.53, 0.16;  % 6. Orange (Multiply)
    0.85, 0.28, 0.28;  % 7. Red (Transform)
    0.84, 0.36, 0.66;  % 8. Pink (Overlap)
    0.62, 0.35, 0.71   % 9. Purple (Smooth)
];

%% 4. Plot each node and its text
for i = 1:length(labels)
    % Draw the timeline node (small white circle with grey edge)
    plot(i, 0, 'ko', 'MarkerFaceColor', 'w', 'MarkerEdgeColor', [0.4 0.4 0.4], ...
        'MarkerSize', 5, 'LineWidth', 1.2);

    % Draw a colored square marker to represent the "icon" placement
    icon_y = 0.35 * pos_flag(i);
    plot(i, icon_y, 's', 'MarkerEdgeColor', colors(i,:), 'MarkerFaceColor', 'w', ...
        'MarkerSize', 26, 'LineWidth', 2);

    % Add the text label above or below the icon
    text_y = icon_y + (0.22 * pos_flag(i));
    
    if pos_flag(i) == 1
        valign = 'bottom';
    else
        valign = 'top';
    end

    text(i, text_y, labels{i}, 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', valign, 'FontSize', 11, 'Color', [0.2 0.2 0.2], ...
        'FontName', 'Arial');
end

%% 5. Add the figure title/caption at the bottom
text(5, -1.3, 'Fig. 1. Denoising workflow of audio', 'HorizontalAlignment', 'center', ...
    'FontSize', 18, 'FontName', 'Times New Roman', 'Color', 'k');