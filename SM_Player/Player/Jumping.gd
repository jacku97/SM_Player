extends MoveState

export (float) var jump_force = 5

func physics_process(delta: float) -> BaseState:
	
	snap = Vector3.ZERO
	gravity_vec = Vector3.UP * jump_force
	
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	player.move_and_slide_with_snap(movement, snap, Vector3.UP)
	
	if Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("sprint"):
			return sprinting_state
		return walking_state
	elif player.linear_velocity.y < 0: return falling_state
	
	return null
