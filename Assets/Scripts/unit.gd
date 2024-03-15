class_name Unit
extends CharacterBody2D

@export_group("Stats")
@export var _health: int = 100
@export var _damage: int = 20

@export_group("Attack")
@export var _move_speed: float = 50
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


func take_damage(damage: int) -> void:
	_health -= damage
	if (_health <= 0):
		queue_free()


func _try_attack_target() -> void:
	var current_time = Time.get_unix_time_from_system()
	if(current_time - _last_attack > _attack_rate):
		_target.take_damage(_damage)
		_last_attack = current_time


func set_target(new_target: Unit) -> void:
	_target = new_target


func move_to_location(location: Vector2) -> void:
	_target = null
	_agent.target_position = location
