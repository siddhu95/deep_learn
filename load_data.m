% FUCNTION : load_data  : loads dataset and brings it to the req matrix
% form time on one axis and space on other groups all subjects together
% does temporal concatenation look up the images in this paper to
% understand concatenation
% http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2651152/pdf/nihms-95747.pdf'
%   path : give path to folder with processed masked data
%   y : dataset matrix
function y = load_data(path)
    path_dir = strcat(path,'/*.mat');
    l=dir(path_dir);
    l = {l.name}; %l contains names of all '.mat' files 
    
    N = 380;%no of samples
    T = 137;%time points;
    V = 26949;%voxels after masking
    y = zeros(N*T,V);
    for i = 1:numel(l)
       t = load(strcat(path,'/',l{i}));
       disp(i);
       y((i-1)*T+1:i*T,:) = t.data';
    end
end