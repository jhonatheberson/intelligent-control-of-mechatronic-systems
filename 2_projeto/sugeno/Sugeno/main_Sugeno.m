%%
clear;
clc;

%Variáveis globais
NumeroIndividuos = 20; 
NumeroGeracoes = 20; 

%Entradas
VetEntrada1 = zeros(1,15,NumeroIndividuos);
VetEntrada2 = zeros(1,6,NumeroIndividuos);

%filhos 
Filho_entrada_1 = zeros(1,15,NumeroIndividuos);
Filho_entrada_2 = zeros(1,6,NumeroIndividuos);
Filho_saida_1 = zeros(1,6,NumeroIndividuos);

%Saídas
VetParametro1Saida = zeros(1,6,NumeroIndividuos);

%Custo
VetCustos = zeros(1,NumeroIndividuos);
Vetadaptabilidade = zeros(1,NumeroIndividuos);

%Melhor custo
VetMelhorCusto = zeros(1,NumeroGeracoes);
soma_custos=0;

%Regras
regras=zeros(1,15,NumeroIndividuos);


%%

%INICIALIZAÇÃO 
fis = readfis('ControleSugeno2_Thiago');
matriz_regras = zeros(15,5,NumeroIndividuos);
for i = 1:NumeroIndividuos
   if i == 1
       VetEntrada1(:,:,i) = [-45 -30 -15 -20 -12 -3 -8 0 8 3 12 20 15 30 45];
       VetEntrada2(:,:,i) = [0.2 -1 0.3539 0.004228 -0.2 1];
       VetParametro1Saida(:,:,i) = [0.25 1  0.05 0.85 0.01 0.1];
       regras(:,:,i) = [3 3 3 2 2 2 1 1 1 3 3 3 2 2 2];

   else
    VetEntrada1(:,:,i) = sort(Inicializacao(VetEntrada1(:,:,i),-30,30,1));
    %VetEntrada1(:,:,i) = Ordenarcao(VetEntrada1(:,:,i),1);
    VetEntrada2(:,:,i) = Inicializacao2(VetEntrada2(:,:,i),-1,1,0.5);
    VetEntrada2(:,:,i) = Ordenacao(VetEntrada2(:,:,i),0);
    %VetEntrada2(:,:,i) = sort(VetEntrada2(:,:,i));

    VetParametro1Saida(:,:,i) = Inicializacao2(VetParametro1Saida(:,:,i),0,4,0);
   
        for u=1:15
            regras(1,u,i) = randperm(3,1);
        end
    end

%ATUALIZACAO DE PARÂMETROS DO CONTROLADOR
t=1;
q=1;
    for j=1:5
        for p=1:3
        matriz_regras(q,:,i) = [j p regras(1,t,i) 1 1];
        t = t+1;
        q=q+1;
        end
    end
    fis = atualiza_parametros(fis,-30,30,-1,1,-4,4,VetEntrada1(:,:,i),VetEntrada2(:,:,i),VetParametro1Saida(:,:,i));
    fis.Rules = [];
    writeFIS(fis,'Sugeno_otimizado');
    rules = matriz_regras(:,:,i);
    fis2 = addRule(fis,rules);
    %SIMULACAO
    fis = atualiza_parametros(fis2,-30,30,-1,1,-4,4,VetEntrada1(:,:,i),VetEntrada2(:,:,i),VetParametro1Saida(:,:,i));
    sim('Simulador_Tanques');
    
    %CALC DE CUSTO 
    VetCustos(1,i) = custo(Erro,SinalDeControle);
    Vetadaptabilidade(1,i) = 1/VetCustos(1,i);
    soma_custos = soma_custos + Vetadaptabilidade(1,i);
    
end
%%

disp('Custos:')
disp(VetCustos)
disp('Adaptabilidade:')
disp(Vetadaptabilidade)
 
%Elitismo1
melhores = elitismo(VetCustos);
melhorent1_1 = VetEntrada1(:,:,melhores(1,1));
melhorent2_1 = VetEntrada2(:,:,melhores(1,1));
melhorsai1_1 = VetParametro1Saida(:,:,melhores(1,1));
melhor_regra1 = regras(:,:,melhores(1,1));

