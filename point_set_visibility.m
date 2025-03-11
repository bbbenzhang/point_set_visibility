function point_set_visibility_2d(x, y, c, alpha, num_points)

    k = 1:num_points;
    R = -1;

    for i = k
        R = max(R, norm([x(i) - c(1), y(i) - c(2)]));
    end
    
    R = R * alpha;
    
    function [x_reflected, y_reflected] = reflect(x, y, R, c)
        x_shifted = x - c(1);
        y_shifted = y - c(2);
        r = sqrt(x_shifted.^2 + y_shifted.^2);
        theta = atan2(y_shifted, x_shifted);
    
        x_reflected = (R + (R - r)) .* cos(theta) + c(1);
        y_reflected = (R + (R - r)) .* sin(theta) + c(2);
    end
    
    [x_reflected, y_reflected] = reflect(x, y, R, c);
    
    hull_x = [x_reflected c(1)];
    hull_y = [y_reflected c(2)];
    [k_in_hull, av] = convhull(hull_x, hull_y);
    
    
    % plot convex hull lines first
    plot(hull_x(k_in_hull), hull_y(k_in_hull), 'Color', 'y');
    hold on
    
    % get rid of the point c in the indexes
    k_in_hull = k_in_hull(k_in_hull <= num_points);
    
    % find the indexes not in the hull
    k_not_in = setdiff(k, k_in_hull);
    
    % plot original in hull
    plot(x(k_in_hull), y(k_in_hull), '.', 'MarkerSize', 20, 'Color', 'b');
    hold on
    
    % plot original not in hull
    plot(x(k_not_in), y(k_not_in), '.', 'Color', 'b');
    hold on
    
    % plot reflected in hull
    plot(x_reflected(k_in_hull), y_reflected(k_in_hull), '.', 'MarkerSize', 20, 'Color', 'r');
    hold on
    
    % plot reflected not in hull
    plot(x_reflected(k_not_in), y_reflected(k_not_in), '.', 'Color', 'r');
    hold on
    
    % plot c
    plot(c(1), c(2), 'x', 'Color', 'black');
    
    axis equal;
end

function point_set_visibility_3d(x, y, z, c, alpha, num_points)

    k = 1:num_points;
    R = -1;

    for i = k
        R = max(R, norm([x(i) - c(1), y(i) - c(2), z(i) - c(3)]));
    end
    
    R = R * alpha;
    
    function [x_reflected, y_reflected, z_reflected] = reflect(x, y, z, R, c)
        x_shifted = x - c(1);
        y_shifted = y - c(2);
        z_shifted = z - c(3);

        r = sqrt(x_shifted.^2 + y_shifted.^2 + z_shifted.^2);

        theta = atan2(y_shifted, x_shifted);
        phi = acos(z_shifted ./ r);
    
        x_reflected = (R + (R - r)) .* cos(theta) .* sin(phi) + c(1);
        y_reflected = (R + (R - r)) .* sin(theta) .* sin(phi) + c(2);
        z_reflected = (R + (R - r)) .* cos(phi) + c(3);
    end
    
    [x_reflected, y_reflected, z_reflected] = reflect(x, y, z, R, c);
    
    hull_x = [x_reflected c(1)];
    hull_y = [y_reflected c(2)];
    hull_z = [z_reflected c(3)];
    [k_in_hull, av] = convhull(hull_x, hull_y, hull_z);
    
    
    % plot convex hull lines first
    trisurf(k_in_hull, hull_x, hull_y, hull_z, 'Facecolor', 'green', 'Facealpha', 0.20, 'LineWidth', 0.5);
    %plot3(hull_x(k_in_hull), hull_y(k_in_hull), hull_z(k_in_hull), 'Color', 'green');
    hold on
    
    % get rid of the point c in the indexes
    k_in_hull = k_in_hull(k_in_hull <= num_points);
    
    % find the indexes not in the hull
    k_not_in = setdiff(k, k_in_hull);
    
    % plot original in hull
    plot3(x(k_in_hull), y(k_in_hull), z(k_in_hull), '.', 'MarkerSize', 15, 'Color', 'b');
    hold on
    
    % plot original not in hull
    plot3(x(k_not_in), y(k_not_in), z(k_not_in), '.', 'MarkerSize', 3, 'Color', 'b');
    hold on
    
    % plot reflected in hull
    plot3(x_reflected(k_in_hull), y_reflected(k_in_hull), z_reflected(k_in_hull),'.', 'MarkerSize', 15, 'Color', 'r');
    hold on
    
    % plot reflected not in hull
    plot3(x_reflected(k_not_in), y_reflected(k_not_in), z_reflected(k_not_in), '.', 'MarkerSize', 3,'Color', 'r');
    hold on
    
    % plot c
    plot3(c(1), c(2), c(3), 'x', 'Color', 'black');
    
    axis equal;
end

function [px, py] = circle(k, m)
    theta = 2 * pi * k / m;
    px = 4 + cos(theta);
    py = sin(theta);
end

function [px, py] = spiral(a, bx, by, theta)
   r = a * theta;
    px = r .* cos(theta) + bx;
    py = r .* sin(theta) + by;
end

function [px, py, pz] = sphere(m)

    sx = mvnrnd(0, 1, m);
    sy = mvnrnd(0, 1, m);
    sz = mvnrnd(0, 1, m);

    samples = [sx sy sz] ./ sqrt(sx.^2 + sy.^2 + sz.^2);

    px = samples(:, 1)' + 4;
    py = samples(:, 2)';
    pz = samples(:, 3)';
end

clear variables;

%num_points = 20;
%[x, y] = circle(1:num_points, num_points);


%num_points = 100;
%[x, y] = spiral(0.05, 4, 0, linspace(8*pi, 10.9*pi, num_points));
%[x, y] = spiral(0.02, 4, 0, linspace(20*pi, 30*pi, num_points));

%c = [0.5, 0.5];
%alpha = 10;

%jsonText = fileread('camel-16.json');
%data = jsondecode(jsonText);
%x = horzcat(data.points.x);
%y = horzcat(data.points.y);

%point_set_visibility_2d(x, y, c, alpha, length(x));

alpha = 100;
%[x, y, z] = sphere(1000);
%c = [0 0 0];

c = [-0.3, 0, 0];
jsonText = fileread('bunny.json');
data = jsondecode(jsonText);
x = -1 .* horzcat(data.points.z);
y = horzcat(data.points.x);
z = horzcat(data.points.y);

point_set_visibility_3d(x, y, z, c, alpha, length(x));

