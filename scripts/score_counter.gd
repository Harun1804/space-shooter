extends HBoxContainer

var digitCoords = {
	1: Vector2(0,0),
	2: Vector2(8,0),
	3: Vector2(16,0),
	4: Vector2(24,0),
	5: Vector2(32,0),
	6: Vector2(0,0),
	7: Vector2(8,0),
	8: Vector2(16,0),
	9: Vector2(24,0),
	0: Vector2(32,0),
}

func displayDigits(n):
	var s = "%08d" % n
	for i in 8:
		get_child(i).texture.region = Rect2(digitCoords[int(s[i])], Vector2(8, 8))
