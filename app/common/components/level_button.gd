extends HBoxContainer
@export var ratio_left:=0.0
@export var ratio_right:=0.0
signal level_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_ratios():
	$LeftSpacing.size_flags_stretch_ratio = ratio_left
	$RightSpacing.size_flags_stretch_ratio = ratio_right


func _on_level_button_pressed():
	level_clicked.emit()

