if (place_meeting(x, y, oPlayer)) {
    global.open[key_id] = true; // Ensure key_id is a small integer (0, 1, 2...)
    instance_destroy();         // Destroys ONLY this specific key instance
}