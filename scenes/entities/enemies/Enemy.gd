extends CharacterBody2D

enum State {
	ACTIVE,
	TRAPPED
}

@export var speed: float = 80.0
@export var gravity: float = 900.0
var state: State = State.ACTIVE
@onready var collision = $CollisionShape2D

var direction: int = -1  # start moving left

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	if state == State.TRAPPED:
		velocity.y = 300
		collision.disabled = true
		return
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal movement
	velocity.x = direction * speed

	move_and_slide()

	# If we hit a wall, turn around
	if is_on_wall():
		direction *= -1
		$Sprite2D.flip_h = direction > 0
		
func trap():
	state = State.TRAPPED
	velocity = Vector2.ZERO
	
