module drain_cover(outer_radius, inner_radius, height, top_thin, thin)
{
    edge_len = outer_radius - inner_radius;
    bottom_radius = 0.6 * inner_radius;

    // top
    translate(v = [ 0, 0, 0.5 * (height - top_thin) ])
        circular_net(radius = outer_radius, height = top_thin, outer_width = edge_len, hole_width = 8, net_width = 3);

    // side
    side_net(top_radius = inner_radius + thin, bottom_radius = bottom_radius, height = height, thin = thin,
             hole_width = 2, net_width = 2);

    // bottom
    translate(v = [ 0, 0, -0.5 * (height - thin) ])
        circular_net(radius = bottom_radius, height = thin, outer_width = 2, hole_width = 3, net_width = 2);
}

module side_net(top_radius, bottom_radius, height, thin, hole_width, net_width)
{
    difference()
    {
        base_side(top_radius = top_radius, bottom_radius = bottom_radius, height = height, thin = thin);

        average_radius = 0.5 * (top_radius + bottom_radius);
        d_radian = (hole_width + net_width) / average_radius;
        d_degree = d_radian * 180 / PI;
        for (angle = [0:d_degree:180])
        {
            rotate([ 0, 0, angle ]) cube(size = [ 2 * top_radius, hole_width, height - 2 * thin ], center = true);
        }
    }
}

module base_side(top_radius, bottom_radius, height, thin)
{
    difference()
    {
        cylinder(h = height, r1 = bottom_radius, r2 = top_radius, center = true);
        cylinder(h = height + 0.01, r1 = bottom_radius - thin, r2 = top_radius - thin, center = true);
    }
}

module circular_net(radius, height, outer_width, hole_width, net_width)
{
    center = true;

    // 外側の縁部分
    ring(outer_radius = radius, height = height, width = outer_width, center = center);

    // 同心円状の網部分
    for (ring_radius = [radius - outer_width - hole_width:-(net_width + hole_width):0])
    {
        ring(outer_radius = ring_radius, height = height, width = net_width, center = center);
    }

    // 網を支える棒部分
    bar_num = 3;
    for (angle = [0:180 / bar_num:180])
    {
        rotate([ 0, 0, angle ]) cube(size = [ 2 * radius - outer_width, net_width, height ], center = true);
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

drain_cover(outer_radius = 50, inner_radius = 35, height = 30, top_thin = 10, thin = 2);
