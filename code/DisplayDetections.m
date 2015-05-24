function DisplayDetections(im, dets1,dets2)

imshow(im);

k1 = size(dets1,1);
k2 = size(dets2,1);

hold on;
for i=1:k1
   rectangle('Position', dets1(i,:),'LineWidth',2,'EdgeColor', 'r'); 
end
for i=1:k2
   rectangle('Position', dets2(i,:),'LineWidth',2,'EdgeColor', 'g'); 
end
hold off;

