function [C, sigma] = learningParams(X, y, Xval, yval)
%Returns the optimal C and sigma learning parameters to use for SVM with RBF kernel
%   [C, sigma] = learningParams(X, y, Xval, yval) returns your choice of C and sigma. 

C = 1;
sigma = 0.3;

steps = [ 0.01 0.03 0.1 0.3 1 3 10 30 ];
minError = Inf;
minC = Inf;
minSigma = Inf;

% i*j means every condition of different C and Sigma.
for i = 1:length(steps)
    for j = 1:length(steps)
        currentC = steps(i);
        currentSigma = steps(j);
        model = svmTrain(X, y, currentC, @(x1, x2) gaussianKernel(x1, x2, currentSigma));
        predictions = svmPredict(model, Xval);
        error = mean(double(predictions ~= yval));

        if(error < minError)
            minError = error;
            minC = currentC;
            minSigma = currentSigma;
        end
    end    
end

C = minC;
sigma = minSigma;

end
