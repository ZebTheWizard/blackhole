tool extends EditorPlugin

var plugin: EditorInspectorPlugin
var wave

func _enter_tree():
	plugin = load("res://addons/round_editor/InspectorPlugin.gd").new()
	add_custom_type("WaveData", "Node", preload("res://addons/round_editor/Wave.gd"), null)
	
	#wave = preload("res://addons/round_editor/Wave.gd").new()
	#ResourceSaver.save("res://addons/round_editor/Wave.tres", wave)
	
	add_inspector_plugin(plugin)
	print("loaded")

func _exit_tree():
	pass
