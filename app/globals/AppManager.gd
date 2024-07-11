extends Node
var loaded_course_id:= 0
var last_loaded_level:=0
enum {FOODCHAIN=1,QUIZ=2}
var current_user:="User1"
var global_points:=0

func _ready():
	pass

func return_to_menu(points_gained:int=0,success:bool=false):
	var tip = ""
	if !success:
		tip = "NO TE RINDAS PUEDES INTENTARLO DENUEVO"
	else:
		tip = "Bien hecho sigue aprendiendo"
	SceneTransition.load_scene("res://app/menus/main_menu/menu_cursos.tscn",{},tip)
	global_points += points_gained
	print("id_level ", last_loaded_level)
	print("unlocks ", AppDb.get_user_level_unlocks(loaded_course_id))
	if success and AppDb.get_user_level_unlocks(loaded_course_id) == last_loaded_level:
		AppDb.unlock_next_level_from(loaded_course_id)

func load_game(id):
	#building the game
	var level_info = AppDb.get_level_info(loaded_course_id,id)
	last_loaded_level = id
	match int(level_info.game_type):
		FOODCHAIN:
			const path_to_game = "res://app/games/foodchain/FoodChainGame.tscn"
			SceneTransition.load_scene(path_to_game,level_info.parameters,"Escoje la presa que le corresponde!!")
		QUIZ:
			const path_to_game = "res://app/games/quizgame/quizgame.tscn"
			SceneTransition.load_scene(path_to_game,level_info.parameters,"Escoja la opcion correcta")
		_:
			print("juego no reconocido")
	
