extends CharacterBody2D

var speed = 100
var direction = 1.0
var time_turn = 0.5

func _ready() -> void:
	$AnimatedSprite2D.play("walk")


func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	get_direction()
	$AnimatedSprite2D.flip_h = direction > 0
	velocity.y += 10
	time_turn += delta
	move_and_slide()


func get_direction():
	if (not $left.is_colliding() or not $right.is_colliding()) and time_turn > 0.5:
		direction *= -1
		time_turn = 0.0
		print(direction)
