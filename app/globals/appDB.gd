extends Node

func chekc_if_unlocked(level_id:int):
	pass

func unlock_next_level_from(course_id:int):
	var file_path = "res://app/localDB/userData.json"
	var json_as_text = FileAccess.get_file_as_string(file_path)
	var user_data = JSON.parse_string(json_as_text)
	var unlocks = user_data.get(AppManager.current_user).courses_progress.get(str(course_id))
	for i in range(len(unlocks)):
		if not unlocks[i]:
			unlocks[i] = true
			break
	
	user_data[AppManager.current_user]["courses_progress"][str(course_id)] = unlocks
	var updated_json_as_text = JSON.stringify(user_data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(updated_json_as_text)
	file.close()
	

func get_user_level_unlocks(course_id:int):
	var file = "res://app/localDB/userData.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var user_data = JSON.parse_string(json_as_text)
	return user_data.get(AppManager.current_user).courses_progress.get(str(course_id))

func load_courses_from_database(): #should load from DB of courses 
	var file = "res://app/localDB/coursesDB.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var courses = JSON.parse_string(json_as_text)
	return courses

func get_levels_id_by_unit(course_id:int): #devuelve los niveles para ese curso por tema (no considera usuario)
	var levels_content:Dictionary = {}
	var courses_json = load_courses_from_database()
	for course in courses_json:
		if course.course_id == course_id: #si es el curso buscado
			for level_info in course.levels: #por cada nivel de ese curso
				if level_info.theme not in levels_content.keys():
					levels_content[level_info.theme] = [level_info.id]
				else:
					levels_content.get(level_info.theme).append(level_info.id)
	return levels_content

func get_level_info(course_id,level_id)-> Dictionary:
	var courses_json = load_courses_from_database()
	for course in courses_json:
		if course.course_id == course_id:
			for level in course.levels:
				if level.id == level_id:
					return level
	return {}
