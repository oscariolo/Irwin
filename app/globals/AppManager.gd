extends Node
var loaded_course_id:= 0
var loaded_level:=0
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
	if success:
		AppDb.unlock_next_level_from(loaded_course_id)

func load_game(id):
	#building the game
	var level_info = AppDb.get_level_info(loaded_course_id,id)
	match int(level_info.game_type):
		FOODCHAIN:
			const path_to_game = "res://app/games/foodchain/FoodChainGame.tscn"
			SceneTransition.load_scene(path_to_game,level_info.parameters,"Escoje la presa que le corresponde!!")
		QUIZ:
			print("quiz")
		_:
			print("juego no reconocido")
	
