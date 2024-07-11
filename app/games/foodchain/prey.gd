extends Control
var preyname:String
var mouse_on_prey:bool = false
signal prey_clicked(preyname)

func _input(event):
	if (event is InputEventMouseButton && event.pressed && mouse_on_prey):
		prey_clicked.emit(preyname)

func _on_prey_click_area_mouse_entered():
	mouse_on_prey = true

func _on_prey_click_area_mouse_exited():
	mouse_on_prey = false
