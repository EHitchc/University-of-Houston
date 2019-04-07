function [] = PERPENDICULAR_POLAR( E0, u, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x)
    k1 = k0 * sqrt(Er1 * ur1);
    k2 = k0 * sqrt(Er2 * ur2);

    kx = k1 .* sin(theta);
    kz = k1 .* cos(theta);

    ktz = sqrt(k2^2 - kx^2); 
    
    if Er1 > Er2
        theta_c = asin(sqrt((Er2*ur2)/(Er1*ur1)));
        if theta > theta_c 
            ktz = -ktz;
        end
    end
    
    R = (ur2*kz - ur1*ktz)/(ur2*kz+ur1*ktz);
    T = 1 + R;

    x_neg_mod = x_neg .* kz; %equivalent to kz * z

    % E-field
    y_neg_incident = E0 .* exp(-1i .* x_neg_mod);
    y_neg_reflect = E0 .* R .* exp(1i .* x_neg_mod);
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs(T .* E0 .* exp(-1i .* x_pos .* ktz));
    y = horzcat (y_neg, y_pos);

    figure();
    set(gcf, 'pos', [1, 1, 800 ,600]);
    subplot(3,1,1);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Ey| in [V/m]');
    title('Plot of E-field vs Z, Perpendicular Polarization');

    grid on

    % H-field (X)
    y_neg_incident = ((-kz*E0) / (w*ur1*u)) .* exp(-1i.*x_neg_mod);
    y_neg_reflect = ((kz*R*E0) / (w*ur1*u)) .* exp(1i.*x_neg_mod);
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs(((-ktz*T*E0) / (w*ur2*u)) .* exp(-1i .* x_pos .* ktz));
    y = horzcat (y_neg, y_pos);

    subplot(3,1,2);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Hx| in [A/m]');
    title('Plot of H(x)-field vs Z, Perpendicular Polarization');

    grid on

    % H-field (Z)
    y_neg_incident = ((kx*E0) / (w*ur1*u)) .* exp(-1i.*x_neg_mod);
    y_neg_reflect = ((kx*R*E0) / (w*ur1*u)) .* exp(1i.*x_neg_mod);
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs(((kx*T*E0) / (w*ur2*u)) .* exp(-1i .* x_pos .* ktz));
    y = horzcat (y_neg, y_pos);

    subplot(3,1,3);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Hz| in [A/m]');
    title('Plot of H(z)-field vs Z, Perpendicular Polarization');
    
    grid on
end