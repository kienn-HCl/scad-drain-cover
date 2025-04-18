module drain_cover(outer_radius, inner_radius, height)
{
    top_thin = 7;
    thin = 2;
    edge_len = outer_radius - inner_radius;

    // top
    translate(v = [ 0, 0, 0.5 * (height - top_thin) ])
        circular_net(radius = outer_radius, height = top_thin, outer_width = edge_len + thin, hole_width = 8);

    // side
    side_net(height = height, top_radius = inner_radius, thin = thin, hole_width = 3);

    // bottom
    translate(v = [ 0, 0, -0.5 * (height - thin) ])
        circular_net(radius = 0.8 * inner_radius, height = thin, outer_width = 7, hole_width = 3);
}

module side_net(height, top_radius, thin, hole_width)
{
    difference()
    {
        base_side(height = height, top_radius = top_radius, thin = thin);

        net_width = 0.8 * hole_width;
        d_radian = (hole_width + net_width) / (0.9 * top_radius);
        d_degree = d_radian * 180 / PI;
        for (angle = [0:d_degree:180])
        {
            rotate([ 0, 0, angle ]) cube(size = [ 2 * top_radius, hole_width, 0.9 * height ], center = true);
        }
    }
}

module base_side(height, top_radius, thin)
{
    difference()
    {
        cylinder(h = height, r1 = 0.8 * top_radius, r2 = top_radius, center = true);
        cylinder(h = height + 1, r1 = 0.8 * top_radius - thin, r2 = top_radius - thin, center = true);
    }
}

module circular_net(radius, height, outer_width, hole_width)
{
    center = true;

    // 外側の縁部分
    ring(outer_radius = radius, height = height, width = outer_width, center = center);

    // 同心円状の網部分
    net_width = 0.8 * hole_width;
    for (ring_radius = [radius - outer_width - hole_width:-(net_width + hole_width):0])
    {
        ring(outer_radius = ring_radius, height = height, width = net_width, center = center);
    }

    // 網を支える棒部分
    bar_num = 3;
    bar_width = 1.2 * hole_width;
    for (angle = [0:180 / bar_num:180])
    {
        rotate([ 0, 0, angle ]) cube(size = [ 2 * radius - outer_width, bar_width, height ], center = true);
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

drain_cover(outer_radius = 100, inner_radius = 80, height = 50);
