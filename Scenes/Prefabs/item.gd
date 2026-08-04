extends Area2D

# ไอเท็ม 3 แบบ:
#   COIN  (Gold)   -> เพิ่มคะแนน
#   HEART (Bronze) -> เพิ่ม HP
#   SPEED (Silver) -> เพิ่มความเร็วชั่วคราว
enum Kind { COIN, HEART, SPEED }

@export var kind: Kind = Kind.COIN
@export var heal_amount: int = 20
@export var speed_amount: float = 150.0
@export var speed_duration: float = 5.0
@export var amplitude: float = 4.0
@export var frequency: float = 5.0

var _time := 0.0
var _y0 := 0.0

func _ready() -> void:
	_y0 = position.y

func _process(delta: float) -> void:
	# ลอยขึ้นลงเบา ๆ
	_time += delta
	position.y = _y0 + amplitude * sin(frequency * _time)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	AudioManager.coin_pickup_sfx.play()
	match kind:
		Kind.COIN:
			GameManager.add_score()
		Kind.HEART:
			GameManager.add_life()
		Kind.SPEED:
			if body.has_method("apply_speed_boost"):
				body.apply_speed_boost(speed_amount, speed_duration)
	queue_free()
