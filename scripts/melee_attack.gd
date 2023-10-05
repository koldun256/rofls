extends Area2D

var damage = 10
@export var duration = 0.15
var time_to_live = duration
@onready var sprite = get_node("sprite")
func _ready():
	get_parent().remove_child(self)
func set_direction(direction):
	sprite.flip_h = direction == -1

func _physics_process(delta):
	time_to_live -= delta
	if time_to_live <= 0:
		get_parent().remove_child(self)
func _enter_tree():
	time_to_live = duration
func _on_body_entered(body):
	if body.has_node('health'):
		if body != get_parent():
			body.get_node('health').take_damage(damage)
