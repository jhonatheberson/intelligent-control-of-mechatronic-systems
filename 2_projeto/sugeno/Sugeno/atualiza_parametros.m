%atualiza parametros
function controlador_final = atualiza_parametros(controlador, LimiteMin, LimiteMax, LimiteMin_dterro, LimiteMax_dterro,SinalControle_min,  SinalControle_max,  Vetor_entrada1,  Vetor_entrada2,Vetor_parametros1)
    %seta o range das entradas
    controlador.input(1).range = [LimiteMin LimiteMax];
    controlador.input(2).range = [LimiteMin_dterro LimiteMax_dterro];
    
    %seta o range das saidas
    controlador.output(1).range = [SinalControle_min SinalControle_max];
    
    %atualiza os parametros de cada funcao de pertinencia entrada
    controlador.input(1).mf(1).params = [Vetor_entrada1(1) Vetor_entrada1(2) Vetor_entrada1(3)];
    controlador.input(1).mf(2).params = [Vetor_entrada1(4) Vetor_entrada1(5) Vetor_entrada1(6)];
    controlador.input(1).mf(3).params = [Vetor_entrada1(7) Vetor_entrada1(8) Vetor_entrada1(9)];
    controlador.input(1).mf(4).params = [Vetor_entrada1(10) Vetor_entrada1(11) Vetor_entrada1(12)];
    controlador.input(1).mf(5).params = [Vetor_entrada1(13) Vetor_entrada1(14) Vetor_entrada1(15)];
       
    controlador.input(2).mf(1).params = [Vetor_entrada2(1) Vetor_entrada2(2)];
    controlador.input(2).mf(2).params = [Vetor_entrada2(3) Vetor_entrada2(4)];
    controlador.input(2).mf(2).params = [Vetor_entrada2(5) Vetor_entrada2(6)];
   
    %atualiza valores das saidas
    controlador.output(1).mf(1).params = [Vetor_parametros1(1) Vetor_parametros1(2) 0];
    controlador.output(1).mf(2).params = [Vetor_parametros1(3) Vetor_parametros1(4) 0];
    controlador.output(1).mf(3).params = [Vetor_parametros1(5) Vetor_parametros1(6) 0];
    
%     j=1;    
%     for i=1:10
%         controlador.output(1).mf(i).params = [Vetor_parametros1(j) Vetor_parametros2(j) 0];
%         j = j + 1;
%     end

    controlador_final = controlador;
end