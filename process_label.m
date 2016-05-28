%process the SUbjectIDs into a suitable format
addpath('/home/siddhu/FBIRN/original_res/mat_format/unmasked/maskdata')
load('/home/siddhu/FBIRN/original_res/mat_format/unmasked/maskdata/SubjectsID_final.mat')
fields = fieldnames(SubjectsID);

c1 = 0;
c2 = 0;
M = containers.Map();
for i = 1:numel(fields)
    A = SubjectsID.(fields{i});
    c1 = c1 + sum(A.labels==1);
    c2 = c2 + sum(A.labels==-1);
    for j=1:length(A.ID)
        M(A.ID{j}) = A.labels(j);
    end
end

path = '/home/siddhu/FBIRN/original_res/mat_format/masked';
addpath(path);
path_dir = strcat(path,'/*.mat');
l=dir(path_dir);
l = {l.name};

N = 380;%no of samples total
class_label = zeros(1,N);
session_id = zeros(1,N);
G=containers.Map(keys(M),zeros(size(keys(M))));
for i=1:numel(l)
    [~,name,~] = fileparts(l{i});
    n = strsplit(name,'_');
    class_label(i) = M(n{1});
    G(n{1}) = G(n{1})+1;
    session_id(i) = str2double(n{4});
end

save('/home/siddhu/FBIRN/original_res/mat_format/class_label.mat','class_label');
save('/home/siddhu/FBIRN/original_res/mat_format/session_id.mat','session_id');
    
    
        