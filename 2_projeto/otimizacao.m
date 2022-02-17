clear all
close all
clc
tic;

%% Parameter Range Definition

d = [0.001    1];     %diametro interno [m]
t = [0.001    0.5];   %m espessura [m]

LB = [d(1),t(1)]; %Limites inferiores
UB = [d(2),t(2)]; %Limites Superiores

%% Solver configuration

numberOfVariables = size(LB,2);
generations_number = 200;
population_size = 1000;
EliteCount_Data = round(0.05*population_size);
    
options = gaoptimset('UseParallel',false);
options = gaoptimset(options,'PopulationSize',population_size);
options = gaoptimset(options,'PopInitRange', [LB;UB;]);
options = gaoptimset(options,'Generations',generations_number);
options = gaoptimset(options,'PopulationType','doubleVector');%'bitstring' | 'custom' | {'doubleVector'}
options = gaoptimset(options,'EliteCount', EliteCount_Data);%0.05*ParamsGA.population_size
options = gaoptimset(options,'StallGenLimit',10);
options = gaoptimset(options,'Display', 'iter');%'off','iter','diagnose','fina'

rng default
FitnessFunction = @(v)otimizada(v);

%% solver

[x,fval] = ga(FitnessFunction,numberOfVariables,[],[],[],[],LB,UB,[],[],options);


toc;