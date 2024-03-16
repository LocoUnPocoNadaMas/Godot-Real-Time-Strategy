class_name Player
extends Unit


@onready var visual_sel: Sprite2D = get_node("VisualSelection")


func toggle_visual_selection(toggle: bool) -> void:
	visual_sel.visible = toggle
