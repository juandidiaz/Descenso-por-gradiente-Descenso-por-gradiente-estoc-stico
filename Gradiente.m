

%Importar primero el documento regresion_con_grafico.xlsx
%dando click izquierdo encima, Import data e Import Selection

%%DESCENSO POR GRADIENTE

%Extraccion de datos
X=ones(size(regresioncongrafico)); %1
X2=regresioncongrafico(:,1); %2
X2=table2cell(X2); %3
X2=cell2mat(X2); %4
X(:,2)=X2; %5

Y=regresioncongrafico(:,2); %6
Y=table2cell(Y); %7
Y=cell2mat(Y); %8 

[nf nc]=size(X); %9

%Asignacion de parámetros
theta=rand(nc,1); %10
thetaanterior=theta; %11
alfa=0.05; %12
alfa=alfa/nf; %13
Error=zeros(1000,1); %14

%ALGORITMO
for i=1:1000 %15

   for j=1:nf %16
       for k=1:nc  %17
            theta(k,1)=thetaanterior(k,1)-alfa*((thetaanterior(1,1)*X(j,1)+thetaanterior(2,1)*X(j,2)-Y(j,1))*X(j,k)); %18
       end
       for l=1:k %19
            thetaanterior(l,1)=theta(l,1); %20
       end
   end
      valor=0; %21
       for r=1:nf %22
            valor=valor+((theta(1,1)+theta(2,1)*X(r,2))-Y(r))^2; %23
       end
            Error(i)=(1/2)*valor; %24
end

%Representacion grafica
syms x;
y=theta(1,1)+theta(2,1)*x;

figure,plot(X(:,2),Y,'.r');

x=min(X(:,2));

r1=eval(y);

x=max(X(:,2));

r2=eval(y);

hold on,plot([min(X(:,2)) max(X(:,2))],[r1 r2],'b');

%%DESCENSO DEL GRADIENTE ESTOCÁSTICO
%Asignacion de parametros
theta2=rand(nc,1);
thetaanterior2=theta2;
parametro=15;

%Datos auxiliares para usar subconjuntos
Xaux=zeros(parametro,nc);
Yaux=zeros(parametro,1);
[nf nc]=size(Xaux);

alfa2=0.05;
alfa2=alfa2/parametro;

Error2=zeros(1000,1);

%ALGORITMO
for i=1:1000 %1

    fila=round(1+(nf-1).*rand(parametro,1)); %2

    for r=1:parametro %3
        Xaux(r,:)=X(fila(r),:); %4
        Yaux(r)=Y(fila(r)); %5
    end

    for m=1:nf %6
        ejemploX=Xaux(m,:);
        ejemploY=Yaux(m);

        for k=1:nc %7
            theta2(k,1)=thetaanterior2(k,1)-alfa2*((thetaanterior2(1,1)*ejemploX(1,1)+thetaanterior2(2,1)*ejemploX(1,2)-ejemploY(1,1))*ejemploX(1,k)); %8
        end
        
         for l=1:k %9
            thetaanterior2(l,1)=theta2(l,1); %10
         end

         valor=0; %11
       for r=1:97 %12
            valor=valor+((theta2(1,1)+theta2(2,1)*X(r,2))-Y(r))^2; %13
       end
            Error2(i)=(1/2)*valor; %14

    end  
end

%Representacion gráfica
syms x3;
y=theta2(1,1)+theta2(2,1)*x3;

x3=min(X(:,2));

r1=eval(y);

x3=max(X(:,2));

r2=eval(y);

hold on,plot([min(X(:,2)) max(X(:,2))],[r1 r2],'r');

%ECUACIONES NORMALES
syms x2;

Tita=inv(X'*X)*X'*Y;

y=Tita(1,1)+Tita(2,1)*x2;

x2=min(X(:,2));

r1=eval(y);

x2=max(X(:,2));

r2=eval(y);

hold on,plot([min(X(:,2)) max(X(:,2))],[r1 r2],'g');

legend('Datos', 'Descenso por gradiente','Descenso por gradiente Estocástico','Ecuaciones normales');
xlabel('X');
ylabel('Y');
grid on;

r=1:1000';
figure,plot(r,Error,'r'),
grid on,legend('Error descenso por gradiente');
xlabel('Iteraciones'),
ylabel('Error')

figure,plot(r,Error2,'b'),
grid on, legend('Error descenso por gradiente estocástico'),
xlabel('Iteraciones');
ylabel('Error')
