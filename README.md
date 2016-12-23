# ZebraSwish
##A Tool for Locomotive Behavioral Analysis of Zebrafish
Zebrafish are used to study the changes in the locomo- tive behavior after mutation. Most researchers go through a time-consuming and labor-intensive task of manually anno- tating the zebrafish videos. ZebraZoom is the state of the art tool used by some researchers to automate this process, but fails to accurately detect zebrafish in the presence of other visible objects. Prof Gerald Downes at UMass Amherst Bi- ology department is an active researcher in this field and uses a tactile stimulus in his experiments, which is visible on captured footage. Downes lab has a repository of sev- eral high-speed videos of the zebrafish. In this project, we tried to use deep learning and image processing approaches to accurately detect the zebrafish.<br>

Our first task was to annotate a set of video frames to locate a bounding box around the zebrafish. We then trained an end to end convolutional neural network model in Caffe. In our second approach, we fine-tuned the imagenet-vgg-f model with the last layer of support vector machine classifier trained on the features of the ze- brafish data. In an attempt to compare our deep learning models with an image processing approach, we did motion- based object tracking on the movements of the zebrafish and probe in the video. Our end-to-end model was unable to learn to detect the zebrafish. While the fine-tuned network was able to classify (zebrafish vs no zebrafish) with a 80% accuracy, its performance was dependent on the accuracy of the bounding box detection by optical flow. Motion-based object tracking was comparatively most accurate for fish in motion but had issues recovering the full body after the ze- brafish tilts at right angle or curls up into a blob.


##ZebraSwish annotation tool
Cross-platform tool for analyzing zebrafish swimming behavior
Very much under development and completely unready for real use.

The idea is that this tool will allow you to select a video file (or maybe a video stream from a camera), and automatically (or with use adjustment) detect zebrafish in view, and then produce a graph of the angle of their body as they swim.
