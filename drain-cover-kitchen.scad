use <drain-cover.scad>

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
drain_cover(radius = 40, edge_len = 2, height = 35, sharpness=6, top_thin = 2, thin = 2);
