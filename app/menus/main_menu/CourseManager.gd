extends Node
# Called when the node enters the scene tree for the first time.
func _ready():
	load_courses()


func load_courses(): #load from DB the contents of the course per theme
	clear_scroll()
	var courses = AppDb.load_courses_from_database() as Array[Course]
	var course_component = preload("res://app/common/components/custom_button_course.tscn")
	for course in courses:
		var new_course_comp = course_component.instantiate()
		new_course_comp.course_id = course.course_id
		new_course_comp.get_child(2).text = course.course_name
		get_node("%Course_Level_Container").add_child(new_course_comp)
		new_course_comp.connect("course_pressed",load_levels)

func load_levels(course_pressed:int):
	clear_scroll()
	AppManager.loaded_course_id = course_pressed
	var unit_levels = AppDb.get_levels_id_by_unit(course_pressed) as Dictionary #tengo el diccionario de todos los ids de los cursos por tema
	var unlocked = AppDb.get_user_level_unlocks(course_pressed) #cantidad de niveles desbloqueados
	
	var unit_component = preload("res://app/menus/level_menu/unit_level_selector.tscn")
	for unit in unit_levels.keys(): #creacion de cada componente por unidad
		var new_unit_component = unit_component.instantiate()
		new_unit_component.levels_ids = unit_levels.get(unit) #asignacion de ids para los botones
		new_unit_component.unit_theme = unit 
		if unlocked >=0:
			new_unit_component.set_unlocked_levels(unlocked)
		unlocked -= len(unit_levels.get(unit))
		get_node("%Course_Level_Container").add_child(new_unit_component)
	
	for button in get_tree().get_nodes_in_group("LevelButton"):
		button.connect("level_clicked",load_level_game)

func clear_scroll():
	for child in get_node("%Course_Level_Container").get_children():
		child.queue_free()

func load_level_game(level_id:int):
	AppManager.load_game(level_id)



