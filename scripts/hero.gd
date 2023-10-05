extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_health_death(lethal_amage):
	queue_free()
	print('gg tima rakov, ya livaю')
