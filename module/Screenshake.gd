extends Node

onready var tween = $Tween
onready var frequencyTimer = $FrequencyTimer
onready var durationTimer = $DurationTimer

onready var camera = get_parent()

var priority = 0
var intensity
var frequency
var duration


func start(intensity_, frequency_, duration_, priority_ = 0):
	if priority_ >= priority:
		priority = priority_
		intensity = intensity_
		frequency = frequency_
		duration = duration_

		durationTimer.wait_time = duration
		frequencyTimer.wait_time = 1.0 / frequency
		durationTimer.start()
		frequencyTimer.start()

		shake()


func shake():
	var shakeAmt = Vector2(
		rand_range(-intensity, intensity),
		rand_range(-intensity, intensity)
	)

	tween.interpolate_property(
		camera, "offset", camera.offset, shakeAmt, frequencyTimer.wait_time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.start()


func reset():
	tween.interpolate_property(
		camera, "offset", camera.offset, Vector2.ZERO, frequencyTimer.wait_time,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.start()
	priority = 0


func _on_FrequencyTimer_timeout():
	shake()


func _on_DurationTimer_timeout():
	reset()
	frequencyTimer.stop()
