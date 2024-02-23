function best_candidate = affiche_correlation(correlation)
    [RK, IK] = sort(max(abs(correlation), [], 2), 'descend');
    plot((0:size(correlation, 2) - 1), correlation(IK(1), :), 'm')
    hold on

    if IK(1) == 1
        plot((0:size(correlation, 2) - 1), correlation(2:end, :), 'Color', [0, 0, 1, 0.4]) % Courbe bleue avec opacité réduite
    else
        if IK(1) == 16
            plot((0:size(correlation, 2) - 1), correlation(1:end - 1, :), 'Color', [0, 0, 1, 0.4]) % Courbe bleue avec opacité réduite
        else
            plot((0:size(correlation, 2) - 1), correlation(1:IK(1) - 1, :), 'Color', [0, 0, 1, 0.4]) % Courbe bleue avec opacité réduite
            plot((0:size(correlation, 2) - 1), correlation(IK(1) + 1:end, :), 'Color', [0, 0, 1, 0.4]) % Courbe bleue avec opacité réduite
        end
    end

    best_candidate = IK(1) - 1;
end
