extends Sprite

var player = preload("res://Scenes/Player.tscn")

func _ready():
	get_node("../Player").connect("pause_emit", self, "pause_emit")

func pause_emit():
	$Particles2D.emitting = false
	
	yield(get_tree().create_timer(4), "timeout")
	
	$Particles2D.emitting = true
