include <BOSL2/std.scad>

/* [main settings] */

angle = 20;
beam_height = 45;
beam_diameter = 16;

/* [print settings] */

layer_height = 0.12;
layer_width = 0.4;
wall_thickness = 1.6;

/* [charge module settings] */

// apple magsafe magnet ring outer diameter
charge_module_diameter = 54.1;
charge_module_height = 5;

// things below this won't show up in the customizer
module __Customizer_Limit__() {
}

// set quality, 64 for testing, 128 for rendering
$fn = $preview ? 64 : 256;

tolerance_tight = 0.125;
tolerance_normal = 0.25;

base_cyl_d = charge_module_diameter + 2 * wall_thickness + 2 * tolerance_tight;
base_cyl_h = charge_module_height + 2 * wall_thickness + 2 * tolerance_tight;

module base_cylinder() {

  cyl(d = base_cyl_d, h = base_cyl_h, anchor = DOWN);
}
// base_cylinder();

module base_beam() {
  zrot(180)
    xrot((90 - angle) / -2, cp = [0, beam_diameter / 2, 0])
      top_half()
        xrot((90 - angle) / 2, cp = [0, beam_diameter / 2, 0])
          cyl(d = beam_diameter, h = beam_height, anchor = DOWN);
}
// base_beam();

module module_half() {
  xrot(180, cp = [0, 0, (beam_height + base_cyl_h) / 2]) {
    base_beam();

    zmove(beam_height)
      base_cylinder();
  }
}
// module_half();

module transform_upper_half() {
  xrot(-90 - angle, cp = [0, beam_diameter / 2, beam_height + base_cyl_h])
    ymove(beam_diameter)
      zrot(180)
        children();
}

transform_upper_half()
  module_half();

module_half();