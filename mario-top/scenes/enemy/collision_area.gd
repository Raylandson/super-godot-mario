extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	var player_direc = global_position.direction_to(body.global_position)
	print(player_direc.dot(Vector2.UP))
	if body is Player:
		if player_direc.dot(Vector2.UP) > 0.5:
			self.queue_free()
		else:
			get_tree().reload_current_scene()
	pass # Replace with function body.
