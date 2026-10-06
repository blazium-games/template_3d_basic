extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var rig_eye: Camera3D = $RigEye
@onready var deck_mesh: MeshInstance3D = $Deck/DeckMesh
@onready var walker: CharacterBody3D = $Walker
@onready var gate_mark: Node3D = $GateMark

func _ready() -> void:
	rules.spare_energy = 1.2
	if not rules.second_lamp(rules.spare_energy):
		push_error("Basic 3D second light is off.")
	if not rules.slab_ready(deck_mesh.mesh != null) or not rules.eye_current(rig_eye.current):
		push_error("Basic 3D rig is incomplete.")

func _physics_process(_delta: float) -> void:
	var wish := Vector2(
		Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west"),
		Input.get_action_strength("stride_south") - Input.get_action_strength("stride_north")
	)
	walker.velocity.x = wish.x * 3.0
	walker.velocity.z = wish.y * 3.0
	if not walker.is_on_floor():
		walker.velocity.y -= 12.0 * _delta
	walker.move_and_slide()
	var gap := walker.global_position.distance_to(gate_mark.global_position)
	if rules.may_annex(gap):
		_go("res://scenes/annex.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
