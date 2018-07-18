clear all
fid=fopen('allTracks16.txt','rt');
fileName=fgets(fid);
fileName=fgets(fid);
fileName=fgets(fid);
fileName=fgets(fid);
com=fopen('allTracks_16.txt','wt');
while ~feof(fid)
    fileName=fgets(fid);
    fprintf(com,'%s',fileName(107:end));
end
fclose(fid);
fclose(com);
