clear all
 month='01';
 year='17';
 
 range{1}='HS';
 range{2}='MS';
 range{3}='NS';
 for k=1:3
 dirn1=strcat('M:\Radiolocation\',range{k},'\m',month,'y',year,'\');
%  dirn1='M:\Sakhalin\cut_dpr\HS\';
 dirn2 = strcat('M:\Radiolocation\figures\',range{k},'\m',month,'y',year,'\'); 
 
 list=ls(dirn1);
 szl=size(list);
 i=0;
 
set(0,'defaultTextInterpreter','latex');
% set(0,'TickLabelInterpreter','latex')
set(0,'DefaultAxesFontSize',12);
set(0,'DefaultTextFontSize',12);

for i=3:szl(1)
A=load(strcat(dirn1,list(i,:),'\sigKu.txt'));
th=load(strcat(dirn1,list(i,:),'\IncKu.txt'));
sth=size(th);
b=zeros(sth(1),1);

figure

%Нужно сделать нормальную разметку для удобности
%По оси X киллометры?

    
for k=1:sth(1)
    if k<=fix(sth(1)/2)
        b(k,1)=-th(k,1);
    else
        b(k,1)=th(k,1);
    end
end

    x=[0 100];
    y=[min(b),max(b)];
h=imagesc(x,y,A);
ylabel('$\theta$, degrees');
% xlabel('');

      
mkdir(dirn2);
print(strcat(dirn2,'\b1',list(i,:),'.png'),'-dpng'); 
close

% figure
% plot(A(25,:));
end
 end