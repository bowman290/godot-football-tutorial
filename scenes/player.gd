class_name Player
extends CharacterBody2D

enum ControlScheme {CPU, P1, P2}

@export var control_scheme : ControlScheme;
@export var speed : float = 50
@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var player_sprite : Sprite2D = %PlayerSprite
var heading := Vector2.RIGHT

func _process(delta: float) -> void:
	
	if control_scheme == ControlScheme.CPU:
		pass
	else:
		handle_human_movement()
	set_heading()
	flip_sprites()
	set_movement_animation()
	
func set_movement_animation() -> void:
	#if velocity not 0, change the anim
	if velocity.length() > 0: 
		animation_player.play("run")
	else:
		animation_player.play("idle")
		
	#check the velocity to set run direction
	
func set_heading():
	if velocity.x < 0:
		heading = Vector2.LEFT
	elif velocity.x > 0:
		heading = Vector2.RIGHT
		
func flip_sprites():
	if heading == Vector2.LEFT:
		player_sprite.flip_h = true
	elif heading == Vector2.RIGHT:
		player_sprite.flip_h = false
		
		
		
func handle_human_movement() -> void:
	var direction := KeyUtils.get_input_vector(control_scheme)
		
	velocity = direction * speed
	move_and_slide()
