extends Area2D

const SPEED = 0.2
const TILE_SIZE = 16

onready var ray = $RayCast2D
onready var tween = $Tween
onready var sprite = $AnimatedSprite
onready var timer = $ResetTimer
onready var fade = $FadeSprite
onready var fade_tween = $FadeSprite/FadeTween
onready var text_tween = $ResetText/Label/TextTween
onready var inputs = {"walk_up": Vector2.UP, "walk_down": Vector2.DOWN, "walk_left": Vector2.LEFT, "walk_right": Vector2.RIGHT}

signal pause_emit
signal text_time
signal win
signal fire_up
signal fire_down

func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE/2

func _physics_process(delta):	
	if Input.is_action_pressed("walk_up"):
		sprite.set_frame(0)
		timer.stop()
	elif Input.is_action_pressed("walk_down"):
		sprite.set_frame(1)
		timer.stop()
	elif Input.is_action_pressed("walk_left"):
		sprite.set_frame(2)
		timer.stop()
	elif Input.is_action_pressed("walk_right"):
		sprite.set_frame(3)
		timer.stop()
	else:
		if timer.is_stopped() == false:
			return
		else:
			if Globals.safe == false:
				timer.start(1)
	
	if tween.is_active():
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * TILE_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(dir)

func move_tween(dir):
	tween.interpolate_property(self, "position", position, position + inputs[dir] * TILE_SIZE, SPEED, Tween.TRANS_LINEAR)
	tween.start()

func _on_ResetTimer_timeout():
	timer.stop()
	Globals.safe = true
	fade()

func _on_Player_body_entered(body):
	if body.is_in_group("safespace"):
		Globals.safe = false
		emit_signal("fire_down")
	else:
		Globals.safe = true

func _on_Player_body_exited(body):
	if body.is_in_group("safespace"):
		Globals.safe = true
		emit_signal("fire_up")
		if position.y < 0:
			win()

func fade():
	emit_signal("pause_emit")
	fade_tween.interpolate_property(fade, "modulate", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR)
	fade_tween.start()
	
	yield(get_tree().create_timer(1), "timeout")
	
	emit_signal("text_time")
	
	yield(get_tree().create_timer(3), "timeout")
	
	position = Vector2(424, 1368)
	fade_tween.interpolate_property(fade, "modulate", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1, Tween.TRANS_LINEAR)
	fade_tween.start()

func win():
	emit_signal("win")
	
	fade.play("winfade")
	fade_tween.interpolate_property(fade, "modulate", Color(0, 0, 0, 0), Color(1, 1, 1, 1), 2, Tween.TRANS_LINEAR)
	fade_tween.start()
	
	yield(get_tree().create_timer(5), "timeout")
	
	get_tree().quit()
