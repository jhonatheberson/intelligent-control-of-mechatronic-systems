function[VetRetorno] = Inicializacao(VetEntrada,LimiteMin,LimiteMax,Abertura)

% if Abertura == 1 
% for i = 1:length(VetEntrada)
%     if i == 7
%         VetRetorno(1,i) = -30;     
%     elseif i == 8
%         VetRetorno(1,i) = 0;
%     elseif i == 9
%         VetRetorno(1,i) = 30; 
%     else
%     VetRetorno(1,i) = LimiteMin + (LimiteMax-LimiteMin)*rand();
%     end 
% end
% end
% if Abertura == 2
%     for i = 1:length(VetEntrada)
%     if i == 7
%         VetRetorno(1,i) = -1;     
%     elseif i == 8
%         VetRetorno(1,i) = 0;
%     elseif i == 9
%         VetRetorno(1,i) = 1; 
%     else
%     VetRetorno(1,i) = LimiteMin + (LimiteMax-LimiteMin)*rand();
%     end 
%     end
% end
% 
% if Abertura == 3
%     for i = 1:length(VetEntrada)
%     if i == 7
%         VetRetorno(1,i) = -4;     
%     elseif i == 8
%         VetRetorno(1,i) = 0;
%     elseif i == 9
%         VetRetorno(1,i) = 4; 
%     else
%     VetRetorno(1,i) = LimiteMin + (LimiteMax-LimiteMin)*rand();
%     end    
%     end
% end

VetRetorno = LimiteMin + (LimiteMax-LimiteMin)*rand(1,length(VetEntrada));

%if(Abertura ~= 0)
    %for i = 1:2:length(VetEntrada)
    %VetRetorno(1,i) = Abertura;
    %end
end
