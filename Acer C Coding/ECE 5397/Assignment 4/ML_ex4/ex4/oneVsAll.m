function [all_theta, all_cost] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logisitc regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

% Some useful variables
m = size(X, 1);
n = size(X, 2);
num_iterations = 50;

% You need to return the following variables correctly 
all_theta = zeros(num_labels, n + 1);
hold_cost = zeros(num_iterations, num_labels);
% all_cost = zeros(1, num_labels);

% Add ones to the X data matrix
X = [ones(m, 1) X];

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the following code to train num_labels
%               logistic regression classifiers with regularization
%               parameter lambda. 
%
% Hint: theta(:) will return a column vector.
%
% Hint: You can use y == c to obtain a vector of 1's and 0's that tell use 
%       whether the ground truth is true/false for this class.
%
% Note: For this assignment, we recommend using fmincg to optimize the cost
%       function. It is okay to use a for-loop (for c = 1:num_labels) to
%       loop over the different classes.
%
%       fmincg works similarly to fminunc, but is more efficient when we
%       are dealing with large number of parameters.
%
% Hint:
%

%     % Set Initial theta
initial_theta = zeros(n + 1, 1);

%     % Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', num_iterations);

%     % Run fmincg to obtain the optimal theta
%     % The way we use fmincg is similar to fminunc 
%     [theta, cost] = ...
%     fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
%


for c = 1:num_labels
    [all_theta(c,:), hold_cost(:,c)] = fmincg (@(t)(lrCostFunction(t, X, (y==c), lambda)), initial_theta, options);   
end

% =========================================================================

all_cost = hold_cost(end,:)';

end
