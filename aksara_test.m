clc;
I = rgb2gray(imread('captured.png'));
threshold = graythresh(I);
B =~imbinarize(I,0.35);
C = bwareaopen(B,200);

Iedge = edge(uint8(C));
se = strel('square',3);
Iedge2 = imdilate(Iedge, se); 
Ifill = imfill(Iedge2,'holes');
imwrite(~Ifill, 'result_captured.png');

RGB = imread('result_captured.png');
%RGB = imread('captured.png');

%J = imresize(RGB(:), [65 65]);
J = imresize(RGB, [65 65]);
imshow(J);

a=im2double(J);
b=reshape(a,1,[]);
c=b';
contoh=c;

global net; 
A=sim(net, contoh);
nama={'ba','ca','da','dha','ga','ha','ja','ka','la','ma','na','nga','nya','pa','ra','sa','ta','tha','wa','ya'}; 
mak=0;

for i=1:20
    if(mak<A(i)*10)
        mak=i;
    end
end

nama(mak)
