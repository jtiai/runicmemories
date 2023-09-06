class_name Card
extends MarginContainer

const FLIP_SOUND = preload("res://assets/240776__f4ngy__card-flip.wav")

signal card_clicked(card)

@export var face_up: bool = true
@export var value: int = -1
@export var text: String = "?":
	get:
		return text
	set(_txt):
		text = _txt
		if is_inside_tree():
			label.text = _txt

@onready var background = $Background
@onready var foreground = $Foreground
@onready var label = $CenterContainer/Label

func _ready() -> void:
	label.text = text
	flip_immediate()

func flip_over() -> void:
	AudioManager.play_sound(FLIP_SOUND)
	# Flip with animations
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale:x", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(switch_face)
	tween.tween_property(self, "scale:x", 1, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)

func switch_face() -> void:
	background.visible = not face_up
	foreground.visible = face_up
	label.visible = face_up

func flip_immediate() -> void:
	# Flip immediately
	scale.x = 1
	switch_face()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		card_clicked.emit(self)
