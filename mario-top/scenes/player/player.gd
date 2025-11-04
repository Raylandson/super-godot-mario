extends CharacterBody2D

class_name Player

enum states {idle, walk}

const TILE_SIZE = 16
var actual_state = states.idle
var max_speed = 6 * TILE_SIZE
var accel = 50.0
var opposite_accel = 100.0
var friction = 100.0
var gravity = 10.0
var jump_height = 5 * TILE_SIZE
var jump_velocity = sqrt(2*gravity*jump_height)
var gravity_scale = 1.0

func _physics_process(delta: float) -> void:
	match actual_state:
		states.idle:
			%SpriteAnim.play("idle")
			velocity.x = max(abs(velocity.x) - friction, 0) * sign(velocity.x)
			if get_direction() != 0.0:
				actual_state = states.walk
			check_jump(delta)
		states.walk:
			%SpriteAnim.play("walk")
			check_jump(delta)
			var direction = get_direction()
			var opposite_direction = direction != sign(velocity.x)
			if opposite_direction:
				velocity.x += opposite_accel * direction
			else:
				velocity.x += accel * direction
			velocity.x = clamp(velocity.x,-max_speed, max_speed)
			if get_direction() == 0.0:
				actual_state = states.idle
	flip_nodes()
	if velocity.y > 0 or not Input.is_action_pressed("jump"):
		gravity_scale = 2.0
	else:
		gravity_scale = 1.0
	velocity.y += gravity * gravity_scale
	move_and_slide()


func check_jump(delta):
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= jump_velocity * sqrt(1/delta)
	pass


func get_direction():
	return (Input.get_action_strength("right") - Input.get_action_strength("left"))


func flip_nodes():
	if get_direction() != 0:
		%SpriteAnim.flip_h = get_direction() > 0
