class_name BallCarriedState
extends BallState

# Base offset when ball is closest to player
const MIN_OFFSET_FROM_PLAYER := Vector2(8, 3)
# Maximum offset when ball is furthest from player
const MAX_OFFSET_FROM_PLAYER := Vector2(14, 6)

# How fast the dribbling oscillation occurs (higher = faster dribble)
const DRIBBLE_FREQUENCY := 4.0

# Accumulated time for sine wave calculation
var time_accumulated: float = 0.0

# Option to sync dribble speed with movement (set to false for constant dribbling)
const SYNC_WITH_MOVEMENT := true

# Minimum speed threshold to trigger dribbling animation
const MIN_DRIBBLE_SPEED := 20.0


func _ready() -> void:
	# Initialize time with random offset so players don't dribble in sync
	time_accumulated = randf() * TAU


func _process(delta: float) -> void:
	# Update accumulated time for dribbling oscillation
	var dribble_speed_multiplier := 1.0

	if SYNC_WITH_MOVEMENT and carrier.velocity != Vector2.ZERO:
		# Scale dribble frequency based on movement speed for more realistic effect
		var speed := carrier.velocity.length()
		dribble_speed_multiplier = clamp(speed / 100.0, 0.5, 2.0)

	time_accumulated += delta * DRIBBLE_FREQUENCY * dribble_speed_multiplier

	# Calculate dribbling offset using sine wave
	# Using sin gives smooth acceleration/deceleration at extremes
	var dribble_factor := (sin(time_accumulated) + 1.0) / 2.0  # Normalized to 0-1 range

	# Apply easing for more natural feel (optional - try with/without)
	dribble_factor = ease(dribble_factor, -0.5)  # Ease in-out for smoother motion

	# Interpolate between min and max offset based on dribble factor
	var current_offset := MIN_OFFSET_FROM_PLAYER.lerp(MAX_OFFSET_FROM_PLAYER, dribble_factor)

	# Apply offset based on carrier heading
	var directional_offset := Vector2(
		carrier.heading.x * current_offset.x,
		carrier.heading.y * current_offset.y
	)

	# When stationary, gradually move ball to resting position (min offset)
	if carrier.velocity == Vector2.ZERO:
		# Slow down the oscillation when idle
		time_accumulated += delta * DRIBBLE_FREQUENCY * 0.3
		current_offset = MIN_OFFSET_FROM_PLAYER
		directional_offset = Vector2(
			carrier.heading.x * current_offset.x,
			carrier.heading.y * current_offset.y
		)

	ball.position = carrier.position + directional_offset

	# Handle ball animations
	if carrier.velocity == Vector2.ZERO:
		animation_ball.play('idle')
	else:
		if carrier.heading == Vector2.LEFT:
			animation_ball.play_backwards('moving')
		else:
			animation_ball.play('moving')
		
