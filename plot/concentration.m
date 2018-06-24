clear all;

fn = '../data/cnt_radius_EC.mat';

newData1 = load('-mat', fn);
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

volume = zeros(size(cnt_radius_count(1, :), 2)-1, 1);
for i = 1:size(cnt_radius_count(1, :), 2)-1
    volume(i) = 4/3*pi*rls(i+1)^3 - 4/3*pi*rls(i)^3;
end

cnt_radius_count_modified = zeros(size(cnt_radius_count(:, 1), 1), size(cnt_radius_count(1, :), 2)-1);

for t_curr = 1:size(cnt_radius_count(:, 1), 1)
    for r_curr = 1:size(cnt_radius_count(1, :), 2)-1
        cnt_radius_count_modified(t_curr, r_curr) = cnt_radius_count(t_curr, r_curr) / volume(r_curr);
    end
end

x = rls(1:size(volume, 1));

figure;
hLine = imagesc(t, x, cnt_radius_count_modified');
set(gca, 'FontSize', 30);
xlabel('$t$', 'Interpreter', 'latex');
set(gca, 'FontSize', 30);
ylabel('$r$', 'Interpreter', 'latex');
colormap hot;
h = colorbar;
set(gca, 'FontSize', 30);
title(h, '$n$', 'FontSize', 33, 'interpreter','latex');
set(gca,'YDir','normal');
hold all;


figure;
plot(x, cnt_radius_count_modified(end,:))
set(gca, 'FontSize', 30);
xlabel('$r$', 'Interpreter', 'latex');
set(gca, 'FontSize', 30);
ylabel('$n$', 'Interpreter', 'latex');
