extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -800.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = get_node("Sprite2D")
var controllable = false
func _ready():
	(get_parent() as CreepManager).change_control.connect(handle_connect)

func handle_connect(creep):
	controllable = creep == self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if controllable:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction > 0:
			sprite.flip_h = true
		if direction < 0:
			sprite.flip_h = false
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
