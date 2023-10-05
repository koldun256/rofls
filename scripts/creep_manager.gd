class_name CreepManager extends Node

signal change_control(creep)
@export var creep_scenes: Array[PackedScene]
@export var selected = 0
@onready var creeps = get_children()
func _ready():
	change_control.emit(creeps[0])
func _process(delta):
	for i in range(1,11):
		if Input.is_action_just_pressed("select%d" % i):
			if i > creeps.size():
				print("Cannot select %d" % i)
				return
			change_control.emit(creeps[i - 1])
