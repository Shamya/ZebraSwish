opticFlow = opticalFlowFarneback;
im = imread('test1.jpg');%'A.JPEG');
%imageSize = size(im);
vFrame = imresize(im,0.25); % Get video frame
frameGray = rgb2gray(vFrame); % Convert to gray for detection
bboxes = findPet(frameGray,opticFlow); % Find bounding boxes
disp(bboxes);
if ~isempty(bboxes)
img = zeros([imageSize size(bboxes,1)]);
for ii = 1:size(bboxes,1)
img(:,:,:,ii) = imresize(imcrop(im,bboxes(ii,:)),imageSize(1:2));
end

[~, scores] = cnnPredict(cnnModel,img,'UseGPU',false,'display',false);
label = predict(svmmdl,scores)
im = insertObjectAnnotation(im,'Rectangle',bboxes,cellstr(label),'FontSize',40);

end
[~, scores] = cnnPredict(cnnModel,im,'UseGPU',false,'display',false);
label = predict(svmmdl,scores)

imshow(im);