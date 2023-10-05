extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = get_node("sprite")
@onready var attack_node = get_node("attack")
@export var selected_texture: Texture2D
@export var unselected_texture: Texture2D
var facing_direction = 1
var controllable = false
func _ready():
	get_parent().change_control.connect(handle_connect)

func handle_connect(creep):
	controllable = creep == self
	if not controllable:
		velocity.x = 0
	sprite.texture = selected_texture if controllable else unselected_texture

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	set_sprite_direction()
	if controllable:
		if Input.is_action_just_pressed("attack"):
			attack()
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("left", "right")
		if direction > 0:
			facing_direction = 1
		if direction < 0:
			facing_direction = -1
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = 0

	move_and_slide()

func attack():
	attack_node.position = Vector2.RIGHT * 10 * facing_direction
	attack_node.set_direction(facing_direction)
	attack_node.set_process(true)
	add_child(attack_node)


func set_sprite_direction():
	sprite.flip_h = facing_direction == 1

func _on_health_death(lethal_amage):
	queue_free()
