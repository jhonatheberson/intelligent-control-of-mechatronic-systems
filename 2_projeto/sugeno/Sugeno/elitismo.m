function [menor] = elitismo(Vetpeso)
    menor1 = [99999,0];
    menor2 = [99999,0];
    for i = 1:length(Vetpeso)
        if (Vetpeso(i)< menor1(1)) || (Vetpeso(i)< menor2(1))
            menor2 = menor1;
            menor1(1) = Vetpeso(i);
            menor1(2) = i;
        end
    end
    menor = [menor1(2), menor2(2)];
end

%function [maior] = elitismo(Vetpeso)
    %maior1 = [0,0];
    %maior2 = [0,0];
    %for i = 1:length(Vetpeso)
        %if (Vetpeso(i)> maior1(1))         
            %maior1(1) = Vetpeso(i);
%             maior1(2) = i;
%         elseif (Vetpeso(i)> maior2(1))
%                 maior2(1) = Vetpeso(i);
%                 maior2(2) = i;
%         end
%     end
%     maior = [maior1(2), maior2(2)];
% end