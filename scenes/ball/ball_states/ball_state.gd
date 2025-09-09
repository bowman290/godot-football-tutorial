class_name BallState
extends Node

signal state_transition_requested(new_state: Ball.State)

var animation_ball: AnimatedSprite2D = null
var ball : Ball = null
var carrier : Player = null
var player_detection_area: Area2D = null

func setup(context_ball:Ball, context_player_detection_area:Area2D, context_carrier:Player,  context_animation_ball:AnimatedSprite2D) -> void:
	ball = context_ball
	carrier = context_carrier
	animation_ball = context_animation_ball
	player_detection_area = context_player_detection_area
	
