extends Node2D


export (Texture) var texture setget _set_texture

func _set_texture(value):
	texture = value
	update()

func _draw():
	draw_texture(texture, Ve)draw_circle(


