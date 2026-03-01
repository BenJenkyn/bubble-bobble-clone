extends CanvasLayer

@onready var score := $Score
@onready var hearts := $HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = "Score: " + str(GameManager.score)
	update_hearts()

func update_hearts() -> void:
	var current_lives = GameManager.lives
	
	for i in range(hearts.get_child_count()):
		var heart = hearts.get_child(i)
		heart.visible = i < current_lives
