extends CanvasLayer
@onready var color_rect = $disolve_rect
@onready var tip_text = $TipText
var current_game_parameters

func _ready():
	color_rect.visible = false


func change_scene(target:String):
	color_rect.visible = true
	$AnimationPlayer.play('disolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('disolve')

func load_scene(path_to_scene:String,parameters:Dictionary,tip:String):
	color_rect.visible = true
	current_game_parameters = parameters
	$AnimationPlayer.play('disolve')
	$TipText.text = tip
	await get_tree().create_timer(5).timeout
	get_tree().current_scene.queue_free()
	var new_game = load(path_to_scene).instantiate()
	if !parameters.is_empty():
		new_game.setup(parameters)
	get_tree().root.add_child(new_game)
	get_tree().current_scene = new_game
	$AnimationPlayer.play_backwards('disolve')
