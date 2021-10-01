class_name BeatProcessor

var apm := 60.0
var pattern := [4]

var _last_index := -1.0
const JATHI := 4


# Register hit
func hit(time: float) -> bool:
	var result := false
	var matra_length := 60.0 / apm / JATHI
	
	# Find current matra index and check if it's close enough to integral index
	var index := time / matra_length # 4 is jathi (matras per atcharam)
	var close_index := round(index)
	var buffer := abs(index - close_index)
	var sum := 0
	var matras := []
	match pattern:
		[4]:
			matras = [true, false, false, false]
			sum = 4
		[2, 2]:
			matras = [true, false, true, false]
			sum = 4
		[1, 1, 1, 1]:
			matras = [true, true, true, true]
			sum = 4
		[2, 1, 1]:
			matras = [true, false, true, true]
			sum = 4
		[1, 2, 1]:
			matras = [true, true, false, true]
			sum = 4
		[1, 2, 1, 2, 1]:
			matras = [1, 1, 0, 1, 1, 0, 1]
			sum = 7

	if buffer < 0.5:
		result = _last_index != close_index and matras[int(close_index) % sum]

	_last_index = close_index
	return result
