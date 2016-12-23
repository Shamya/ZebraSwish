%% Tying the workflow together
vr = VideoReader(fullfile('D_10.mp4'));
vw = VideoWriter('test.avi','Motion JPEG AVI');
opticFlow = opticalFlowFarneback;
open(vw);
frameNumber = 0
while hasFrame(vr)
% Count frames
frameNumber = frameNumber + 1;

% Step 1. Read Frame
videoFrame = readFrame(vr);

% Step 2. Detect ROI
vFrame = imresize(videoFrame,0.25); % Get video frame
frameGray = rgb2gray(vFrame); % Convert to gray for detection
bboxes = findPet(frameGray,opticFlow); % Find bounding boxes
if ~isempty(bboxes)
   disp('here');
img = zeros([imageSize size(bboxes,1)]);
for ii = 1:size(bboxes,1)
img(:,:,:,ii) = imresize(imcrop(videoFrame,bboxes(ii,:)),imageSize(1:2));
end

% Step 3. Recognize object
% (a) Extract features using a CNN
[~, scores] = cnnPredict(cnnModel,img,'UseGPU',false,'display',false);

% (b) Predict using the trained SVM Classifier
label = predict(svmmdl,scores);

% Step 4. Annotate object
videoFrame = insertObjectAnnotation(videoFrame,'Rectangle',bboxes,cellstr(label),'FontSize',40);

end

% Step 5. Write video to file
writeVideo(vw,videoFrame);

fprintf('Frames processed: %d of %d\n',frameNumber,ceil(vr.FrameRate*vr.Duration));
end
%imshow(videoFrame);
close(vw);