extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if AppManager.loaded_course_id!=0:
		$CourseManager.load_levels(AppManager.loaded_course_id)	
	$MainScreen/UpMenu/PlayerBar/UserInfo/Points.text = str(AppManager.global_points)
	


func _load_courses():
	pass


func _on_config_button_pressed():
	print("config pressed")


func _on_notification_button_pressed():
	print("notif pressed")


func _on_cursos_button_pressed():
	$CourseManager.load_courses()
