function death(){
	room_goto(Death)
	audio_stop_all()
	audio_play_sound(lumihurtmeow, 1, false)
}