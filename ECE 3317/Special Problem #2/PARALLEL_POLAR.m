function [] = PARALLEL_POLAR( H0, E, w, theta, k0, Er1, ur1, Er2, ur2, x_neg, x_pos, x)
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

    R = (Er2*kz - Er1*ktz)/(Er2*kz + Er1*ktz);
    T = 1 + R;
    
    x_neg_mod = x_neg .* kz; %equivalent to kz * z

    % H-field
    y_neg_incident = H0 .* exp(-1i * x_neg_mod);
    y_neg_reflect = R .* H0 .* exp(1i * x_neg_mod);
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs( T .* H0 .* exp(-1i .* ktz .* x_pos));
    y = horzcat(y_neg, y_pos);

    figure();
    set(gcf, 'pos', [1, 1, 800 ,600]);
    subplot(3,1,1);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Hy| in [A/m]');
    title('Plot of H-field vs Z, Parallel Polarization');

    grid on

    % E-field (X)
    y_neg_incident = ((kz*H0)/(w*Er1*E) .* exp(-1i .* x_neg_mod));
    y_neg_reflect = (-(kz*R*H0)/(w*Er1*E) .* exp(1i .* x_neg_mod));
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs( (ktz*T*H0)/(w*Er2*E) .* exp(-1i .* ktz .* x_pos));
    y = horzcat(y_neg, y_pos);

    subplot(3,1,2);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Ex| in [V/m]');
    title('Plot of E(x)-field vs Z, Parallel Polarization');

    grid on

    % E-field (Z)
    y_neg_incident = (-(kx*H0)/(w*Er1*E) .* exp(-1i .* x_neg_mod));
    y_neg_reflect = (-(kx*R*H0)/(w*Er1*E) .* exp(1i .* x_neg_mod));
    y_neg = abs(y_neg_incident + y_neg_reflect);
    y_pos = abs(-(kx*T*H0)/(w*Er2*E) .* exp(-1i .* ktz .* x_pos));
    y = horzcat(y_neg, y_pos);

    subplot(3,1,3);
    plot(x,y);
    xlabel('z [m]');
    ylabel('|Ez| in [V/m]');
    title('Plot of E(z)-field vs Z, Parallel Polarization');

    grid on
end