melhorent1_2 = VetEntrada1(:,:,melhores(1,2));
melhorent2_2 = VetEntrada2(:,:,melhores(1,2));
melhorsai1_2 = VetParametro1Saida(:,:,melhores(1,2));
melhor_regra2 = regras(:,:,melhores(1,2));

%%Mantendo os 2 melhores da geração anterior
Interacao = NumeroIndividuos-2;
%%
VetCustoMedio = zeros(1,NumeroGeracoes);
VetAdaptabilidade = zeros(1,NumeroGeracoes);
Filho_regra = zeros(1,15,NumeroGeracoes);

%ENCONTRANDO AS GERACOES
for k = 1:NumeroGeracoes
disp('Inicializando AG. Criando geração: ')
disp(k);
disp(' ')
soma_custos=0;
 
    for j = 1:Interacao
            posicao_roleta = roleta(VetCustos);
            %----------crossover------------------------------
            %%Soteria pela roleta um individuo com menor custo para cada
            %%pai. Dentro de cada individuo tera os genes que sao os
            %%parametros das funcoes de pertinencia. Faz cruzamente nesses
            %%dados.

            Pai_entrada_1 = VetEntrada1(:,:,posicao_roleta(1,1));
            Mae_entrada_1 = VetEntrada1(:,:,posicao_roleta(1,2));
            Filho_entrada_1(:,:,j) = crossover(Pai_entrada_1,Mae_entrada_1);

            Pai_entrada_2 = VetEntrada2(:,:,posicao_roleta(1,1));
            Mae_entrada_2 = VetEntrada2(:,:,posicao_roleta(1,2));
            Filho_entrada_2(:,:,j) = crossover3(Pai_entrada_2,Mae_entrada_2);

            Pai_saida_1 = VetParametro1Saida(:,:,posicao_roleta(1,1));
            Mae_saida_1 = VetParametro1Saida(:,:,posicao_roleta(1,2));
            Filho_saida_1(:,:,j) = crossover4(Pai_saida_1,Mae_saida_1);
            
            Pai_regra = regras(:,:,posicao_roleta(1,1));
            Mae_regra = regras(:,:,posicao_roleta(1,2));
            Filho_regra(:,:,j) = crossover2(Pai_regra,Mae_regra);
    end
    
%CLONAGEM DOS MELHORES
Filho_entrada_1(:,:,NumeroIndividuos-1) = melhorent1_1;
Filho_entrada_2(:,:,NumeroIndividuos-1) = melhorent2_1;
Filho_saida_1(:,:,NumeroIndividuos-1) = melhorsai1_1;
Filho_regra(:,:,NumeroIndividuos-1) = melhor_regra1; 

Filho_entrada_1(:,:,NumeroIndividuos) = melhorent1_2;
Filho_entrada_2(:,:,NumeroIndividuos) = melhorent2_2;
Filho_saida_1(:,:,NumeroIndividuos) = melhorsai1_2;
Filho_regra(:,:,NumeroIndividuos) = melhor_regra2; 

VetEntrada1 = Filho_entrada_1;
VetEntrada2 = Filho_entrada_2;
VetParametro1Saida = Filho_saida_1;
regras = Filho_regra;

VetCustos = zeros(1,NumeroIndividuos);
for i = 1:NumeroIndividuos
    t=1;
    q=1;
    for j=1:5
        for p=1:3
        matriz_regras(q,:,i) = [j p regras(1,t,i) 1 1];
        t = t+1;
        q = q+1;
        end
    end
    fis = atualiza_parametros(fis,-30,30,-1,1,-4,4,VetEntrada1(:,:,i),VetEntrada2(:,:,i),VetParametro1Saida(:,:,i));
    fis.Rules = [];
    writeFIS(fis,'Sugeno_otimizado');
    fis = readfis('Sugeno_otimizado');
    rules = matriz_regras(:,:,i);
    fis2 = addRule(fis,rules);
    fis = atualiza_parametros(fis2,-30,30,-1,1,-4,4,VetEntrada1(:,:,i),VetEntrada2(:,:,i),VetParametro1Saida(:,:,i));
    sim('Simulador_Tanques');
    
    VetCustos(1,i) = custo(Erro,SinalDeControle);
    Vetadaptabilidade(1,i) = 1/VetCustos(1,i);
    soma_custos = soma_custos + Vetadaptabilidade(1,i);
    
