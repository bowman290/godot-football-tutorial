class_name BallCarriedState
extends BallState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

const OFFSET_FROM_PLAYER := Vector2(10,4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	ball.position = carrier.position + Vector2(carrier.heading.x * OFFSET_FROM_PLAYER.x, carrier.heading.y * OFFSET_FROM_PLAYER.y )
	
	

	if carrier.velocity == Vector2.ZERO:
		animation_ball.play('idle')
	else:
		if carrier.heading == Vector2.LEFT:
			animation_ball.play_backwards('moving')
		else:
			animation_ball.play('moving')
		
