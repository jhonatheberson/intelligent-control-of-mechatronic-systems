clc;  %limpa valores do console
clear all; %limpa valores do workspace
controlador = readfis('ControleMandani1_Jhonat'); %importa o controlador fuzzy
sim('Simulador_Tanques_Thiago'); %roda a simulacao

%%%% cria os graficos
figure(1)
plot(Erro(:,1),'LineWidth',2);
axis([0 500 -30 30]);
title('Erro Tanque 2'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Erro tanque 2');
grid on;

figure(2)
plot(Var_erro(:,1),'LineWidth',2);
axis([0 500 -1 1]);
title('Derivada Erro Tanque 2'); 
xlabel('Segundos');
ylabel('Centrimetros por segundo');
legend('Derivada erro T2');
grid on;

figure(3)
plot(SinalDeControle(:,1),'LineWidth',2);
axis([0 500 0 inf]);
title('Sinal de controle'); 
xlabel('Segundos');
ylabel('Volts');
legend('Sinal de Controle');
grid on;

figure(4)
plot(Niveis(:,1),Niveis(:,3),'LineWidth',2);
hold on;
plot(Niveis(:,1),Niveis(:,2));%setpoint
title('Nivel Tanque 1'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Saída Tanque 1','Referência','Location','southeast');
grid on;

figure(5)
plot(Niveis(:,1),Niveis(:,4),'LineWidth',2);
hold on;
plot(Niveis(:,1),Niveis(:,2));%setpoint
axis([0 250 0 20]);
title('Nivel Tanque 2'); 
xlabel('Segundos');
ylabel('Centimetros');
legend('Saída Tanque 2','Referência','Location','southeast');
grid on;

figure(6)
plotmf(controlador,'input',1);

figure(7)
plotmf(controlador,'input',2);

figure(8)
plotmf(controlador,'output',1);

figure(9)
gensurf(controlador)