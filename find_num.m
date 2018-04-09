function [ num ] = find_num( r,c )
%FIND_NUM Summary of this function goes here
%   Detailed explanation goes here
num_array = [1,2,3,10;4,5,6,11;7,8,9,12;13,0,14,15;];
num = num_array(r,c);

end

