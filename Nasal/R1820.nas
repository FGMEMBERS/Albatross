var blower = props.globals.getNode("controls/engines/engine[0]/boost");

var shift_blower_up = func {
	if (blower.getValue() <= 0.5){
		interpolate("controls/engines/engine[0]/boost", 1.0, 45);
		interpolate("controls/engines/engine[1]/boost", 1.0, 45);
	}

}
var shift_blower_dn = func {
	if (blower.getValue() >= 1.0){
		interpolate("controls/engines/engine[0]/boost", 0.5, 45);
		interpolate("controls/engines/engine[1]/boost", 0.5, 45);
	}

}
