allFiles = dir(['Labels/001/*.txt']);
fileNames = {allFiles(~[allFiles.isdir]).name};

for file = fileNames
    file = char(file);
    file = file(1:7);
    
    bb_file = strcat(file, '.txt');
    im_file = strcat(file, '.JPEG');
    bb_file = strcat('Labels/001/', bb_file);
    im_file = strcat('Images/001/', im_file);
    
    %disp(bb_file);
   
    [xmin,ymin,xmax, ymax] = textread(bb_file,'%d%d%d%d','headerlines',1);
    width = xmax - xmin;
    height = ymax - ymin;
    img = imread(im_file);
    icrop = imcrop(img,[xmin,ymin,width,height]);
    crop_file = strcat('Crop/', file, '.JPEG');
    imwrite(icrop, crop_file);
end