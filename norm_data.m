% SCRIPT FILE : norm_data   
% norms the time series of each voxel and saves them in a folder
%-----------------------------------------------------------------

%fetch all fMRI files (preferably masked) in directory 
path = '/home/siddhu/FBIRN/original_res/mat_format/masked';
addpath(path);
path_dir = strcat(path,'/*.mat');
l=dir(path_dir);
l = {l.name}; %l contains names of all '.mat' files 

N = 380;%no of samples
T = 137;%time points;
V = 26949;%voxels after masking

D = cell(1,N);
data_sum = zeros(V,1);
disp('loop 1');
for i = 1:numel(l)
    u = load(l{i});
    D{i} = u.tmp;
    d = D{i}.data;
    data_sum = data_sum + sum(d,2);
    disp(i);
end
data_mean = data_sum/(N*T);
data_mean = repmat(data_mean,1,T);

data_sumsqr = zeros(V,1);
disp('loop 2');
for i = 1:length(D)  
    D{i}.data = D{i}.data - data_mean;
    t = D{i}.data;
    data_sumsqr = data_sumsqr + sum(t.^2,2);
    disp(i);
end
data_var = data_sumsqr/(N*T);
data_sd = repmat(sqrt(data_var),1,T);

disp('loop 3');
for i = 1:length(D)
    t = D{i}.data;
    t = t./data_sd;
    D{i}.data = t;
    
    [~,name,ext] = fileparts(D{i}.name);
    newname = strcat(name,'_norm',ext);

    save(sprintf('/home/siddhu/FBIRN/original_res/mat_format/norm_masked_data/%s',newname),'t');
    disp(i);
end




    