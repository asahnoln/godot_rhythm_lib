extends WAT.Test

# TODO: Same hit time after pattern change counts as a miss! Should work on that?

var bp: BeatProcessor


func pre() -> void:
	bp = BeatProcessor.new()


func title() -> String:
	return "Beat Processor Test"


func test_register_miss_if_extra_hit_within_buffer():
	bp.apm = 120

	var _hit := bp.hit(1)
	asserts.is_false(bp.hit(1), "Miss should be registered if extra hit done on the same time")

	_hit = bp.hit(9.477333)
	asserts.is_false(
		bp.hit(9.5), "Miss should be registered if extra hit done on within the same buffer"
	)


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


func test_buffer_to_hit():
	bp.apm = 120
	asserts.is_true(bp.hit(9.477333), "Hit should be registered with enough buffer until real beat")
	asserts.is_true(
		bp.hit(47.557335), "Hit should be registered with enough buffer after real beat"
	)


func test_beat_on_given_pattern():
	bp.apm = 60

	var tests := {
		[2, 2]:
		[
			{
				"desc": "Simple pattern: Hit should be registered on second pattern sol",
				"time": 1.5,
				"want": true,
			},
			{
				"desc": "Simple pattern: Miss should be registered on first pattern sol",
				"time": 0.25,
				"want": false,
			},
		],
		[2, 1, 1]:
		[
			{
				"desc": "Advanced: Hit should be registered on second pattern sol in first cycle",
				"time": 0.5,
				"want": true,
			},
			{
				"desc": "Advanced: Hit should be registered on third pattern sol in second cycle",
				"time": 1.75,
				"want": true,
			},
			{
				"desc": "Advanced: Miss should be registered on second pattern sol in first cycle",
				"time": 0.25,
				"want": false,
			},
		],
		[1, 2, 1]:
		[
			{
				"desc": "Advanced 2: Hit should be registered on third pattern sol in second cycle",
				"time": 1.75,
				"want": true,
			},
			{
				"desc":
				"Advanced 2: Miss should be registered on second pattern sol in first cycle",
				"time": 0.5,
				"want": false,
			},
		],
		[1, 2, 1, 2, 1]:
		[
			{
				"desc":
				"Moving offbeat: Miss should be registered on second pattern sol in first cycle",
				"time": 0.5,
				"want": false,
			},
			{
				"desc":
				"Moving offbeat: Miss should be registered on fourth pattern sol in first cycle",
				"time": 1.25,
				"want": false,
			},
			{
				"desc":
				"Moving offbeat: Miss should be registered on second pattern sol in first cycle",
				"time": 1.75,
				"want": true,
			},
		],
	}

	for pattern in tests:
		bp.pattern = pattern
		for tt in tests[pattern]:
			asserts.is_equal(bp.hit(tt["time"]), tt["want"], tt["desc"])
