blankimage = zeros(48,52,3);
for i = 1:350
    name = strcat('pet_images/NotZebra/test',num2str(i));
    name = strcat(name,'.JPEG');
    imwrite(blankimage,name);
end