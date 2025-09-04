class_name Player
extends CharacterBody2D

enum ControlScheme {CPU, P1, P2}
enum State {IDLE, MOVING, TACKLING, SHOOTING, RECOVERING}

@export var control_scheme : ControlScheme;
@export var speed : float = 50

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@onready var player_sprite : Sprite2D = %PlayerSprite

var current_state: PlayerState = null
var heading := Vector2.RIGHT
var state_factory := PlayerStateFactory.new()

const ANIMATIONS_MAP : Dictionary = {
	"IDLE":"idle",
	"RUN":"run",
	"TACKLE":"tackle",
	"RECOVER":"recover"
}

func _ready() -> void:
	switch_state(State.MOVING)

func _process(_delta: float) -> void:
	flip_sprites()
	move_and_slide()
	
func switch_state(state:State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_state.bind())
	current_state.name = "PlayerStateMachine: " + str(state)
	call_deferred("add_child", current_state)
	
func set_movement_animation() -> void:
	#if velocity not 0, change the anim
	if velocity.length() > 0: 
		animation_player.play(ANIMATIONS_MAP.RUN)
	else:
		animation_player.play(ANIMATIONS_MAP.IDLE)
		
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
		
		
		
