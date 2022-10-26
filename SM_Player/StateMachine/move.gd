class_name MoveState
extends BaseState

export (float) var speed = 60
export (NodePath) var idle_node
export (NodePath) var walking_node
export (NodePath) var sprinting_node
export (NodePath) var jumping_node
export (NodePath) var falling_node

onready var idle_state : BaseState = get_node(idle_node)
onready var walking_state : BaseState = get_node(walking_node)
onready var sprinting_state : BaseState = get_node(sprinting_node)
onready var jumping_state : BaseState = get_node(jumping_node)
onready var falling_state : BaseState = get_node(falling_node)


var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

var default_speed = 7
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 9.8




var cam_accel = 40
var mouse_sense = 0.1
var snap

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	if Input.is_action_just_pressed("sprint"):
		direction = Vector3.ZERO
		return sprinting_state
	
	return null

func physics_process(delta: float) -> BaseState:
	#get keyboard input
	
	get_movement_input()
	

	
	#gravity
	if player.is_on_floor():
		snap = -player.get_floor_normal()
		accel = ACCEL_DEFAULT
		gravity_vec = Vector3.ZERO
	else:	
		return falling_state
		
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	player.move_and_slide_with_snap(movement, snap, Vector3.UP)
	return null

func get_movement_input():
	direction = Vector3.ZERO
	var h_rot = player.global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
