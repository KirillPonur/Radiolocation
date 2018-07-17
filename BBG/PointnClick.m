clear all
%left click to select point
%Right click stops point selection! restart the program to start over
file='NS1\d01m02g2016S193736_swath';
A = load(strcat(file,'\SigKu.txt'));
th=load(strcat(file,'\IncKu.txt'));
figure('Color','w','Name','Swath inspect')
subplot(3,1,1)
imagesc(A)
title('Track Swath')
mouse=1;
size=size(th);
 while mouse<3 %while RButton (mouse=3) is not pressed
    [x,y,mouse]=ginput(1);
    subplot(3,1,2)
    th0=th(:,floor(x));
    
    for i=1:floor(size(1)/2)
        th0(i)=-th(i);
    end
        plot(th0,A(:,floor(x)));
    
    title('Vertical-Cut')
    ylabel('RCS-Db')
    subplot(3,1,3)
    plot(A(floor(y),:))
    title('Horizontal-Cut')
    ylabel('RCS-Db')
 end