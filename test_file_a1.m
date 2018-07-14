clear all
fid=fopen('track_2015okhot.txt','r');
com = fopen('comfile15.txt','w');


while ~feof(com)
    ss = fgets(fid);
    ss1=ss(32:62);
    my=strcat(ss1(1:4),'_',ss1(5:6));
    s1=strcat(ss1(1:4),'_',ss1(5:6),'_',ss1(7:8));
    path='I:/Maria_Panfilova_hdf5_nasa/';
    s2=strcat(path,my,'/', s1,strcat('/*Ku*',ss1,'*.hdf5'));
    s22=strcat(path,my,'/', s1);
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

