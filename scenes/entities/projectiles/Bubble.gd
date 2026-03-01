extends Area2D

const HORIZONTAL_SPEED = 700
const VERTICAL_SPEED = 300

var dir: int
var float_up = false
var trapped_enemy: Node = null
@onready var horizontal_timer = $HorizontalTimer
@onready var despawn_timer = $DespawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("bubbles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if horizontal_timer.is_stopped():
		float_up = true
		
	if float_up:
		position.y -= VERTICAL_SPEED * delta
	else:
		position.x += dir * HORIZONTAL_SPEED * delta 
	
	if despawn_timer.is_stopped():
		queue_free()
	
	if trapped_enemy != null:
		trapped_enemy.global_position = global_position

func trap_enemy(enemy: Node2D):

	trapped_enemy = enemy
	enemy.trap()
	
	float_up = true
	
func pop():
	if(trapped_enemy == null):
		GameManager.increase_score(10)
	else:
		trapped_enemy.queue_free()
		GameManager.increase_score(1000)
		
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		pop()
	
	if(trapped_enemy != null):
		return
		
	if(body.is_in_group("enemies")):
		trap_enemy(body)
		
