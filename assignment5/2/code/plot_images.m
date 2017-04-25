function plot_images( image, image_title )

figure;
colors = 200;
my_color_scale = [ [0:1/(colors-1):1]' , [0:1/(colors-1):1]' , [0:1/(colors-1):1]' ];
imagesc (single (image));
title(image_title);
colormap (my_color_scale);
colormap gray;
daspect ([1 1 1]);
axis tight;
colorbar;

end

