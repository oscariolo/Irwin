extends CanvasLayer
@onready var color_rect = $disolve_rect
@onready var tip_text = $TipText
var scene_load_status = 0
var sceneName
var current_game_parameters

func _ready():
	color_rect.visible = false


func change_scene(target:String):
	color_rect.visible = true
	$AnimationPlayer.play('disolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('disolve')

func load_scene(path_to_game:String,parameters:Dictionary,tip:String):
	ResourceLoader.load_threaded_request(path_to_game)
	color_rect.visible = true
	current_game_parameters = parameters
	$AnimationPlayer.play('disolve')
	$TipText.text = tip
	#await $AnimationPlayer.animation_finished
	await get_tree().create_timer(5).timeout
	var new_game = load(path_to_game).instantiate()
	new_game.setup(parameters)
	
	get_tree().change_scene_to_packed(new_game)
	$AnimationPlayer.play_backwards('disolve')

#const path_to_game = "res://app/games/foodchain/FoodChainGame.tscn"
			#var new_game = preload(path_to_game).instantiate()
			#new_game.setup(level_info.parameters)
			#var last_scene = get_tree().current_scene
			#await SceneTransition.load_scene_play("")
			#get_tree().root.add_child(new_game)
			#last_scene.queue_free()
