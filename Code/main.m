%% ================= Code by: Giampiero Porfiri =================
%  The purpose of this script is to read a set of images and to
%  identify the blood vessels.
%  They will be masked and enhanced to later be segmentated with
%  the use of a convolutional network.
%  ==============================================================

%% Viewing the samples and the mask

FileName = 'C:\Users\giamp\Desktop\Lungs Segmentation\ExampleScans\Scans\VESSEL12_23.mhd';
Info = mhd_read_header(FileName);
Data = mhd_read_volume(Info);
Data = im2single(Data);
%sliceViewer(Data);
%volumeViewer(Data);

MaskName = 'C:\Users\giamp\Desktop\Lungs Segmentation\ExampleScans\Lungmasks\VESSEL12_23.mhd';
Info = mhd_read_header(MaskName);
Mask = mhd_read_volume(Info);
Mask = im2single(Mask);
%sliceViewer(Mask);
%volumeViewer(Mask);

%% Segmentating by using Otsu's treshold algorithm

for i = 1 : size(Data, 3)

    Image = Data(:, :, i);
    Image = im2double(Image);
    maskFilter = Mask(:, :, i);
    maskFilter = im2double(maskFilter);

    maskedImage = Image.*maskFilter; 

    enhancedImage = adapthisteq(maskedImage, 'numTiles',[12 12],'nBins', 256);
    Filter = fspecial('average', [12 12]);
    filteredImage = imfilter(enhancedImage, Filter);
    Difference = imsubtract(filteredImage, enhancedImage);
    Threshold = graythresh(Difference);
    BW = imbinarize(Difference, Threshold);
    Image = imfill(BW, 4, 'holes');

    Data(:, :, i) = Image;

end

figure, imshow(Image);
sliceViewer(Data);
%volumeViewer(Data);

