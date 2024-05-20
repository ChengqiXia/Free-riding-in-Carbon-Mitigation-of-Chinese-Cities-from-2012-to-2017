clear all

%%%2012
load('2012_Chinese_City_MRIO.mat');
CO2_2012=xlsread('data_input','CO2_2012');
CO2_12=reshape(CO2_2012',[313*42,1]);
F_12=MRIO.F;
Z_12=MRIO.Z;
VA_12=MRIO.VA;
IM_12=MRIO.Import;
EX_12=MRIO.Export;
X_12=sum(F_12,2)+sum(Z_12,2)+EX_12;

E_12=CO2_12./X_12;
A_12=Z_12./X_12';

E_12(isnan(E_12))=0;
E_12(isinf(E_12))=0;
A_12(isnan(A_12))=0;
A_12(isinf(A_12))=0;

I=eye(size(A_12));
L_12=(I-A_12)^-1;
Multiplier_12=diag(E_12)*L_12;

F2_12=zeros(313*42,313);
for i=1:313
    F2_12(:,i)=sum(F_12(:,(i-1)*5+1:(i-1)*5+5),2);
end

%city
for i=1:313
     Carbonfootprint_12(:,i)=Multiplier_12*F2_12(:,i);
end

for i=1:313
     Footprint_City_12(i,:)=sum(Carbonfootprint_12((i-1)*42+1:(i-1)*42+42,:),1);
end

%sector
Multiplier2_12=E_12'*L_12;
for i=1:313
    CF_12=Multiplier2_12*diag(F2_12(:,i));
    for j = 1:42
    Footprint_sector_12(i,j)=sum(CF_12(j:42:j+312*42),2);
    end
end

%%%2017
load('China city MRIO_2017.mat');
CO2_2017=xlsread('data_input','CO2_2017');
CO2_17=reshape(CO2_2017',[42*313,1]);

F_17=MRIO.F;
Z_17=MRIO.Z;
VA_17=MRIO.VA;
IM_17=MRIO.IM;
EX_17=MRIO.Export;

X_17=sum(F_17,2)+sum(Z_17,2)+EX_17;

PI_17=xlsread('data_input','2017to2012');

Z_17=Z_17./PI_17;
F_17=F_17./PI_17;
X_17=X_17./PI_17;

E_17=CO2_17./X_17;
A_17=Z_17./X_17';

E_17(isnan(E_17))=0;
E_17(isinf(E_17))=0;
A_17(isnan(A_17))=0;
A_17(isinf(A_17))=0;

I=eye(size(A_17));
L_17=(I-A_17)^-1;
Multiplier_17=diag(E_17)*L_17;

F2_17=zeros(313*42,313);
for i=1:313
    F2_17(:,i)=sum(F_17(:,(i-1)*5+1:(i-1)*5+5),2);
end

%%city
for i=1:313
     Carbonfootprint_17(:,i)=Multiplier_17*F2_17(:,i);
end

for i=1:313
     Footprint_City_17(i,:)=sum(Carbonfootprint_17((i-1)*42+1:(i-1)*42+42,:),1);
end

%sector
Multiplier2_17=E_17'*L_17;
for i=1:313
    CF_17=Multiplier2_17*diag(F2_17(:,i));
    for j = 1:42
    Footprint_sector_17(i,j)=sum(CF_17(j:42:j+312*42),2);
    end
end

new_Z17=zeros(313,313);
for i=1:313
    for j=1:313
        new_Z17(i,j)=sum(sum(Z_17(42*(i-1)+1:42*i,42*(j-1)+1:42*j)));
    end
end

for i=1:313
    new_X17(i)=sum(X_17((i-1)*42+1:i*42));
end
