function[VetRetorno] = Inicializacao2(VetEntrada,LimiteMin,LimiteMax,Abertura)
VetRetorno = LimiteMin + (LimiteMax-LimiteMin)*rand(1,length(VetEntrada));
if(Abertura ~= 0)
    for i = 1:2:length(VetEntrada)
    VetRetorno(1,i) = Abertura;
    end
end