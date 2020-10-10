extends AnimatedSprite

func _ready():
	get_node("../../Player").connect("fire_up", self, "bonfire")
	get_node("../../Player").connect("fire_down", self, "unfire")

func bonfire():
	$Light2D/LightTween.stop_all()
	$Light2D/LightTween.reset_all()
	$Light2D/LightTween.interpolate_property($Light2D, "scale", scale, Vector2(2, 2), 4, Tween.TRANS_LINEAR)
	$Light2D/LightTween.start()

func unfire():
	$Light2D/LightTween.stop_all()
	$Light2D/LightTween.reset_all()
	$Light2D/LightTween.interpolate_property($Light2D, "scale", Vector2(2, 2), Vector2(0.25, 0.25), 2, Tween.TRANS_LINEAR)
	$Light2D/LightTween.start()
