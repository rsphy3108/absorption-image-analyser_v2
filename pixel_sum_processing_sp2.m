% analyse_and_fit_sp2.m
% Analyses image data and calls other relevant routines for species 1.

load configdata.mat
load maindata.mat

smoth_sigma = [1,3]; %Standard deviation (in pixels) of the gaussian filter used to find the center of the cloud.


%% Analysis

at_zwidth = zclext_sp2;
at_xwidth = xclext_sp2;

if(manual_center_sp2==0)
    %Gaussian filtering
    A_temp = imgaussfilt(A, smoth_sigma);
    maximum = max(max(A_temp));
    [z, x] = find(A_temp==maximum);
else
    if(roi_used == 1)
        z = round(px_sum_ctr_z_sp2 - ycamerapixel_sp2);
        x = round(px_sum_ctr_x_sp2 - xcamerapixel_sp2);
    else
        z = round(px_sum_ctr_z_sp2);
        x = round(px_sum_ctr_x_sp2);
    end
end   

%Define the atom region
if(z-at_zwidth/2 < 1)
    zmin = 1;
else
    zmin = z-round(at_zwidth/2);
end

if(z+at_zwidth/2 > size(A,1))
    zmax = size(A,1);
else
    zmax = z+round(at_zwidth/2);
end

if(x-at_xwidth/2 < 1)
    xmin = 1;
else
    xmin =x-round(at_xwidth/2);
end

if(x+at_xwidth/2 > size(A,2))
    xmax = size(A,2);
else
    xmax = x+round(at_xwidth/2);
end

A_temp = A;
A_temp(zmin:zmax,xmin:xmax) = 0;
A_bg = A_temp;
A_at = A(zmin:zmax,xmin:xmax);
bg_mean = sum(sum(A_bg))/(numel(A_bg)-numel(A_at));
at_sum = sum(sum(A_at - bg_mean));

%disp([z, x])

clear x z %temporary variables, not needed any more;

%Find atom number
find_at_no_sum_sp2;




