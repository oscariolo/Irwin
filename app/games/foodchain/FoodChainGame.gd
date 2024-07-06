extends GameBase

var game_predator:String
var preys:Array
var current_prey:String
var preys_round:Array = []
var random_wrong_preys:Array = []
@export var dbJson:JSON

func _init(predator:String="fox"):
	self.game_predator = predator

func _ready():
	setup(dbJson.data)
	start_round()


func setup(parameters:Dictionary)->void:
	var food_chain_data = parameters.get("animals",{}) as Dictionary
	preys = food_chain_data.get(game_predator) as Array #get all preys of current predator
	current_prey = preys[randi()%preys.size() - 1] #select a random prey for this round
	random_wrong_preys=food_chain_data.keys().filter(func(p): return not preys.has(p))
	random_wrong_preys.shuffle()
	$Predator/PredatorSprite.set_texture(load("res://app/games/foodchain/assets/{0}/{0}.png".format([game_predator])))
	for preyNode:Control in $Preys.get_children():
		preyNode.connect("prey_clicked",_prey_clicked)
	
func start_round():
	var round_preys = []
	round_preys.append(random_wrong_preys.pop_front())
	round_preys.append(random_wrong_preys.pop_front())
	round_preys.append(current_prey)
	round_preys.shuffle()
	_assign_preys(round_preys)


func _assign_preys(round_preys:Array):
	var texture_path = "res://app/games/foodchain/assets/{0}/{0}.png"
	for preynode in $Preys.get_children():
		var assigned_prey = round_preys.pop_at(0)
		preynode.get_child(0).set_texture(load(texture_path.format([assigned_prey])))
		preynode.preyname = assigned_prey

func _prey_clicked(prey_name:String):
	if prey_name in preys:
		print("tabien")
	else:
		print("tamal")

func _process(delta):
	pass


