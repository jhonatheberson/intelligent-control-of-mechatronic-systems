function [filho_retorno] = crossover3(pai,mae)

lambda = zeros(length(pai),1);    
    for i=1:length(pai)
        lambda(i,1) = rand();
    end
filho=zeros(1,length(pai));
    for j=1:length(pai)
        filho(1,j) = lambda(j,1)*pai(1,j)+(1-lambda(j,1))*mae(1,j);
    end 
    
r=rand();
    if r<0.03
        disp('O filho sofreu mutacao!')
            gene1 = randperm(length(filho),1);
            gene2 = randperm(length(filho),1);
            z = filho(1,gene1);
            y = filho(1,gene2);
            filho(1,gene1) = y;
            filho(1,gene2) = z;           
    end
    
filho_retorno =Ordenacao((filho),0);

end

