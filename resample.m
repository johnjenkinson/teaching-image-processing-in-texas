% call: resample.m
% Methods of resampling.  Two methods of downsampling and two methods
% of upsampling from the notes of Dr. Artyom Grigoryan are presented.
%
% John Jenkinson, UTSA ECE, January 26, 2015.
% Last Edited: 01/26/2015.

s_dir=pwd;
cd ../images
A=imread('tree_color.tiff');
A=rgb2gray(A);
cd(s_dir)

[N M]=size(A);
% Method 1 Downsampling. Keeping every other column and row.
N2=N/2; M2=M/2;
AD1=zeros(N/2,M/2);
AD1=A(1:2:N,1:2:M);
AD1p=ones(N,M);
AD1p(1:N/2,1:M/2)=AD1; % plot actual size
AAD1p=A;
AAD1p(1:N/2,1:M/2)=AD1; % plot small in original

figure; % plot results
colormap(gray(255))
subplot(221)
image(A); axis image; title('original image');
subplot(222)
image(AD1); axis image; title('downsampled method 1');
subplot(223)
image(AAD1p); axis image; title('small in original');
subplot(224)
image(AD1p); axis image; title('small actual size');

% Method 2 Downsampling. Averaging a neighborhood of 4 pixels.
ADe=zeros(N,M);
ADe(:,M)=A(:,M);
ADe(N,:)=A(N,:);
for i=1:N-1
    for j=1:M-1
        ADe(i,j)=( A(i,j)+A(i+1,j)+A(i,j+1)+A(i+1,j+1) )/4;
    end
end
AD2=zeros(N2,M2);
AD2=ADe(1:2:N,1:2:M);
AD2p=ones(N,M);
AD2p(1:N/2,1:M/2)=AD2; % plot actual size
AAD2p=A;
AAD2p(1:N/2,1:M/2)=AD2; % plot small in original

figure; % plot results
colormap(gray(255))
subplot(221)
image(A); axis image; title('original image');
subplot(222)
image(AD2); axis image; title('downsampled method 2');
subplot(223)
image(AAD2p); axis image; title('small in original');
subplot(224)
image(AD2p); axis image; title('small actual size');

% Method 1 Upsampling. Filling adjacent column and row by present value.
AU1=zeros(N,M);
AD1=double(AD1);
AU1x1=AU1; AU1x2=AU1;
AU1x1(1:2:N,1:2:M)=AD1(1:N2,1:M2);
AU1x2(1:2:N,2:2:M)=AU1x1(1:2:N,1:2:M);
AU1xx=AU1x1+AU1x2;
AU1(2:2:N,:)=AU1xx(1:2:N,:);
AU1=AU1+AU1xx;

% Method 2 Upsampling. Simple interpolation by 8-neighbor averaging.
AU2s=zeros(N,M);
AU2s(1:2:N,1:2:M)=AD1(1:N2,1:M2); % s for sparse
AU2s=double(AU2s);
AU2c=zeros(N,M);
AU2c=double(AU2c);
AU2r=zeros(N,M);
AU2r=double(AU2r);
% interpolate every other column
for i=2:2:N-1
    for j=1:2:M-1
        AU2c(i,j)=( AU2s(i-1,j)+AU2s(i+1,j) )/2;
    end
end
AU2c=AU2c+AU2s;
% interpolate every other row
for i=1:2:N-1
    for j=2:2:M-1
        AU2r(i,j)=( AU2c(i,j-1)+AU2c(i,j+1) )/2;
    end
end
AU2r=AU2r+AU2c;
% interpolate neighborhood center
AU2x=zeros(N,M);
AU2x=double(AU2x);
for i=2:2:N-1
    for j=2:2:M-1
        AU2x(i,j)=( AU2r(i-1,j)+AU2r(i+1,j)+AU2r(i,j-1)+AU2r(i,j+1) )/4;
    end
end
AU2=zeros(N,M);
AU2=AU2x+AU2r;
AU2=uint8(AU2);
AU1=uint8(AU1);

% plot upsampled images
figure;
colormap(gray(255))
subplot(131)
image(A); axis image; title('original image');
subplot(132)
image(AU1); axis image; title('upsampled method 1');
subplot(133)
image(AU2); axis image; title('upsampled method 2');

        













    
