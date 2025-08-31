class_name PlayerStateTackling
extends PlayerState

const DURATION_TACKLE := 200
const GROUND_FRICTION := 250.0

var time_start_tackle := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("tackle")
	time_start_tackle = Time.get_ticks_msec()

func _process(delta: float) -> void:
	player.velocity = player.velocity.move_toward(Vector2.ZERO, delta * GROUND_FRICTION)
	if Time.get_ticks_msec() - time_start_tackle > DURATION_TACKLE:
		start_recovery()
		
func start_recovery():
	await get_tree().create_timer(0.2).timeout
	state_transition_requested.emit(Player.State.RECOVERING)
