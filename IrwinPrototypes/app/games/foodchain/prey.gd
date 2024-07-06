extends Control
var preyname:String
var mouse_on_prey:bool
signal prey_clicked(preyname)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event is InputEventMouseButton && event.pressed && mouse_on_prey):
		prey_clicked.emit(preyname)

func _on_prey_click_area_mouse_entered():
	mouse_on_prey = true

func _on_prey_click_area_mouse_exited():
	mouse_on_prey = false
