@tool
extends Node3D

@export var page: MeshInstance3D

var last_pos: Vector3

func _process(_delta) -> void:
	if global_position == last_pos:
		return

	var material: ShaderMaterial = page.get_surface_override_material(0) as ShaderMaterial

	var uv_pos: Vector2 = Vector2.ZERO
	uv_pos.x = clamp(remap(global_position.x, -1, 1, 0, 1), 0, 1)
	uv_pos.y = clamp(remap(global_position.z, -1, 1, 0, 1), 0, 1)

	last_pos = global_position
	material.set_shader_parameter("mouse_pos", uv_pos)
