


toggle_canopy = func {
  if(getprop("/controls/canopy/canopy-pos-norm") > 0) {
    interpolate("/controls/canopy/canopy-pos-norm", 0, 3);
  } else {
    interpolate("/controls/canopy/canopy-pos-norm", 1, 3);
  }
}


