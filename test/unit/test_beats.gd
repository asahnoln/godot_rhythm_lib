extends "res://addons/gut/test.gd"

var bp: BeatProcessor

func before_each():
	 bp = BeatProcessor.new()
	

func test_register_hit():
	var hit := bp.hit()
	assert_false(hit, "Hit should be detected, but missed due to not playing")


func test_register_miss_if_extra_hit():
	bp.play()
	bp.hit()
	var hit := bp.hit()
	assert_false(hit, "Miss should be registered if extra hit done")


func test_register_hit_on_beat():
	bp.play()
	var hit := bp.hit()
	assert_true(hit, "Hit should be registered on beat")
