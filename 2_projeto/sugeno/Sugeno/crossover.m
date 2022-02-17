function [filho_retorno] = crossover(pai,mae)


retorno = false;
while retorno == false 
    x = 1;
    lambda = zeros(length(pai),1);    
    for i=1:length(pai)
    lambda(i,1) = rand();
    end
    filho=zeros(1,length(pai));
    for j=1:length(pai)
        filho(1,j) = lambda(j,1)*pai(1,j)+(1-lambda(j,1))*mae(1,j);
    end 
    g=0;
    while x <= 13
        if filho(1,x) > filho(1,x+1) || filho(1,x) > filho(1,x+2) || filho(1,x+1) > filho(1,x+2)
            retorno = false;
            g = g+1;
        end
        if x < 13
            x = x+3;
        else
            x = 14;
        end       
    end
    if g == 0
        retorno = true;
    end
    disp('Filho nao valido!')
end

r=rand();
    if r<0.03
        disp('O filho sofreu mutacao!')
        retorno = false;
            while retorno == false
                x=1; 
                gene1 = randperm(length(filho),1);
                gene2 = randperm(length(filho),1);
                z = filho(1,gene1);
                y = filho(1,gene2);
                filho(1,gene1) = y;
                filho(1,gene2) = z;  
            w = 0;
            while x <= 13
                if filho(1,x) > filho(1,x+1) || filho(1,x) > filho(1,x+2) || filho(1,x+1) > filho(1,x+2)
                    retorno = false;
                    w = w+1;
                end
                if x < 13
                    x = x+3;
                else
                    x = 14;
                end  
            end 
                if w == 0
                    retorno = true;
                end
            end
    end
filho_retorno = filho;

end

