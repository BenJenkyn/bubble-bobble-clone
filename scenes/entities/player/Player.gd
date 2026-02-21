extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var bubble_scene = preload("res://scenes/entities/projectiles/Bubble.tscn")
var last_direction := 1
var is_invulnerable := false
@onready var invulnerability_timer := $InvulnerabilityTimer

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
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("fire"):
		shoot(last_direction)

	if invulnerability_timer.is_stopped() && is_invulnerable:
		is_invulnerable = false

	move_and_slide()
	
	check_enemy_collision()

func shoot(direction):
	var bubble = bubble_scene.instantiate()
	bubble.position.y = position.y
	bubble.position.x = position.x + direction * 70
	bubble.dir = direction   # -1 for left, 1 for right
	get_parent().add_child(bubble)

func check_enemy_collision():
	if is_invulnerable:
		return

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.is_in_group("enemies") and collider.state == collider.State.ACTIVE:
			GameManager.lose_life()
			is_invulnerable = true
			invulnerability_timer.start()
