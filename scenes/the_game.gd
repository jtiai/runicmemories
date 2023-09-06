extends MarginContainer

const PAIR_FOUND = preload("res://assets/337049__shinephoenixstormcrow__320655__rhodesmas__level-up-01.mp3")
const COMPLETED = preload("res://assets/162458__kastenfrosch__gewonnen2.mp3")
const TIMEOUT = preload("res://assets/394900__funwithsound__failure-1.wav")

var flipped_cards: Array[Card]

@onready var main_menu = $MainMenu
@onready var stats = $VBoxContainer/GameStatsContainer
@onready var time_label = $VBoxContainer/GameStatsContainer/HBoxContainer/HBoxContainer/TimeLabel
@onready var score_label = $VBoxContainer/GameStatsContainer/HBoxContainer/HBoxContainer2/ScoreLabel

@onready var ending_container = $CenterContainer
@onready var timeout_label = $CenterContainer/TimeOutLabel
@onready var congrats_label = $CenterContainer/CongratulationsLabel

@onready var board_small = $VBoxContainer/GameAreaSmall
@onready var board_medium = $VBoxContainer/GameAreaMedium
@onready var board_large = $VBoxContainer/GameAreaLarge

@onready var card_grid_small = $VBoxContainer/GameAreaSmall/CenterContainer/GridContainer
@onready var card_grid_medium = $VBoxContainer/GameAreaMedium/CenterContainer/GridContainer
@onready var card_grid_large = $VBoxContainer/GameAreaLarge/CenterContainer/GridContainer


var active_grid = null

var game_running: bool = false
var score: int = 0
var time_left: float = 60

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	main_menu.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not game_running:
		return

	time_left -= delta
	if time_left <= 0:
		# Timed out
		game_timeout()
	else:
		time_label.text = str(roundi(time_left))


func _on_card_clicked(card: Card) -> void:
	if flipped_cards.size() < 2 and not card.face_up:
		flipped_cards.append(card)
		card.face_up = true
		card.flip_over()
		check_pairs()
	elif flipped_cards.size() == 2:
		for flipped_card in flipped_cards:
			flipped_card.face_up = false
			flipped_card.flip_over()

		flipped_cards.clear()


func check_pairs() -> void:
	if flipped_cards.size() < 2:
		return

	if flipped_cards[0].value == flipped_cards[1].value:
		score += roundi(time_left * 1.25)
		score_label.text = str(score)
		flipped_cards.clear()

		# All cards turned?
		var all_done = true
		for card in active_grid.get_children() as Array[Card]:
			if not card.face_up:
				all_done = false
				break

		if all_done:
			game_completed()
		else:
			AudioManager.play_sound(PAIR_FOUND)


func _on_main_menu_start_game(difficulty) -> void:
	main_menu.visible = false
	stats.visible = true
	if difficulty == 0:
		active_grid = card_grid_small
		board_small.visible = true
	elif difficulty == 1:
		active_grid = card_grid_medium
		board_medium.visible = true
	elif difficulty == 2:
		active_grid = card_grid_large
		board_large.visible = true

	start_game()


func start_game() -> void:
	var cards: Array = active_grid.get_children() as Array[Card]
	var num_pairs = cards.size() / 2

	var list = range(1, Cardvaluemap.NUM_CARD_VALUES + 1)
	list.shuffle()
	var pairs = list.slice(0, num_pairs)

	for i in range(0, num_pairs):
		var value = pairs[i]
		cards[i * 2].value = value
		cards[i * 2].text = Cardvaluemap.CARD_VALUE_MAP[value]
		cards[i * 2 + 1].value = value
		cards[i * 2 + 1].text = Cardvaluemap.CARD_VALUE_MAP[value]

	for card in cards:
		active_grid.remove_child(card)

	cards.shuffle()

	for card in cards:
		active_grid.add_child(card)
		if not card.card_clicked.is_connected(_on_card_clicked):
			card.card_clicked.connect(_on_card_clicked)
		card.face_up = false
		card.flip_immediate()

	game_running = true


func game_completed() -> void:
	game_running = false
	AudioManager.play_sound(COMPLETED)
	ending_container.visible = true
	timeout_label.visible = false
	congrats_label.visible = true

	await get_tree().create_timer(10.0).timeout

	reset_game()


func game_timeout() -> void:
	game_running = false
	AudioManager.play_sound(TIMEOUT)
	ending_container.visible = true
	timeout_label.visible = true
	congrats_label.visible = false

	await get_tree().create_timer(10.0).timeout

	reset_game()


func reset_game():
	time_left = 60
	score = 0
	ending_container.visible = false
	timeout_label.visible = false
	congrats_label.visible = false
	stats.visible = false

	active_grid = null

	board_small.visible = false
	board_medium.visible = false
	board_large.visible = false

	main_menu.visible = true

	score_label.text = ""
	time_label.text = ""
