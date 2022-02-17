function[Vetor] = Ordenarcao(Vetor,flag)
if(flag == 0)    
    subvetor = zeros(1,(length(Vetor))/2);
    j = 1;
    for i = 2:2:length(Vetor)
        subvetor(1,j) = Vetor(i);
        j = j+1;
    end
    subvetor = sort(subvetor);
    j = 1;
    for i = 2:2:length(Vetor)
        Vetor(i) = subvetor(1,j);
        j = j+1;
    end
end

if(flag == 1)
    Vetor = sort(Vetor);    
    aux = Vetor(5);
    Vetor(5) = Vetor(4);
    Vetor(4) = aux;
end


