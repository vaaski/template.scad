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
