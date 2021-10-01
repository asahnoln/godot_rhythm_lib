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
	match pattern:
		[4]:
			var matras := [1, 0, 0, 0]
			var close_index := round(index)
			var buffer := abs(index - close_index)
			var res := false
			if buffer < 0.5:
				res = _last_index != close_index and matras[int(close_index) % 4] == 1
					
			_last_index = close_index
			return res
		[2, 2]:
			if int(index) % 4 in [1, 3]:
				index -= 0.5
		[1, 1, 1, 1]:
			pass
		[2, 1, 1]:
			if int(index) % 4 == 1:
				index -= 0.5
		[1, 2, 1]:
			if int(index) % 4 == 2:
				index -= 0.5
		[1, 2, 1, 2, 1]:
			if int(index) % 7 in [2, 5]:
				index -= 0.5
			
	var close_index := round(index)
	var buffer := abs(index - close_index)
	if buffer < 0.15:
		result = _last_index != close_index
			
	_last_index = close_index
	return result

