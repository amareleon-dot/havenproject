vspd = 100;
hspd = 0;

move = 26;

jump_time = 30;

accel = 1;

jumpaccel = 2;

audio_play_sound(sndElectrometro, 1, true);

fullscreen = false;

boost_timer = 0;

function boost(inst) {
    hspd = 0; // clear horizontal momentum so the booster fully controls direction
    
    if (inst.dir == 1) {          // Right
        hspd = 40;
        boost_timer = room_speed;
        boost_type = 1;
    }
    else if (inst.dir == 2) {     // Left
        hspd = -40;
        boost_timer = room_speed;
        boost_type = 1;
    }
    else if (inst.dir == 3) {     // Up
        vspd = -40;               // ← change this number to control height
        boost_timer = room_speed;
        boost_type = 3;
    }
}

hearts = 9;