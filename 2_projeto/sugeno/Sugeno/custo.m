%calcula o custo de cada individuo                
function [custos] = custo(Erro,SinalControle)
        %PARAMETROS ----------------- testar valores
        %alpha1 = 2;
        %alpha2 =1;
        %alpha3 = 0.95;
%         alpha1 = 0.8;
%         alpha2 = 1;   exp_1
%         alpha3 = 0.7;
        alpha1 = 2.0;
        alpha2 = 1.2;
        alpha3 = 0.7;
        %------------------------------
      
        NovoErro = Erro.data(:,1);
        IAEx = sum(abs(NovoErro))/length(NovoErro);
        scx = SinalControle.data(:,2);
        e1x = sum(scx)/length(scx);
        e2x = sum((scx-ones(size(scx))*e1x).^2)/length(scx);
        e3x = sum(NovoErro.^2)/length(NovoErro); 
  
        GIx = alpha1*e1x + alpha2*e2x + alpha3*e3x; 
  
        %custox = IAEx;
        custox = IAEx + GIx;
  
        custos = custox;
end


% Avalia??o de desempenho com base no Crit?rio de Goodhart:
%
%      O ?ndice de Goodhart ? da por:
%
%            IG = alfa1 * Eig1 + alfa2 * Eig2 + alfa3 * Eig3
%
% sendo assim:
%
%            E1 est? relacionado ao sinal de controle m?dio aplicado;
%            E2 est? relacionado ? varia??o do sinal de controle com
% rela??o ao sinal m?dio (E1); 
%            E3 est? relacionado ao erro absoluto de rastreamento.
% e:
%            alfa1, alfa2 e alfa3 s?o coeficientes de pondera??o a serem
% determinados pele projetista/usu?rio.

