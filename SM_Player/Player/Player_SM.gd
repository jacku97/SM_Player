class_name Player
extends KinematicBody

#STAT VARIABLES



#ON READIES#
onready var move_states = $Legs/Moving_Manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	move_states.input(event)

func _physics_process(delta: float) -> void:
	move_states.physics_process(delta)

func _process(delta: float) -> void:
	move_states.process(delta)
	

