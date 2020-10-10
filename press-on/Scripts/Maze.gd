extends Node2D

const STONE = preload("res://Scenes/Waystone.tscn")

onready var reset_text = $Label
onready var text_tween = $Label/TextTween
onready var rng = RandomNumberGenerator.new()


func _ready():
	$Player.connect("text_time", self, "text_fade")
	$Player.connect("win", self, "win_text")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("drop"):
		stone_spawn()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func stone_spawn():
	var stone = STONE.instance()
	
	add_child(stone)
	
	stone.position = $Player.position + Vector2(0, 6)

func text_fade():
	rng.randomize()
	var barks_get = rng.randi_range(0, 18)
	
	reset_text.rect_position = Vector2($Player.position.x - reset_text.rect_size.x / 2, $Player.position.y - reset_text.rect_size.y / 2)
	reset_text.text = Globals.barks[barks_get]
	
	text_tween.interpolate_property(reset_text, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR)
	text_tween.start()
	
	yield(get_tree().create_timer(2), "timeout")
	
	text_tween.interpolate_property(reset_text, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1, Tween.TRANS_LINEAR)
	text_tween.start()

func win_text():
	reset_text.rect_position = Vector2(558, -200)
	print(reset_text.rect_position)
	reset_text.text = "press on"
	
	text_tween.interpolate_property(reset_text, "modulate", Color(1, 1, 1, 0), Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR)
	text_tween.start()
