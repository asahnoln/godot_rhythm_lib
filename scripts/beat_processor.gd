class_name BeatProcessor

var _hit := false
var _count := 0


# Register hit
func hit() -> bool:
	_count += 1
	return _hit and _count < 2


func play():
	_hit = true
