function [comp] = pca_red(feat,dim_num)

p = size(feat,2);

cov = feat*feat'./(p-1);

[eig_vec, eig_val] = eigs(cov,dim_num);

comp = feat'*eig_vec;

