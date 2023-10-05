extends Area2D

var damage = 10
var time_to_live = 0.15
@onready var sprite = get_node("sprite")

func set_direction(direction):
	sprite.flip_h = direction == -1

func _physics_process(delta):
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()

func _on_body_entered(body):
	if body.has_node('health'):
		if body != get_parent():
			body.get_node('health').take_damage(damage)
