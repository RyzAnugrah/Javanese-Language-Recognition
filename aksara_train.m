clc; clear;

b1=('img/ba.png');
b2=('img/ca.png');
b3=('img/da.png');
b4=('img/dha.png');
b5=('img/ga.png');
d1=('img/ha.png');
d2=('img/ja.png');
d3=('img/ka.png');
d4=('img/la.png');
d5=('img/ma.png');
j1=('img/na.png');
j2=('img/nga.png');
j3=('img/nya.png');
j4=('img/pa.png');
j5=('img/ra.png');
m1=('img/sa.png');
m2=('img/ta.png');
m3=('img/tha.png');
m4=('img/wa.png');
m5=('img/ya.png');

ib1=im2double(imread(b1));
ib2=im2double(imread(b2)); 
ib3=im2double(imread(b3)); 
ib4=im2double(imread(b4)); 
ib5=im2double(imread(b5)); 
id1=im2double(imread(d1)); 
id2=im2double(imread(d2)); 
id3=im2double(imread(d3));
id4=im2double(imread(d4));
id5=im2double(imread(d5));
ij1=im2double(imread(j1)); 
ij2=im2double(imread(j2));
ij3=im2double(imread(j3));
ij4=im2double(imread(j4));
ij5=im2double(imread(j5));
im1=im2double(imread(m1));
im2=im2double(imread(m2));
im3=im2double(imread(m3));
im4=im2double(imread(m4));
im5=im2double(imread(m5));

r1=reshape(ib1,1,4225);
r2=reshape(ib2,1,4225);
r3=reshape(ib3,1,4225);
r4=reshape(ib4,1,4225);
r5=reshape(ib5,1,4225);
r6=reshape(id1,1,4225);
r7=reshape(id2,1,4225);
r8=reshape(id3,1,4225);
r9=reshape(id4,1,4225);
r10=reshape(id5,1,4225);
r11=reshape(ij1,1,4225); 
r12=reshape(ij2,1,4225);
r13=reshape(ij3,1,4225);
r14=reshape(ij4,1,4225);
r15=reshape(ij5,1,4225);
r16=reshape(im1,1,4225);
r17=reshape(im2,1,4225);
r18=reshape(im3,1,4225);
r19=reshape(im4,1,4225);
r20=reshape(im5,1,4225);

k1=r1'; 
k2=r2'; 
k3=r3';
k4=r4'; 
k5=r5';
k6=r6';
k7=r7';
k8=r8';
k9=r9';
k10=r10';
k11=r11';
k12=r12';
k13=r13';
k14=r14';
k15=r15';
k16=r16';
k17=r17';
k18=r18';
k19=r19';
k20=r20';

citra_training=[k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20];
target=eye(20);

[R,Q]=size(citra_training);
[S2,Q]=size(target);

S1=25;
global net;
net = newff (minmax(citra_training),[S1 S2], {'logsig', 'logsig'}, 'traingdx');
net.LW{2,1} = net.LW{2,1}*0.01;
net.b{2}=net.b{2}*0.01;

net.performFcn='sse';
%net.performFcn='mse';
net.trainParam.goal=1e-8;
net.trainParam.show=20;
net.trainParam.epochs=5000;
%net.trainParam.mc=0.95;

P=citra_training;
T=target;

[net,tr]=train(net,P,T);