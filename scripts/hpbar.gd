extends TextureProgressBar

@onready var health = get_node("../health")

func on_change(bipki):
	set_value_no_signal(health.current_hp as float / health.max_hp)
	print(value)
