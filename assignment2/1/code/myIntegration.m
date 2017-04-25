function [output] = myIntegration(image, t, theta, delta_s)

[r,c] = size(image);
[X,Y] = meshgrid(1:c,r:-1:1);
point_x = c/2 + t*cosd(theta);
point_y = r/2 + t*sind(theta);

line_x = [point_x];
line_y = [point_y];

% positive s
i = 1;
while(1)
    x = point_x - i*delta_s*sind(theta);
    y = point_y + i*delta_s*cosd(theta);
    i = i+1;
    if ((x>=1 && x<=c) && (y>=1 && y<=r))
        line_x = [line_x, x];
        line_y = [line_y, y];
    else
        break
    end
    
end

% negative s
i = 1;
while(1)
    x = point_x + i*delta_s*sind(theta);
    y = point_y - i*delta_s*cosd(theta);
    i = i+1;
    if ((x>=1 && x<=c) && (y>=1 && y<=r))
        line_x = [line_x, x];
        line_y = [line_y, y];
    else
        break
    end
end    
    
output = sum(interp2(X,Y,image,line_x,line_y))*delta_s;

end

