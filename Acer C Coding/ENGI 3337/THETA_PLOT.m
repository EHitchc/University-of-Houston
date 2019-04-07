function [] = THETA_PLOT(k, N, psi, d, phi, theta)
    %% Initialisation
    sinPhi = sin(pi()/180 .* phi);
    sinTheta = sin(pi()/180 .* theta);
    cosGamma = sinPhi .* sinTheta;

    %AF Calculation
    numerator = sin(N.*((k.*d .* cosGamma + psi)./2));
    denominator = sin((k.*d .* cosGamma + psi)./2);

    AF = abs(numerator./denominator);

    %Plot
    figure();
    hold on;

    %x-y plane (AF vs Theta)
    subplot(1,2,1);
    plot(theta, AF);
    title('Array Factor vs Theta');
    xlabel('Theta [degrees]');
    ylabel('Array Factor');
    grid on;
    axis([-180 180 0 N]);

    %polar plot (AF vs Theta)
    subplot(1,2,2);
    polarplot(theta .* pi()/180, AF);
    title('Polar Plot of Array Factor at an Angle, Theta, from the Source');
    set(gcf, 'Position', [50 130 1200 500]);

end