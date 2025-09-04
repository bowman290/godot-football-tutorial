class_name Ball
extends AnimatableBody2D

enum State {CARRIED, FREE_FORM, SHOT}

var carried : Player = null
var current_state : BallState = null
var state_factory := BallStateFactory.new()
var velocity := Vector2.ZERO

@onready var animation_sprite : AnimatedSprite2D = %AnimatedSprite2D
@onready var player_detection_area : Area2D = $PlayerDetectionArea

func switch_state(state:State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, player_detection_area, carried, animation_sprite)
	current_state.state_transition_requested.connect(switch_state.bind())
	call_deferred("add_child", current_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_state(State.FREE_FORM)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
