%%%%% SDA between each database
%%% CO2=e*X-1*L*F 
%%%_1 is the version 1 MRIO
clc
clear all

load('SDA_12.mat');
load('SDA_17.mat');

%%% e
d_E=E_17-E_12; 

D_Multiplier_1=diag(d_E)*L_17;
D_Multiplier_2=diag(d_E)*L_12;

for i=1:313
    D_E1(:,i)=D_Multiplier_1*F2_17(:,i);
    D_E2(:,i)=D_Multiplier_2*F2_12(:,i);
end

E_D=(D_E1+D_E2)/2;

for i=1:313
    E_D_1(i,:)=sum(E_D((i-1)*42+1:(i-1)*42+42,:),1);
end

E_SDA=sum(E_D_1,1);

%%%% L

d_L=L_17-L_12; 
D_Multiplier1=diag(E_12)*d_L;
D_Multiplier2=diag(E_17)*d_L;


for i=1:313
      L_E1(:,i)=D_Multiplier1*F2_17(:,i);
      L_E2(:,i)=D_Multiplier2*F2_12(:,i);
end

L_D=(L_E1+L_E2)/2;

for i=1:313
    L_D_1(i,:)=sum(L_D((i-1)*42+1:(i-1)*42+42,:),1);
end

L_SDA=sum(L_D_1,1);

%%%% F

d_F=F2_17-F2_12;
D_Multiplier11=diag(E_12)*L_12;
D_Multiplier22=diag(E_17)*L_17;

for i=1:313
      F_E1(:,i)=D_Multiplier11*d_F(:,i);
      F_E2(:,i)=D_Multiplier22*d_F(:,i);
end

F_D=(F_E1+F_E2)/2;

for i=1:313
    F_D_1(i,:)=sum(F_D((i-1)*42+1:(i-1)*42+42,:),1);
end

F_SDA=sum(F_D_1,1);

SDA_TOTAL=[E_SDA;L_SDA;F_SDA];
