scope_inner_diameter = 24;
scope_outer_diameter = 26;
scope_depth = 24;
lip_depth = 10;
hex_diam = 6;

module hexagon(diam)
{
  cylinder(h=scope_depth, d=diam,$fn=6);
}

module draw_hexagon(x,y)
{
    for(y = [-(y/2):1:(y/2)])
    {
        translate([0,hex_diam*y,0])
                {
                    for(ang = [60])
            {
            rotate(ang)
            for(x = [-(x/2):1:(x/2)])
            {
                translate([0,hex_diam*x,0])
                {
                    hexagon(hex_diam);
                }
            }
            }
                }
    }        
}
module make_hexagon()
{
total_width=hex_diam+scope_inner_diameter;
latt_quant = ceil(total_width/hex_diam);
if (latt_quant % 2 == 0) draw_hexagon(latt_quant+0,latt_quant+0);
else {draw_hexagon(latt_quant+1,latt_quant+1);}
}

union()
{
difference()
{
    cylinder(h=scope_depth, d=scope_inner_diameter,$fn=128);
    intersection()
        {
            make_hexagon();
            cylinder(h=scope_depth, d=scope_inner_diameter,$fn=128);
        }
}

difference()
{
    cylinder(h=lip_depth, d=scope_outer_diameter,$fn=128);
    cylinder(h=lip_depth, d=scope_inner_diameter,$fn=128);
}    
}
