clear ; close all; clc; addpath('functions'); 
%% ================= SUPPORT VECTOR MACHINES (SVM)====================== %%
%  written by : JAWAD FAYAZ (email: jfayaz@uci.edu)
%  visit: (https://jfayaz.github.io)

%  ------------- Instructions -------------- %
%  INPUT:
%  Input Variables must be in the form of .mat file and must be in same directory
%  Input Variables should include:
%  "X"   -->  Matrix (m,2) with each column as the Input data feature
%  "y"   -->  Matrix (m,1) with labels of saperation of the data (0 or 1)
%
%  OUTPUT:
%  Output will be provided in structure "model" and variable "sim" 
%  "model" --> Structure containing the data and results of SVM 
%  "sim"   --> (if SVM_Type = 'RBF') Double (1,1) contains the Gaussian Kernel between x1 and x2 given in the code


%%%%% ============================================================= %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ======================== USER INPUTS =============================== %%

%%% Provide your .mat file name here 
%%% For example: 'Exdata1.mat' contains 2-D data and 'Exdata2.mat' contains MultiDimensional data
Matlab_Data_Filename = 'Exdata3.mat';

%%% Type of Decision Boundary (options: 'Linear', 'RBF') 
%%% 'RBF' can take long time
SVM_Type = 'Linear';


 
%%%%%%================= END OF USER INPUT ========================%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% =============== Loading and Visualizing Data ================
fprintf('Loading and Visualizing Data ...\n')

load(Matlab_Data_Filename);

% Plotting the Training data
plotData(X, y);


if strcmpi(SVM_Type,'Linear') == 1
    %% ==================== Linear SVM ==================== %%
    
    %  The following code will train a linear SVM on the dataset and plot the
    %  decision boundary learned.
    fprintf('\nTraining Linear SVM ...\n')
    
    %%% SVM Parameter
    C = 1; 
    
    % Training the SVM
    model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
    
    % Plotting the Linear SVM Boundary
    visualizeBoundaryLinear(X, y, model);

elseif strcmpi(SVM_Type,'RBF') == 1
    %% =============== Gaussian Kernel SVM ===============
    
    %  Implementing the Gaussian kernel to use with the SVM. 
    fprintf('\nEvaluating the Gaussian Kernel ...\n')
    x1 = [1 2 1]; x2 = [0 4 -1]; sigma = 2;
    sim = gaussianKernel(x1, x2, sigma);

    fprintf(['Gaussian Kernel between x1 = [1; 2; 1], x2 = [0; 4; -1], sigma = %f :' ...
             '\n\t%f\n\n'], sigma, sim);
        
    % Loading vals.mat used for learning C and sigma
    load('vals.mat')
    
    % Figuring SVM Parameters 
    [C, sigma] = learningParams(X, y, Xval, yval);

    % Training the SVM
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    
    % Plotting the SVM Boundary
    visualizeBoundary(X, y, model);

end  

xlabel('X','fontWeight','bold')
ylabel('y','fontWeight','bold')
set(gca,'fontsize',14,'FontName', 'Times New Roman','LineWidth', 1.25,'TickDir','out','TickLength', [0.005 0.005])
grid on; box on;



