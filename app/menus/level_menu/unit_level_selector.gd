extends VBoxContainer
var unit_theme:String
var levels_ids:Array = []
var unlocked_levels:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_level_layout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _level_layout():
	$UnitLabel.text = unit_theme
	var button_scene = preload("res://app/common/components/level_button.tscn")
	var i = 0 #contador solo para posicionar los botones de manera dinamica
	for id in levels_ids:
		var new_button = button_scene.instantiate()
		new_button.id_hold = id
		if i%2==0: 
			new_button.ratio_right=0.1
			new_button.set_ratios()
		if unlocked_levels > 0:
			new_button.locked =  false
			unlocked_levels -=1
		else:
			new_button.locked = true
		$LevelContainer.add_child(new_button)
		$LevelContainer.add_child(HSeparator.new())
		i+=1

func set_unlocked_levels(unlocked:int):
	unlocked_levels = unlocked
