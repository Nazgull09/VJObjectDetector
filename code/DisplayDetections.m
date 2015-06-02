function DisplayDetections(im, dets1)

imshow(im);

k1 = size(dets1,1);

hold on;
for i=1:k1
   rectangle('Position', dets1(i,:),'LineWidth',2,'EdgeColor', 'r'); 
end
hold off;

