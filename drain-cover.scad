module drain_cover(radius, edge_len, height, sharpness, top_thin, thin)
{
    side_height = height - top_thin;

    // top
    translate(v = [ 0, 0, side_height + 0.5 * top_thin ])
        circular_net(radius = radius, edge_len = edge_len + thin, height = top_thin, hole_width = 8, net_width = 3);

    // side
    side_net(radius = radius - edge_len, height = side_height, factorial = sharpness, thin = thin, hole_width = 2,
             net_width = 2);
}

module side_net(radius, height, factorial, thin, hole_width, net_width)
{
    intersection()
    {
        base_side(radius = radius, height = height, factorial = factorial, thin = thin);
        net(radius = radius, height = height, thin = thin, hole_width = hole_width, net_width = net_width);
        ring(outer_radius = radius, width = 0.4 * radius, height = height, center = false);
    }
    intersection()
    {
        base_side(radius = radius, height = height, factorial = factorial, thin = thin);
        translate(v = [ 0, 0, 0.5 * height ])
            circular_net(radius = 0.6 * radius, edge_len = net_width, height = height,
                         hole_width = hole_width, net_width = net_width);
    }
}

module net(radius, height, thin, hole_width, net_width)
{
    d_radian = (hole_width + net_width) / radius;
    d_degree = d_radian * 180 / PI;
    for (angle = [0:d_degree:360])
    {
        rotate([ 0, 0, angle ])
        {
            linear_extrude(height = height, center = false)
                polygon(points = [ [ 0, 0 ], [ radius, 0.5 * net_width ], [ radius, -0.5 * net_width ] ]);
        }
    }
}

module base_side(radius, height, factorial, thin)
{
    curve_func = function(x) height * (x / radius) ^ factorial + 0.5 * thin;
    rotate_extrude(angle = 360)
    {
        intersection()
        {
            printFunc(func = curve_func, xrange = [ 0, radius ], div = 1, thinness = thin);
            translate(v = [ 0.5 * radius, 0.5 * height, 0 ]) square(size = [ radius, height ], center = true);
        }
    }
}

module printFunc(func, xrange, div, thinness)
{
    $fs = 1;
    for (i = [xrange[0] + div:div:xrange[1]])
    {
        p0 = [ i - div, func(i - div), 0 ];
        p1 = [ i, func(i), 0 ];
        hull()
        {
            translate(v = p0) circle(d = thinness);
            translate(v = p1) circle(d = thinness);
        }
    }
}

module circular_net(radius, edge_len, height, hole_width, net_width)
{
    center = true;

    // 外側の縁部分
    ring(outer_radius = radius, height = height, width = edge_len, center = center);

    // 同心円状の網部分
    for (ring_radius = [radius - edge_len - hole_width:-(net_width + hole_width):0])
    {
        ring(outer_radius = ring_radius, height = height, width = net_width, center = center);
    }

    // 網を支える棒部分
    bar_num = 3;
    for (angle = [0:180 / bar_num:180])
    {
        rotate([ 0, 0, angle ]) cube(size = [ 2 * radius - edge_len, net_width, height ], center = true);
    }
}

module ring(outer_radius, width, height, center)
{
    difference()
    {
        cylinder(h = height, r = outer_radius, center = center);
        cylinder(h = height + 1, r = outer_radius - width, center = center);
    }
}
