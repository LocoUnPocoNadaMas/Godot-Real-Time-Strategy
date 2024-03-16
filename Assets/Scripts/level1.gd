class_name Level1
extends Node2D


var selected_unit: Unit
var selected_group: Array[Player]
var enemies: Array[Enemy]


func _input(event):
	if(event is InputEventMouseButton && event.is_pressed()):
		if(event.button_index == MOUSE_BUTTON_LEFT):
			_try_select_unit()
		elif(event.button_index == MOUSE_BUTTON_MASK_RIGHT):
			_try_command_unit()


func _try_select_unit():
	var unit = _get_selected_unit()
	if(unit && unit is Unit):
		_select_unit(unit)
	else:
		_unselect_unit()


func _get_selected_unit():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection = space.intersect_point(query, 1)
	
	if(!intersection.is_empty()):
		return intersection[0].collider
	return null


func _select_unit(unit: Unit):
	_unselect_unit()
	selected_unit = unit
	if(unit._is_player):
		selected_unit.toggle_visual_selection(true)


func _unselect_unit():
	if(selected_unit && selected_unit._is_player):
		selected_unit.toggle_visual_selection(false)
	selected_unit = null


func _try_command_unit():
	if(!selected_unit):
		return
	var target = _get_selected_unit()
	if(target && !target._is_player):
		selected_unit._set_target(target)
	else:
		selected_unit.move_to_location(get_global_mouse_position())


