file = strcat('E:\研究生\paper\demo\Frequency-based low-light image enhancement\data\1.png');
img = imread(file);
[R, L, res] = iter_enhance_demo(img);
imwrite(res,strcat('E:\研究生\paper\demo\Frequency-based low-light image enhancement\result\1.png'));
