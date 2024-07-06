extends VBoxContainer
var levels_list: Array[Level]

# Called when the node enters the scene tree for the first time.
func _ready():
	_level_layout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _level_layout():
	var button_scene = preload("res://app/common/components/level_button.tscn")
	for i in 5:
		var new_button = button_scene.instantiate()
		if i%2==0:
			new_button.ratio_right=0.1
			new_button.set_ratios()
		$LevelContainer.add_child(new_button)
		$LevelContainer.add_child(HSeparator.new())
		
