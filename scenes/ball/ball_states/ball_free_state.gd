class_name BallFreeState
extends BallState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_detection_area.body_entered.connect(on_player_enter.bind())
	
func on_player_enter(body:Player) -> void:
	ball.carrier = body
	state_transition_requested.emit(Ball.State.CARRIED)

func _enter_tree() -> void:
	print('enter')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
