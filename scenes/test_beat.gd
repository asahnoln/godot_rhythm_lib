extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bp := BeatProcessor.new()

onready var _audio := $AudioStreamPlayer

func _init() -> void:
	bp.apm = 120

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var _pos: float = _audio.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
		print("position is ", _pos)
		print("on beat is ", bp.hit(_pos))
