clear all
fid = fopen('Tracks_16.txt','rt');      %file with needed track names
com = fopen('comfile16.txt','wt');      %file with directories of the needed files on the disk

while ~feof(fid)
    FileName = fgets(fid);
    UsefulData=FileName(24:54);
    YearMonth=strcat(UsefulData(1:4),'_',UsefulData(5:6));
    YearMonthDay=strcat(UsefulData(1:4),'_',UsefulData(5:6),'_',UsefulData(7:8));
    path='G:/Maria_Panfilova_hdf5_nasa/';
    s2=strcat(path,YearMonth,'/', YearMonthDay,strcat('/*Ku*',UsefulData,'*.hdf5'));
    s22=strcat(path,YearMonth,'/', YearMonthDay);
    %checking if theres a file with needed name in datafiles
    MatchingFileNames = ls(s2);
    Amount=size(MatchingFileNames);
    %if yes, write down path to this file in comfile
        if Amount~=0
            fprintf(com,'%s\n', strcat(s22,'/',MatchingFileNames));
        end
    %skip 2 lines lol    
   % FileName = fgets(fid); 
   % FileName = fgets(fid);
end

fclose(fid);
fclose(com);

