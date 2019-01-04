function sim = gaussianKernel(x1, x2, sigma)
%Returns a radial basis function kernel between x1 and x2
%   sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
%   and returns the value in sim

% Ensuring that x1 and x2 are Column vectors
x1 = x1(:); x2 = x2(:);

sim = 0;

norm_squared = sum((x2 - x1).^2);

sim = exp(-norm_squared/(2*sigma^2));
   
end
