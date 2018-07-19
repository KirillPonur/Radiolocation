clear all
%Программа строит изображения от трёх источников на одном объекте figure.
%Посмотрим, насколько удобно так из сравнивать.
 month='03';
 year='17';
 
 range{1}='HS';
 range{2}='MS';
 range{3}='NS';
 i=0;
 
 
 
 
 
 for i=3:31
    for k=1:3
         dirn1=strcat('M:\Radiolocation\',range{k},'\m',month,'y',year,'\');
         dirn2 = strcat('M:\Radiolocation\figures\',range{k},'\m',month,'y',year,'\'); 

         list=ls(dirn1);
         szl=size(list);
         
        set(0,'defaultTextInterpreter','latex');
        % set(0,'TickLabelInterpreter','latex')
        set(0,'DefaultAxesFontSize',12);
        set(0,'DefaultTextFontSize',12);


        A=load(strcat(dirn1,list(i,:),'\sigKu.txt'));
        th=load(strcat(dirn1,list(i,:),'\IncKu.txt'));


        subplot(3,1,k)
        h=imagesc(A);
        title(range(k))




        % figure
        % plot(A(25,:));
    end
    dirn3='M:\Radiolocation\figures\compare';
    mkdir(dirn3);
    print(strcat('M:\Radiolocation\figures\compare\',list(i,:),'.png'),'-dpng');
    close
end