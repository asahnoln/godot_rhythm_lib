extends WAT.Test

var bp: BeatProcessor


func pre() -> void:
	bp = BeatProcessor.new()


func title() -> String:
	return "Beat Processor Test"
	

func test_register_miss_if_extra_hit():
	var _hit := bp.hit(1)
	asserts.is_false(bp.hit(1), "Miss should be registered if extra hit done on the same time")


func test_register_hit_on_beat():
	asserts.is_true(bp.hit(0), "Hit should be registered on beat 0")
	asserts.is_true(bp.hit(1), "Hit should be registered on beat 1")
	asserts.is_true(bp.hit(2), "Hit should be registered on beat 2")
	

func test_register_miss_out_of_beat():
	asserts.is_false(bp.hit(0.5), "Miss should be registered out of beat")
	

func test_different_tempo_hit_on_beat():
	bp.apm = 80
	asserts.is_true(bp.hit(0.75), "Hit should be registered on second beat (0.75)")
	asserts.is_true(bp.hit(1.5), "Hit should be registered on third beat (1.5)")
