extends Node

var hurt = preload("res://Music/hurt.wav")

var jump = preload("res://Music/jump.wav")

var fuck = preload("res://Music/Voicy_Fuck you.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	elif sfx_name == "fuck":
		stream = fuck
	else:
		print("Invalid sfx name")
		return
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()
