extends CharacterBody2D

const SPEED_WALK = 4000
const SPEED_RUN  = SPEED_WALK * 2

@onready var sprite = $AnimatedSprite2D
#@export  var inventory: Inventory

enum PlayerState {
	IDLE,
	WALK,
	RUN,
}
enum SpriteFacing {
	UP,
	RIGHT,
	DOWN,
}

# PlayerState, SpriteFacing -> Animation
const ANIMATIONS = [
	[
		StringName("idle_up"   ),
		StringName("idle_right"),
		StringName("idle_down" ),
	],[
		StringName("walk_up"   ),
		StringName("walk_right"),
		StringName("walk_down" ),
	],[
		StringName( "run_up"   ),
		StringName( "run_right"),
		StringName( "run_down" ),
	],
]
var current_state: PlayerState  = PlayerState.IDLE
var sprite_facing: SpriteFacing = SpriteFacing.DOWN

func get_inputs(delta: float) -> void:
	var input_direction = Input.get_vector(
		"Move_Left", "Move_Right",
		"Move_Up",   "Move_Down",
	)
	
	if velocity.is_zero_approx(): # not moving
		current_state = PlayerState.IDLE
	
	var isSprint = Input.is_action_pressed("Sprint")
	velocity = input_direction * (SPEED_RUN if isSprint else SPEED_WALK) * delta

func animate_movement() -> void:
	if velocity.is_zero_approx(): # not moving
		sprite.play(ANIMATIONS[PlayerState.IDLE][sprite_facing])
		return
		
	# Else
	match Directions.Movement.from_vector(velocity):
		"N":
			sprite_facing = SpriteFacing.UP

		"S":
			sprite_facing = SpriteFacing.DOWN

		"NE", "E", "SE":
			sprite_facing = SpriteFacing.RIGHT
			sprite.flip_h = false
			
		"NW", "W", "SW":
			sprite_facing = SpriteFacing.RIGHT
			sprite.flip_h = true
	
	# Then
	sprite.play(ANIMATIONS[PlayerState.WALK if SPEED_RUN else PlayerState.WALK][sprite_facing])

func _physics_process(delta: float) -> void:
	get_inputs(delta)
	animate_movement()
	move_and_slide()

#Inventory Handling
func collect(item):
	pass
	#inventory.insert(item)
