extends LevelParent



func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

#func _on_house_body_entered(_body):
	#var tween = get_tree().create_tween()
	#tween.set_parallel(true)
	#tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1)
#
#
#func _on_house_body_exited(_body):
	#var tween = get_tree().create_tween()
	#tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 1)
