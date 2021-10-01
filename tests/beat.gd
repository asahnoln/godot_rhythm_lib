extends WAT.Test

var bp: BeatProcessor

func pre() -> void:
	bp = BeatProcessor.new()


func title() -> String:
	return "Beat Processor Test"
	

func test_register_hit():
	asserts.is_false(bp.hit(), "Hit should be detected, but missed due to not playing")


func test_register_miss_if_extra_hit():
	bp.play()
	var _hit := bp.hit()
	asserts.is_false(bp.hit(), "Miss should be registered if extra hit done")


func test_register_hit_on_beat():
	bp.play()
	asserts.is_true(bp.hit(), "Hit should be registered on beat")

