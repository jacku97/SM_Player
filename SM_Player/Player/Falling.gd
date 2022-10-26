extends MoveState
 

func input(event: InputEvent) -> BaseState:
	var new_state = .input(event)
	if new_state:
		return new_state
	return null

func physics_process(delta: float) -> BaseState:
	if player.is_on_floor():
		return idle_state
	snap = Vector3.DOWN
	accel = ACCEL_AIR
	gravity_vec += Vector3.DOWN * gravity * delta
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	player.move_and_slide_with_snap(movement, snap, Vector3.UP)
	
	
	return null
	
