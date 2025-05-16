use <drain-cover.scad>

module drain_cover(radius, edge_len, height, sharpness, top_thin, thin)
{
    side_height = height - top_thin;
    claw_thin = 1;
    claw_width = 5;
    claw_height = 0.25*top_thin;

    // cap
    translate(v = [0,0,20]) 
    translate(v = [0,0,height - 0.25*top_thin]) 
    {
        cap_r = radius - 0.5 * edge_len - 0.2;
        circular_net(
            radius = cap_r,
            edge_len = 0.5 * edge_len,
            height = 0.5 * top_thin,
            hole_width = 8,
            net_width = 3
        );

        // claw
        translate(v = [0,0,-claw_height]) intersection() {
            cylinder(h = claw_height, r1 = cap_r, r2 = cap_r+claw_thin);
            ring(
                outer_radius = cap_r+claw_thin,
                width = claw_thin,
                height = claw_height,
                center = false
            );
            radial_bar(
                radius = cap_r + claw_thin,
                height = claw_height,
                hole_width = 0.25*PI*cap_r,
                net_width = claw_width
            );
        }

        // handle
        handle_width = 0.25*edge_len;
        handle_height = 20;
        translate(v = [cap_r - handle_width ,0, 0.5*handle_height]) 
        cube(size = [handle_width,handle_width, handle_height], center = true);
    }
    // top
    translate(v = [ 0, 0, side_height + 0.5 * top_thin ]) difference()
    {
        ring(outer_radius = radius, width = edge_len + thin, height = top_thin);
        cylinder(h = top_thin, r = radius - 0.5 * edge_len);
        cylinder(h = claw_height, r = radius - 0.5 * edge_len + claw_thin);
    }

    // side
    side_net(
        radius = radius - edge_len,
        height = side_height,
        factorial = sharpness,
        thin = thin,
        hole_width = 2,
        net_width = 2
    );
}

drain_cover(radius = 51, edge_len = 18, height = 30, sharpness = 4, top_thin = 10, thin = 2);
