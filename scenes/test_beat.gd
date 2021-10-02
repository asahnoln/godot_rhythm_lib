extends Node2D

var animation_bp := BeatProcessor.new()
var bp := BeatProcessor.new()

var _pos := 0.0

onready var _audio := $AudioStreamPlayer
onready var _tween := $Tween
onready var _rect := $ColorRect


func _init() -> void:
	bp.apm = 120
	bp.pattern = [4]
	animation_bp.apm = 120
	animation_bp.pattern = [4]


func _process(_delta: float) -> void:
	_pos = (
		_audio.get_playback_position()
		+ AudioServer.get_time_since_last_mix()
		- AudioServer.get_output_latency()
	)
	if animation_bp.hit(_pos):
		_tween.interpolate_property(
			_rect,
			"rect_size:y",
			_rect.rect_size.y / 2,
			_rect.rect_size.y,
			0.15,
			Tween.TRANS_ELASTIC,
			Tween.EASE_OUT
		)
		_tween.start()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		print("position is ", _pos)
		print("on beat is ", bp.hit(_pos))
