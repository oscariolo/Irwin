extends Resource
class_name QuizQuestion

@export var question_info: String
@export var type: Enum.QuestionType
@export var question_image: Texture2D
@export var question_audio: AudioStream
@export var question_video: VideoStream
@export var options: Array[String]
@export var correct: String

func _init(question_info, type, question_image, question_audio, question_video, options, correct):
	self.question_info = question_info
	self.type = type
	self.question_image = question_image
	self.question_audio = question_audio
	self.question_video = question_video
	self.options = options
	self.correct = correct
	
