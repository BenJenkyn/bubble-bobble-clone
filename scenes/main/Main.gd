extends Node2D

enum MenuState { TITLE, GAME, PAUSE, GAME_OVER }
var menu_state: MenuState = MenuState.TITLE

func _ready():
	set_menu_state(MenuState.TITLE)

func set_menu_state(state: MenuState):
	menu_state = state
	match menu_state:
		MenuState.TITLE:
			$TitleScreen.visible = true
			$Level1.visible = false
			$CanvasLayer.visible = false
		MenuState.GAME:
			$TitleScreen.visible = false
			$Level1.visible = true
			$CanvasLayer.visible = false
		MenuState.PAUSE:
			$CanvasLayer.visible = true
			# Show pause UI, hide gameplay
		MenuState.GAME_OVER:
			$CanvasLayer.visible = true
			# Show game over UI

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if menu_state == MenuState.TITLE:
			set_menu_state(MenuState.GAME)
		elif menu_state == MenuState.GAME_OVER:
			set_menu_state(MenuState.TITLE)
		elif menu_state == MenuState.PAUSE:
			set_menu_state(MenuState.GAME)
	elif event.is_action_pressed("ui_cancel"):
		if menu_state == MenuState.GAME:
			set_menu_state(MenuState.PAUSE)
		elif menu_state == MenuState.PAUSE:
			set_menu_state(MenuState.GAME)
