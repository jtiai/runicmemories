extends CenterContainer

const FOCUS_SOUND = preload("res://assets/213148__complex_waveform__click.wav")

signal start_game(difficulty)

@onready var difficulty_selection = $VBoxContainer/DifficultyContainer/DifficultySpinner


func _on_start_button_pressed() -> void:
	start_game.emit(difficulty_selection.selected_value)


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_button_focus_or_mouse_entered() -> void:
	AudioManager.play_sound(FOCUS_SOUND)
