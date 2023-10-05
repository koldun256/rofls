extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = get_node("sprite")
@onready var hurtbox = get_node("hurtbox")
var attack_scene = preload("res://scenes/melee_attack.tscn")
var facing_direction = 1
var controllable = false
func _ready():
	get_parent().change_control.connect(handle_connect)

func handle_connect(creep):
	controllable = creep == self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	set_sprite_direction()
	if controllable:
		if Input.is_action_just_pressed("attack"):
			attack()
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction > 0:
			facing_direction = 1
		if direction < 0:
			facing_direction = -1
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func attack():
	var attack_instance = attack_scene.instantiate()
	add_child(attack_instance)
	attack_instance.position = Vector2.RIGHT * 10 * facing_direction
	attack_instance.set_direction(facing_direction)


func set_sprite_direction():
	sprite.flip_h = facing_direction == 1

func _on_health_death(lethal_amage):
	queue_free()
