clear all;
close all;
clc

%Presenta plano
plot([0,100],[0,100], 'k.')
hold on
radio=15;
npuntos=20;

%Obtener puntos clase 1
[x,y] = ginput(1);
puntosx1=(x-radio) + (2*radio).*rand(npuntos,1);
puntosy1=(y-radio) + (2*radio).*rand(npuntos,1);
plot(puntosx1,puntosy1,'r+')
 
%Obtener puntos clase 2
[x,y] = ginput(1);
puntosx2=(x-radio) + (2*radio).*rand(npuntos,1);
puntosy2=(y-radio) + (2*radio).*rand(npuntos,1);
plot(puntosx2,puntosy2,'bo')


%Datos de entrenamiento
Dtrain=[[puntosx1,puntosy1];[puntosx2,puntosy2]];
clase=[ones(npuntos,1);-1*ones(npuntos,1)];

pause

%Obtener hiperplano 
%#####TAREA######
% w=[-1 1]
% bias=0
[w,bias]=hiperplano_paulo(Dtrain,clase);
%#####TAREA######

%Dibuja Hiperplano
x=[0:100];
y=-(w(1)*x+bias)/w(2); 
plot(x,y,'k-');

%Puntos de prueba
i=0;
while i<5
   i=i+1;
  [x,y]=ginput(1);
  
  %Decidir Clase del punto de prueba
  D=y+(w(1)*x+bias)/w(2);
  if (sign(D)>0) 
      plot(x,y,'rs');
  else
      plot(x,y,'bs');
  end
end
%revisar rubrica para comprobar que su programa funciona segun lo
%requerido.
