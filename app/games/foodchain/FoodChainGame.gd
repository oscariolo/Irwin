extends GameBase
var game_predator:String
var preys:Array
var current_prey:String
var random_wrong_preys:Array = []
var max_attemps:=5
var points:=0
var max_loops:=5

func _ready():
	start_round()
	$InfoUI/Lives.text = str(max_attemps)
	$InfoUI/Timer.text = str(int($GameTimer.time_left))


func setup(parameters:Dictionary)->void: #setup variables for the current predator
	game_predator = parameters.predator
	preys = parameters.preys as Array #get all preys of current predator
	random_wrong_preys= parameters.random as Array
	random_wrong_preys.shuffle() #random preys in animal data
	if parameters.lives: max_attemps = parameters.lives
	
	$Predator/PredatorSprite.set_texture(load("res://app/games/foodchain/assets/{0}/{0}.png".format([game_predator])))
	for preyNode:Control in $Preys.get_children():
		preyNode.connect("prey_clicked",_prey_clicked)
	
func start_round():
	var round_preys = []
	current_prey = preys[randi()%preys.size() - 1] #select a random prey for this round
	round_preys.append(random_wrong_preys[0])
	round_preys.append(random_wrong_preys[1])
	round_preys.append(current_prey)
	round_preys.shuffle()
	random_wrong_preys.shuffle()
	_assign_preys(round_preys)

func _assign_preys(round_preys:Array):
	var texture_path = "res://app/games/foodchain/assets/{0}/{0}.png"
	for preynode in $Preys.get_children():
		var assigned_prey = round_preys.pop_at(0)
		preynode.get_child(0).set_texture(load(texture_path.format([assigned_prey])))
		if assigned_prey:
			preynode.preyname = assigned_prey


func _prey_clicked(prey_name:String):
	$Animations/ReinforceAnimations.stop()
	if prey_name in preys:
		$Animations/ReinforceAnimations.play("correct")
		$GameTimer.start($GameTimer.time_left + 5)
		points+=1
		max_loops-=1
		start_round()
	else:
		$Animations/ReinforceAnimations.play("wrong")
		max_attemps -= 1
		$InfoUI/Lives.text = str(max_attemps)
	if max_attemps == 0:
		AppManager.return_to_menu()
	if max_loops == 0:
		await $Animations/ReinforceAnimations.animation_finished
		AppManager.return_to_menu(points,true)

func _process(_delta):
	$InfoUI/Timer.text = str(int($GameTimer.time_left))

func _on_game_timer_timeout():
	AppManager.return_to_menu()
