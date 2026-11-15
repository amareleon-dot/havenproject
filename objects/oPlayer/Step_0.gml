// 1. Booster check
var booster_inst = instance_place(x, y, oBooster);
if (booster_inst != noone && boost_timer <= 0) {
    boost(booster_inst);
}

// 2. Movement + boost handling
if (boost_timer > 0) {
    boost_timer--;
    
    if (boost_type == 1) {
        // ===== HORIZONTAL BOOST =====
        // Gradually slow down
        var friction_amount = 0.8;
        if (hspd > 0) hspd = max(0, hspd - friction_amount);
        if (hspd < 0) hspd = min(0, hspd + friction_amount);
        
        // Limited air control
        if (keyboard_check_direct(ord("D"))) hspd += 0.6;
        if (keyboard_check_direct(ord("A"))) hspd -= 0.6;
        
        // Clamp so it never exceeds original boost speed
        hspd = clamp(hspd, -40, 40);
    }
    else if (boost_type == 3) {
    // ===== UPWARD BOOST =====
    // Weaker / floatier horizontal control so it doesn't feel like the boost is also pushing you sideways
    
    var air_control = move * 0.6;   // 60% of normal speed (try 0.4 – 0.7)
    
    if (keyboard_check_direct(ord("D"))) {
        hspd = air_control;
    } else if (keyboard_check_direct(ord("A"))) {
        hspd = -air_control;
    } else {
        // Stronger air friction so you don't keep sliding forever
        if (hspd > 0) {
            hspd = max(0, hspd - 0.7);
        } else if (hspd < 0) {
            hspd = min(0, hspd + 0.7);
        }
		}
	}
}
else {
    // Normal movement
    if (keyboard_check_direct(ord("D"))) {
        hspd = move;
    } else if (keyboard_check_direct(ord("A"))) {
        hspd = -move;
    } else {
        hspd = 0;
    }
}

// 3. Horizontal collision
if (place_meeting(x + hspd, y, oGrounds)) {
    while (!place_meeting(x + sign(hspd), y, oGrounds)) {
        x += sign(hspd);
    }
    hspd = 0;
    boost_timer = 0; // cancel boost on wall hit
}

x += hspd;

// Gravity (always apply now)
vspd += accel;

// 4. Vertical collision
if (place_meeting(x, y + vspd, oGrounds)) {
    while (!place_meeting(x, y + sign(vspd), oGrounds)) {
        y += sign(vspd);
    }

    if (vspd > 0) {
        vspd = -28 - jumpaccel;
    } else {
        vspd = 0;
    }
    
    // Cancel remaining boost when landing
    if (boost_timer > 0) boost_timer = 0;
}
else {
    y += vspd;
}

with (oMovePlat) {
    if (place_meeting(x + platform_hspd, y, other)) {
        other.x += platform_hspd;
    }
}

// ===== ANIMATION & FACING =====
var on_ground = place_meeting(x, y + 1, oGrounds);

// Facing direction
if (hspd > 0) {
    image_xscale = -1.5;
} else if (hspd < 0) {
    image_xscale = 1.5;
}

// Animation states
if (on_ground) {
    // Ground
    image_index = 0;
    image_speed = 0;
}
else if (vspd < 0) {
    // Jumping (going up)
    image_index = 1;
    image_speed = 0;
}
else {
    // Falling
    image_speed = 0.2;           // speed of the fall animation
    if (image_index < 3 || image_index > 4) {
        image_index = 3;          // start at frame 3
    }
}