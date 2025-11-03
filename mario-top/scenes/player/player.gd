extends CharacterBody2D

enum states {idle, walk}

const TILE_SIZE = 16
var actual_state = states.idle
var max_speed = 6 * TILE_SIZE
var accel = 50.0
var opposite_accel = 100.0
var friction = 100.0
var gravity = 10.0

func _physics_process(delta: float) -> void:
	match actual_state:
		states.idle:
			velocity.x = max(abs(velocity.x) - friction, 0) * sign(velocity.x)
			if get_direction() != 0.0:
				actual_state = states.walk
			check_jump()
		states.walk:
			check_jump()
			var direction = get_direction()
			var opposite_direction = direction != sign(velocity.x)
			if opposite_direction:
				velocity.x += opposite_accel * direction
			else:
				velocity.x += accel * direction
			velocity.x = clamp(velocity.x,-max_speed, max_speed)
			if get_direction() == 0.0:
				actual_state = states.idle
	
	velocity.y += gravity
	move_and_slide()


func check_jump():
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y -= 500
	pass


func get_direction():
	return (Input.get_action_strength("right") - Input.get_action_strength("left"))
