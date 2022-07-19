%    file = "E:\研究生\paper\demo\Low-Light Paper\data\data35\21.png";
%   j='9';
%    O = imread(file);
%   O = im2double(O);
function [X,t_out,R,L,res,STR,TEX] = iter_enhance_demo(O)
 O = im2double(O);
%% rgb->yuv
%% RGB -> HSV
   hsi = rgb2hsi(O);
   S = hsi(:,:,3);
%   S = O;

%% initial illumination L_in
% L_in = max(O, [], 3);
%  YUV -> Y
%     r = O(:,:,1); g = O(:,:,2); b = O(:,:,3);
%  Y = 0.299 .* Ir + 0.587 .* Ig + 0.114 .* Ib;
% S = 0.299 .* r + 0.587 .* g + 0.114 .* b;
% u = - 0.147 .* r - 0.286 .* g + 0.436 .* b;
% v = 0.615 .* r - 0.515 .* g - 0.100 .* b;
%    Y =  max(O, [], 3);
%  Y =  (r + g + b)/3; 
   Y = S; 

      
%     B = hsi(:,:,2); %% 饱和度

%% parameters setting
alpha = 0.0015;

gamma = 2.2;


t_out = iter_illumination_Solver(Y, alpha );




%%  parameters setting

 para.beta1 = 0.1;
 para.beta2 = 0.05;
 
 para.delta1 = 0.1;
 para.delta2 = 0.005;


 [Rr,R,G,C,H,STR,TEX] = iter_reflectance_Solver(S , t_out, para);

  L = t_out;
  X = R;

    hsi(:,:,3) = L;
    L = hsi2rgb(hsi);


    hsi(:,:,3) = R;
     R = hsi2rgb(hsi);

res = R.*L.^(1/gamma);




 

end

% imwrite(S,strcat('E:\研究生\paper\demo\Low-Light Paper\code\our\S.png'));
% imwrite(C,strcat('E:\研究生\paper\demo\Low-Light Paper\code\our\C.png'));
% imwrite(H,strcat('E:\研究生\paper\demo\Low-Light Paper\code\our\H.png'));
% imwrite(STR,strcat('E:\研究生\paper\demo\Low-Light Paper\code\our\STR.png'));
% imwrite(TEX,strcat('E:\研究生\paper\demo\Low-Light Paper\code\our\TEX.png'));



% function res = color(Y,S)
% % win 3x3
% temp = 1/9 * [1,1,1;1,1,1;1,1,1];
% X = Y./S;
% [m, n]=size(temp);
% mid = (m-1)/2;
% nid = (n-1)/2;
% [r,l] = size(Y);
% rp=r+2*mid;
% lp=l+2*nid;
% 
% picPad=zeros(rp,lp);
% picPad(mid+1:rp-mid,nid+1:lp-nid)=X;
% 
% for i=mid+1:rp-mid
%     for j=nid+1:lp-nid
%         res(i-mid,j-nid)=uint8(sum(sum(picPad(i-mid:i+mid,j-nid:j+nid).*temp)));
%     end
% end
% 
% end