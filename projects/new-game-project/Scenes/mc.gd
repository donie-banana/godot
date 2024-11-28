extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0
const FAST_FALL_GRAVITY_MULTIPLIER = 2.0  # Speed up gravity for fast fall
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var is_fast_falling = false  # Track fast fall state

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if velocity.x == 0:
			sprite_2d.animation = "default"
		else:
			sprite_2d.animation = "run"
		is_fast_falling = false  # Reset fast fall state when grounded
	else:
		if is_fast_falling:
			# Apply a higher gravity multiplier to only the y-component
			velocity.y += get_gravity().y * FAST_FALL_GRAVITY_MULTIPLIER * delta
		else:
			# Apply regular gravity when not fast falling
			velocity += get_gravity() * delta
		sprite_2d.animation = "jump"
	
	# Handle fast fall activation
	if Input.is_action_just_pressed("fast fall") and not is_on_floor():
		is_fast_falling = true
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
	
	move_and_slide()
	
	# Handle sprite flipping
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left
