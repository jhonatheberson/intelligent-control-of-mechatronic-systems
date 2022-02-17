function [selecionado] = roleta(VetorEntrada)
    VetorPesos = zeros(1,length(VetorEntrada));
    SomaPeso = 0;

    %Somatorio dos pesos
    for i = 1:length(VetorEntrada)
        SomaPeso = SomaPeso + (1/VetorEntrada(i));    
    end

    soma_entradas = 0;
    %Criacao dos vetores de pesos normalizados
    for i = 1:length(VetorPesos)
       VetorPesos(i) = (1/VetorEntrada(i))/SomaPeso; 
       soma_entradas = soma_entradas + VetorPesos(i);
    end

    %Quantos individuos serao selecionados
    qtd_selecionada = 2;
    %Normalizacao das probabilidades 
   % probabilidades = cumsum(VetorPesos/soma_entradas);
    probabilidades = VetorPesos/soma_entradas;
    selecionado = zeros(1,length(VetorPesos));

    for i = 1:qtd_selecionada
        r = rand();
        acomulador = 0;
        %disp(r);
        for j = 1:length(probabilidades)
            acomulador = acomulador + probabilidades(j);
            if acomulador >= r
                selecionado(i) = j;
                break
            end
        end
        
    end
 end
