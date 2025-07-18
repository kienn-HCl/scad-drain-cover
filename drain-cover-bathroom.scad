use <drain-cover.scad>

module drain_cover_top(radius, edge_len, height, sharpness, top_thin, thin)
{
    side_height = height - top_thin;
    translate(v = [ 0, 0, side_height ])
    ring(
        outer_radius = radius,
        width = edge_len + thin,
        height = top_thin
    );
    side_net(
      radius = radius - edge_len,
      height = side_height,
      factorial = sharpness,
      thin = thin,
      hole_width = 10,
      net_width = 2
    );
}
module drain_cover_bottom(radius, edge_len, height, sharpness, top_thin, thin)
{
    side_height = height - top_thin;
    translate(v = [ 0, 0, side_height ])
    ring(
        outer_radius = radius,
        width = edge_len + thin,
        height = top_thin
    );
    side_net(
      radius = radius - edge_len,
      height = side_height,
      factorial = sharpness,
      thin = thin,
      hole_width = 2,
      net_width = 2
    );
}
translate(v = [ 120, 0, 0])
drain_cover_top(
  radius = 53,
  edge_len = 2,
  height = 9,
  sharpness= 4,
  top_thin = 1,
  thin = 2
);
drain_cover_bottom(
  radius = 51,
  edge_len = 18,
  height = 23,
  sharpness= 4,
  top_thin = 3,
  thin = 2
);
