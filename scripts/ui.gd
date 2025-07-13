extends MarginContainer

@onready var shieldBar = $HBoxContainer/ShieldBar
@onready var scoreCounter = $HBoxContainer/ScoreCounter

func updateScore(value):
	scoreCounter.displayDigits(value)

func updateShield(maxValue, value):
	shieldBar.max_value = maxValue
	shieldBar.value = value
