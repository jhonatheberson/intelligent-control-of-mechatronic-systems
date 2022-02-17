function [filho] = crossover2(pai,mae)
crossoverindex = randperm(7,1);
c1 = [pai(1:crossoverindex) mae(crossoverindex+1:end)];
filho = c1;

end
