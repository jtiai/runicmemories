extends HBoxContainer

const VALUES = ["EASY", "MEDIUM", "HARD",]
const FOCUS_SOUND = preload("res://assets/213148__complex_waveform__click.wav")

@onready var value = $Value

var selected_value: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value.text = VALUES[selected_value]


func _on_left_button_pressed() -> void:
	selected_value = wrapi(selected_value - 1, 0, 3)
	value.text = VALUES[selected_value]
	AudioManager.play_sound(FOCUS_SOUND)


func _on_right_button_pressed() -> void:
	selected_value = wrapi(selected_value + 1, 0, 3)
	value.text = VALUES[selected_value]
	AudioManager.play_sound(FOCUS_SOUND)


func _on_button_focus_or_mouse_entered() -> void:
	AudioManager.play_sound(FOCUS_SOUND)
