var sin = func(a) { math.sin(a * math.pi / 180.0) }
var cos = func(a) { math.cos(a * math.pi / 180.0) }

init = func {
  setprop ("/autopilot/locks/heading" , "none" );
  setprop ("/autopilot/locks/altitude" , "none" );

 main_loop();
}

main_loop = func {
  cview = getprop("/sim/current-view/view-number");
    if (cview >= 7) {
      aphmode = getprop ("/autopilot/locks/heading");
      apvmode = getprop ("/autopilot/locks/altitude");
#      print (aphmode);
#      print (apvmode);
      if (aphmode == "none" ) {
        setprop ("/autopilot/locks/heading", "wing-leveler");
        setprop ("/autopilot/htempmode", 1 );
      }
      if (apvmode == "none" ) {
        setprop ("/autopilot/locks/altitude", "vertical-speed-hold");
        setprop ("autopilot/vtempmode" , 1 );
      }



    } else {
      htempmode = getprop ("/autopilot/htempmode");
      vtempmode = getprop ("/autopilot/vtempmode");
      if (htempmode == 1) {
        setprop ("/autopilot/locks/heading" , "none" );
        setprop ("/autopilot/htempmode" , 0);
      }
      if (vtempmode == 1) {
        setprop ("/autopilot/locks/altitude" , "none" );
        setprop ("/autopilot/vtempmode" , 0);
      }
    }
    settimer(main_loop, 0.01);
} 



toggle_canopy = func {
  if(getprop("/controls/canopy/canopy-pos-norm") > 0) {
    interpolate("/controls/canopy/canopy-pos-norm", 0, 3);
  } else {
    interpolate("/controls/canopy/canopy-pos-norm", 1, 3);
  }
}


int_mov = func {
#### interiour view Movement

				if (getprop ("sim/current-view/view-number") == 7) {
				if (getprop ("devices/status/mice/mouse/mode") == 2){

						head = getprop ("sim/current-view/heading-offset-deg");
						posx = getprop ("sim/current-view/x-offset-m");
						posy = getprop ("sim/current-view/y-offset-m");
						posz = getprop ("sim/current-view/z-offset-m");
### left - right
						if (posx > zoneData[currentZone][1]){
							if (posx < zoneData[currentZone][2]) {
							interpolate ("sim/current-view/x-offset-m", posx - 0.1*sin(head),0.25);
						} else {
							setprop ("sim/current-view/x-offset-m", posx -0.02);
							} 
					} else {
							setprop ("sim/current-view/x-offset-m", posx +0.02);
							}
### fore - aft
						if (posz > zoneData[currentZone][3]){
							if (posz < zoneData[currentZone+1][3]) {
							interpolate ("sim/current-view/z-offset-m", posz - 0.2*cos(head),0.25);
						} else {
							if (posx > zoneData[currentZone+1][1] and posx < zoneData[currentZone+1][2]) {
								currentZone = currentZone +1;
#								print ("zone +");
							} else {
								setprop ("sim/current-view/z-offset-m", posz -0.02);
								}
							} 
					} else {
							if (posx > zoneData[currentZone-1][1] and posx < zoneData[currentZone-1][2]) {
								currentZone = currentZone -1;
#								print ("zone -");
							} else {
							setprop ("sim/current-view/z-offset-m", posz +0.02);
								}
							}
### up - down
						if (posy != zoneData[currentZone][4]){
							interpolate ("sim/current-view/y-offset-m", zoneData[currentZone][4],0.25);
						}
					
				}
			}
}

currentZone = 1;
    zoneData = [
    ["nose"      ,-0.5,	0.5,  0.9, -0.2],
    ["Pilot Compartment"	,-0.7,0.7,3.5,0.5],
		["Cockpit Door"	,-0.1,0.1,4.6,0.4],
    ["Navigator Compartment"  ,-0.8,0.8,4.9,0.5],
		["Passage",-0.4,0.4,6.7,0.5],
		["Rear Room",-0.8,0.8,8.7,0.5],
		["End",0,0,12.3,0]
    ];
