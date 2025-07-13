extends Area2D

signal died
signal shieldChanged

@onready var screensize = get_viewport_rect().size

@export var speed = 150
@export var cooldown = 0.25
@export var bulletScene: PackedScene
@export var maxShield = 10
var shield = maxShield:
	set = setShield
	
func setShield(value):
	shield = min(maxShield, value)
	shieldChanged.emit(maxShield, value)
	if shield <= 0:
		hide()
		died.emit()

var canShoot = true

func _ready() -> void:
	start()

func start():
	position = Vector2(screensize.x / 2, screensize.y - 64)
	$GunCooldown.wait_time = cooldown

func _process(delta: float):
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x > 0:
		$Ship.frame = 2
		$Ship/Boosters.animation = "right"
	elif input.x < 0:
		$Ship.frame = 0
		$Ship/Boosters.animation = "left"
	else:
		$Ship.frame = 1
		$Ship/Boosters.animation = "forward"
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	position += input * speed * delta
	position = position.clamp(Vector2(8, 8), screensize - Vector2(8, 8))

func shoot():
	if not canShoot:
		return
	canShoot = false
	$GunCooldown.start()
	var b = bulletScene.instantiate()
	get_tree().root.add_child(b)
	b.start(position + Vector2(0, -8))


func _on_gun_cooldown_timeout():
	canShoot = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.explode()
		shield -= maxShield / 2
