function [Fx, Fy, T] = BeamSolver(m, L, D)
    g=9.8;
    theta = atan(D./L);
    %First coefficient is Fx, then Fy, and finally T
    equations = [ 1, 0, -cos(theta); 0, 1, sin(theta); 0, 0, sin(theta).*L];
    balance = [0; m.*g; m.*g.*L./2];
    answers = equations\balance;
    Fx = answers(1);
    Fy = answers(2);
    T = answers(3);
end