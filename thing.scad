include <BOSL2/std.scad>

/* [main settings] */

some_var = 42;// [5:0.1:69]

// things below this won't show up in the customizer
module __Customizer_Limit__() {
}

// set quality, 64 for testing, 128 for rendering
$fn = $preview ? 64 : 128;

tolerance_tight = 0.125;
tolerance_normal = 0.25;
tolerance_loose = 0.5;

module round(roundness = 1) {
  offset(roundness)
    offset(-2 * roundness)
      offset(roundness)
        children();
}

depth = 3 + 1;
key_length = 5 + tolerance_loose;
insert_d = 10 - tolerance_loose;

handle_offset = depth;
handle_length = 12.5;
handle_width = 20;
handle_thickness = 3;

_key_height = depth + handle_offset;

module key()union() {
  zmove(depth)
    cyl(d = insert_d, h = handle_offset, center = false);
  #difference() {
    cyl(d = insert_d, h = depth, center = false);
    cube([key_length, key_length, depth], anchor = BOTTOM);
  }
}

module handle()union() {
  cyl(h = handle_length / 2, d1 = insert_d, d2 = 0, anchor = BOTTOM);
  prismoid(size1 = [insert_d, handle_thickness], size2 = [handle_width, handle_thickness], h = handle_length, rounding = handle_thickness / 2);
}

// handle();

union() {
  key();

  zmove(_key_height)
    handle();
}