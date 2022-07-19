function [R,L,res] = iter_enhance_demo(O)
 O = im2double(O);
%% rgb->yuv
%% RGB -> HSV
   hsi = rgb2hsi(O);
   S = hsi(:,:,3);
%   S = O;

%% initial illumination L_in
      Y = S;


%% parameters setting
alpha = 0.0015;

 gamma = 3.2;


%% illummination solver
t_out = iter_illumination_Solver(Y, alpha );


 para.beta1 = 0.1;
 para.beta2 = 0.05;
 
 para.delta1 = 0.1;
 para.delta2 = 0.005;

 R = iter_reflectance_Solver(S , t_out, para);

  L = t_out;
  X = R;

%% hsv -> RGB
% illumination ->hsv->rgb
    hsi(:,:,3) = L;
    L = hsi2rgb(hsi);

% reflectance ->hsv ->rgb
    hsi(:,:,3) = R;
     R = hsi2rgb(hsi);

res = R.*L.^(1/gamma);

end
