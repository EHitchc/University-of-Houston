function [theta, J_history] = gradientDescent_incorrect(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. However you should update theta_0 fisrt, then
    %               update theto_1.
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

    temp1 = theta(1) - alpha/m * sum(X(:,1).*((X*theta)-y));    
    theta(1) = temp1;
    
    temp2 = theta(2) - alpha/m * sum(X(:,2).*((X*theta)-y));
    theta(2) = temp2;   
    
    
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
