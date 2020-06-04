function [w, bias] = hiperplano3(Dtrain,clase)
% se buscara una recta tangente a la recta que une los puntos medios
% de ambos grupos de datos, y que pase por el punto medio de dichos puntos

%variables
bias_step = 1                 
largo = length(Dtrain)/2
x1_prom = 0 
y1_prom = 0 
x2_prom = 0 
y2_prom = 0

%se busca el punto medio de cada grupo de datos => (x1,y1) y (x2,y2)
for j=1:largo
    x1_prom = x1_prom + Dtrain(j)
end
x1_prom = x1_prom/largo
for j=1:largo
    x2_prom = x2_prom + Dtrain(j+largo)
end
x2_prom = x2_prom/largo
for j=1:largo
    y1_prom = y1_prom + Dtrain(j+2*largo)
end
y1_prom = y1_prom/largo
for j=1:largo
    y2_prom = y2_prom + Dtrain(j+3*largo)
end
y2_prom = y2_prom/largo

% pendiente entre (x1,y1) y (x2,y2)
pendiente = (y2_prom - y1_prom)/(x2_prom - x1_prom)

% pendiente tangente
m = -1/pendiente  

% punto medio
x_medio = (x1_prom + x2_prom)/2
y_medio = (y1_prom + y2_prom)/2

% matriz w. El valor w(2) se fija en 1 para que w(1) y bias representen 
% la pendiente y el coeficiente de posición respectivamente.
w_aux = [-m 1]

% ahora se busca el mejor valor para bias
bias_aux = -(-m*x_medio + y_medio)
score_bias = 0

% se recorren los valores cercanos a bias_aux buscando la mejor tasa de
% acierto
for j_bias = (bias_aux-5):bias_step:(bias_aux+5)
    score = 0
    for i = 1:length(Dtrain)    
        D = Dtrain(i+2*largo) + (w_aux*Dtrain(i)+j_bias)/w_aux(2)
        if sign(D) == sign(clase(i))
            score = score + 1
        end
    end
   
    if score > score_bias
        score_bias = score
        bias_final = j_bias
    end

    % mismo procedimiento, pero considerando las clases con signo opuesto.
    score = 0
    for i = 1:length(Dtrain)    
        D = Dtrain(i+2*largo) + (w_aux*Dtrain(i)+j_bias)/w_aux(2)
        if sign(D) ~= sign(clase(i))
            score = score + 1
        end
    end
   
    if score > score_bias
        score_bias = score
        bias_final = j_bias
    end
end
w = [-m 1]
bias = bias_final


