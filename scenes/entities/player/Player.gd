extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var bubble_scene = preload("res://scenes/entities/projectiles/Bubble.tscn")
var last_direction := 1

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("fire"):
		shoot(last_direction)

	move_and_slide()

func shoot(direction):
	var bubble = bubble_scene.instantiate()
	bubble.position.y = position.y
	bubble.position.x = position.x + direction * 70
	bubble.dir = direction   # -1 for left, 1 for right
	get_parent().add_child(bubble)
