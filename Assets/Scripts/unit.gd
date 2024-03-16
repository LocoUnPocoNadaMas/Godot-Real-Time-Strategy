class_name Unit
extends CharacterBody2D

@export_category("Stats")
@export var _health: int = 100
@export var _damage: int = 20

@export_category("Attack")
@export var _move_speed: float = 500
@export var _attack_range: float = 20
@export var _attack_rate: float = 0.5

var _last_attack: float
var _target: Unit
var _agent: NavigationAgent2D
var _sprite: Sprite2D

@export var _is_player: bool

func _ready():
	_agent = get_node("NavigationAgent2D")
	_sprite = get_node("Sprite2D")
	#move_to_location(Vector2(100,0))


func _physics_process(delta):
	_target_check()
	if _agent.is_navigation_finished():
		return
	var dir = global_position.direction_to(_agent.get_next_path_position())
	velocity = dir * _move_speed * delta
	move_and_slide()
	

func take_damage(damage: int) -> void:
	_health -= damage
	if (_health <= 0):
		queue_free()


func _try_attack_target() -> void:
	var current_time = Time.get_unix_time_from_system()
	if(current_time - _last_attack > _attack_rate):
		_target.take_damage(_damage)
		_last_attack = current_time


func _set_target(new_target: Unit) -> void:
	_target = new_target


func move_to_location(location: Vector2) -> void:
	_target = null
	_agent.target_position = location


func _target_check() -> void:
	if(_target != null):
		var dist = global_position.distance_to(_target.global_position)
		if(dist <= _attack_range):
			_agent.target_position = global_position
			_try_attack_target()
		else:
			_agent.target_position = _target.global_position
