extends HBoxContainer
var course_id:int=0
signal course_pressed(course_id)

func _on_button_pressed():
	course_pressed.emit(course_id)
