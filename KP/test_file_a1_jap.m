clear all
fid=fopen('2017(2016).txt','r');
com = fopen('comfile17.txt','w');


while ~feof(com)
    ss = fgets(fid);
    ss1=ss(33:63);
    my=strcat(ss1(1:6));
    s1=strcat(ss1(1:8));
    path='O:/DPR/';
    s2=strcat(path,my,'/GPMCOR_DPR_', ss1(3:8),'*',strcat(ss(58:63),'*.H5'));
    s22=strcat(path,my);
    list = ls(s2);
    sz=size(list);
    if sz~=0
        fprintf(com,'%s\r\n', strcat(s22,'/',list));
    end
    ss = fgets(fid);
    ss = fgets(fid);
end

fclose(fid);
fclose(com);

