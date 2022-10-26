extends MoveState

func enter() -> void:
	.enter()
	

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_backward") or Input.is_action_just_pressed("move_forward") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if Input.is_action_pressed("sprint"):
			return sprinting_state
		return walking_state
	
	if Input.is_action_just_pressed("jump"):
		print_debug("jumped")
		return jumping_state
	return null

func physics_process(delta: float) -> BaseState:
	
	if !player.is_on_floor():
		return falling_state
	return null
