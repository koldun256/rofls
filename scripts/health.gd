class_name Health extends Node

@export var max_hp = 100
@export var current_hp = max_hp

signal death(lethal_amage)
signal damage_taken(amount)
signal healed(amount)

func take_damage(damage):
	current_hp -= damage
	if current_hp <= 0:
		current_hp = 0
		death.emit(damage)
	else:
		damage_taken.emit(damage)

func oneshot():
	take_damage(current_hp)

func heal(amount):
	current_hp = min(max_hp, current_hp + amount)
	healed.emit(amount)

func fully_heal():
	heal(max_hp - current_hp)