end

disp('Custos:')
disp(VetCustos)
media_custo = mean(VetCustos);
disp('Custo Medio: ')
disp(media_custo)
adapt_media = mean(Vetadaptabilidade);
disp('Adaptabilidade media: ');
disp(adapt_media);

%-------------elitismo--------------------------------
melhores = elitismo(VetCustos);
melhorent1_1 = VetEntrada1(:,:,melhores(1,1));
melhorent2_1 = VetEntrada2(:,:,melhores(1,1));
melhorsai1_1 = VetParametro1Saida(:,:,melhores(1,1));
melhor_regra1 = regras(:,:,melhores(1,1));

melhorent1_2 = VetEntrada1(:,:,melhores(1,2));
melhorent2_2 = VetEntrada2(:,:,melhores(1,2));
melhorsai1_2 = VetParametro1Saida(:,:,melhores(1,2));
melhor_regra2 = regras(:,:,melhores(1,2));

%Melhor da geracao
VetMelhorCusto(1,k) = min(VetCustos);
VetCustoMedio(1,k) = media_custo;
VetAdaptabilidade(1,k) = max(Vetadaptabilidade);
end
%%
%PEGA O MELHOR DA ULTIMA GERACAO
 t=1;
 q=1;
    for j=1:5
        for p=1:3
        matriz_regras(q,:,1) = [j p melhor_regra1(1,t) 1 1];
        t = t+1;
        q = q+1;
        end
    end
fis = atualiza_parametros(fis,-30,30,-1,1,-4,4,VetEntrada1(:,:,melhores(1,1)),VetEntrada2(:,:,melhores(1,1)),VetParametro1Saida(:,:,melhores(1,1)));
fis.Rules = [];
writeFIS(fis,'Sugeno_otimizado');
fis = readfis('Sugeno_otimizado');
rules = matriz_regras(:,:,1);
fis2 = addRule(fis,rules);
fis = atualiza_parametros(fis2,-30,30,-1,1,-4,4,VetEntrada1(:,:,melhores(1,1)),VetEntrada2(:,:,melhores(1,1)),VetParametro1Saida(:,:,melhores(1,1)));
sim('Simulador_Tanques');
writeFIS(fis,'Sugeno_otimizado');
%%

%%%% cria os graficos
figure(1)
plot(Erro.data(:,1),'LineWidth',2);
title('Erro Tanque 2'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Erro tanque 2');
grid on;

figure(2)
plot(Var_erro.data(:,1),'LineWidth',2);
title('Derivada Erro Tanque 2'); 
xlabel('Segundos');
ylabel('Centrimetros por segundo');
legend('Derivada erro T2');
grid on;

figure(3)
plot(SinalDeControle.data(:,1),'LineWidth',2);
hold on
plot(SinalDeControle.data(:,2),'LineWidth',2);
title('Sinal de controle'); 
xlabel('Segundos');
ylabel('Volts');
legend('Saturação','Sinal de Controle');
grid on;

figure(4)
plot(Niveis(:,1),Niveis(:,3),'LineWidth',2);
title('Nivel Tanque 1'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Saída Tanque 1');
grid on;

figure(5)
plot(Niveis(:,1),Niveis(:,4),'LineWidth',2);
hold on;
plot(Niveis(:,1),Niveis(:,2));%setpoint
title('Nivel Tanque 2'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Saída Tanque 2','Referência');
grid on;

figure(6)
plot(VetCustoMedio(1,:),'LineWidth',2);
hold on
plot(VetMelhorCusto(1,:),'bo:');
title('Custos'); 
xlabel('Geração');
ylabel('Custo');
legend('Custo Médio','Melhor custo');
grid on;

figure(7)
plot(VetAdaptabilidade(1,:),'LineWidth',2);
title('Adaptabilidade'); 
xlabel('Geração');
ylabel('Adaptabilidade');
legend('Adptabilidade média');
grid on;

figure(8)
plotmf(fis,'input',1);

figure(9)
plotmf(fis,'input',2);







