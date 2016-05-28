% SCRIPT FILE : mask_data   
% masks out the required voxels to reduce size of fMRI images and stores them in  a folder
%----------------------------------------------------------------------------------------

%fetch all fMRI files in directory 
path = '/home/siddhu/FBIRN/original_res/mat_format/unmasked';
addpath(path);
path_dir = strcat(path,'/*.mat');
l=dir(path_dir);
l = {l.name}; %l contains names of all '.mat' files 

%loading mask
load('maskdata/Mask_nz_AO_denoised_MNImasked_NN.mat');%load mask named Mask_Universal
mask = int16(Mask_universal) ; % Universal mask - intersection of all sites - now excludes site 4
mask = reshape(mask,1,[]);
inds = find(mask);

D = {};
for i = 1:numel(l)
    data = load(l{i});
    data = permute(data.img,[4 1 2 3]);
    data = reshape(data,size(data,1),[])';
    tmp.data = data(inds,:);
    tmp.name = l{i};
    D{i} = tmp;
    save(sprintf('/home/siddhu/FBIRN/original_res/mat_format/masked/%s',l{i}),'tmp');
    disp(i);
end


    

% F={};
% for i = 1:1
%     count1 = 1;
%     count2 = 1;
%     data = load(l{i});
%     data = data.img;
%     E=[];
%     for x = 1:size(data,1)
%         for y = 1:size(data,2)
%             for z = 1:size(data,3)
%                 if(inds(count2)==count1)
%                     E(count2,:) = data(x,y,z,:);
%                     count2 = count2+1;
%                     fprintf('%S','HI');
%                 end
%                 count1 = count1 +1;
%             end
%         end
%     end
%     F{1} = E;
% end
%     