class_name BallCarriedState
extends BallState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ball.position = ball.carried.position
	animation_ball.play('moving')
