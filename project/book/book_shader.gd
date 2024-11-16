@tool
class_name BookShader
extends Node3D

@export var book: MeshInstance3D
@export var mouse: Node3D
@export var pivot: Node3D
@export var sticky1: Node3D
@export var sticky2: Node3D


func _process(_delta: float) -> void:
	var mat: ShaderMaterial = book.get_surface_override_material(0) as ShaderMaterial

	var mouse_pos: Vector2 = get_uv_coords(mouse.global_position)
	var pivot_pos: Vector2 = get_uv_coords(pivot.global_position)
	var sticky_pos1: Vector2 = get_uv_coords(sticky1.global_position)
	var sticky_pos2: Vector2 = get_uv_coords(sticky2.global_position)

	mat.set_shader_parameter("mouse_pos", mouse_pos)
	mat.set_shader_parameter("pivot_pos", pivot_pos)
	mat.set_shader_parameter("sticky_pos1", sticky_pos1)
	mat.set_shader_parameter("sticky_pos2", sticky_pos2)


func get_uv_coords(point: Vector3) -> Vector2:
	var x_pos = remap(point.x, -1, 1, 0, 1)
	var y_pos = remap(point.z, -1, 1, 0, 1)

	return Vector2(x_pos, y_pos)
