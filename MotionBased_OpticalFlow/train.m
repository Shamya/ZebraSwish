cnnModel.net = load('imagenet-vgg-f.mat');
imset = imageSet('fish_images','recursive');
imageSize = cnnModel.net.meta.normalization.imageSize;
disp('here')
cnt = 0;
for ii = 1:numel(imset)
    disp(ii)
  for jj = 1:imset(ii).Count
      cnt = cnt+1;
      trainingImages(:,:,:,cnt) = imresize(single(read(imset(ii),jj)),imageSize(1:2));
  end
end
disp(size(trainingImages));
disp('here')
trainingLabels = getImageLabels(imset);
cnnModel.info.opts.batchSize = 150;
disp('here')
[~, cnnFeatures, timeCPU] = cnnPredict(cnnModel,trainingImages,'UseGPU',false);
svmmdl = fitcsvm(cnnFeatures,trainingLabels);
cvmdl = crossval(svmmdl,'KFold',10);
fprintf('kFold CV accuracy: %2.2f\n',1-cvmdl.kfoldLoss)