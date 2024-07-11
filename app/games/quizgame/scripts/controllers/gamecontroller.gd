extends Node

@export var color_rigth: Color
@export var color_wrong: Color
var quiz: QuizTheme

var buttons: Array[Button]
var index: int
var correct: int

var play_count = 0
var max_plays = 3

var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

@onready var question_texts = $Control/QuestionInfo/QuestionText
@onready var question_image = $Control/QuestionInfo/ImageHolder/QuestionImage
@onready var question_video = $Control/QuestionInfo/ImageHolder/QuestionVideo
@onready var question_audio = $Control/QuestionInfo/ImageHolder/QuestionAudio

func _ready() -> void:
	for button in $Control/QuestionInfo/QuestionHolder.get_children():
		buttons.append(button)
	
	question_video.connect("finished", _on_video_finished)
	question_audio.connect("finished", _on_audio_finished)
	correct = 0
	quiz.theme.shuffle()
	load_quiz()


func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return
	
	question_texts.text = current_quiz.question_info
	
	current_quiz.options.shuffle()
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
	
	match current_quiz.type:
		Enum.QuestionType.TEXT:
			$Control/QuestionInfo/ImageHolder.hide()
		Enum.QuestionType.IMAGE:
			$Control/QuestionInfo/ImageHolder.show()
			question_image.texture = current_quiz.question_image
		Enum.QuestionType.VIDEO:
			$Control/QuestionInfo/ImageHolder.show()
			question_video.stream = current_quiz.question_video
			question_video.play()
		Enum.QuestionType.AUDIO:
			$Control/QuestionInfo/ImageHolder.show()
			question_image.texture = current_quiz.question_image
			question_audio.stream = current_quiz.question_audio
			question_audio.play()

func _buttons_answer(button) -> void:
	if current_quiz.correct == button.text:
		button.modulate = color_rigth
		correct += 1
		$AudioCorrect.play()
	else:
		button.modulate = color_wrong
		$AudioIncorrect.play()
	
	_next_question()

func _next_question() -> void:
	for button in buttons:
		button.pressed.disconnect(_buttons_answer)
		
	await  get_tree().create_timer(1).timeout
	
	for button in buttons:
		button.modulate = Color.WHITE
	
	question_audio.stop()
	question_audio.stream = null
	question_video.stop()
	question_video.stream = null
	
	index += 1
	
	load_quiz()

func _game_over() -> void:
	$Control/GameOver.show()
	$Control/GameOver/Score.text = str(correct, "/", quiz.theme.size())

func _on_video_finished():
	play_count += 1
	if play_count < max_plays:
		question_video.play()
	else:
		question_video.play()
		question_video.paused = true
		play_count = 0

func _on_audio_finished():
	play_count += 1
	if play_count < max_plays:
		question_audio.play()
	else:
		play_count = 0

func _on_button_pressed():
	pass

func _exit_tree():
	question_video.disconnect("finished", _on_video_finished)
	question_audio.disconnect("finished", _on_audio_finished)

func setup(questions: Dictionary):
	var list_questions = []
	for question in questions:
		
		var question_info = question.get("question_info", "")
		var type = Enum.QuestionType[question.get("type", "Text")]

		var image_path = "res://app/games/quizgame/media_quiz/{0}/".format(question.get("question_image", ""))
		if image_path != "res://app/games/quizgame/media_quiz//":
			question_image = load(image_path)

		var audio_path = "res://app/games/quizgame/media_quiz/{0}/".format(question.get("question_audio", ""))
		if audio_path != "res://app/games/quizgame/media_quiz//":
			question_audio = load(audio_path)

		var video_path = "res://app/games/quizgame/media_quiz/{0}/".format(question.get("question_video", ""))
		if video_path != "res://app/games/quizgame/media_quiz//":
			question_video = load(video_path)

		var options = question.get("options", [])
		var correctanswer = question.get("correct", "")
		
		var quizquestion = QuizQuestion.new(question_info, type, question_image, question_audio, question_video, options, correctanswer)
		list_questions.append(quizquestion)
	
	quiz.load_quizs(list_questions)
