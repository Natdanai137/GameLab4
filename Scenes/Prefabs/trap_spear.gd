extends StaticBody2D

# กับดักไฟ (Fire): ลุกเป็นจังหวะ โดยสุ่มเวลา delay ก่อนเริ่ม
# ทำให้ไฟแต่ละกองไม่ลุกพร้อมกัน — เป็นอันตราย (มี collision) เฉพาะตอนไฟลุก

@onready var fire: AnimatedSprite2D = $Fire
@onready var col: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	col.disabled = true
	fire.play("off")
	await get_tree().create_timer(randf_range(0.0, 2.0)).timeout
	while is_inside_tree():
		fire.play("on"); col.disabled = false
		await get_tree().create_timer(1.5).timeout
		if not is_inside_tree(): return
		fire.play("off"); col.disabled = true
		await get_tree().create_timer(1.2).timeout
