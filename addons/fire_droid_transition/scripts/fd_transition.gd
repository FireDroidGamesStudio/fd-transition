@tool
class_name FDTransition
extends Node


## Emitted when the transition start (by calling [method play], [method play_in] or [method play_out]).
signal started
## Emitted when a step finish (after calling [method play_in] or [method play_out]).
signal step_finished
## Emitted when the full cycle of transition finish (after calling [method play]).
signal finished


# Setup
@export_group("Setup")
@export_range(0.0, 5.0, 0.1, "or_greater") var duration_in: float = 2.0
@export var ease_in: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var trans_in: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export_range(0.0, 5.0, 0.1, "or_greater") var duration_out: float = 2.0
@export var ease_out: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var trans_out: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR

# Delay
@export_group("Delay")
@export_range(0.0, 5.0, 0.1, "or_greater") var in_pre_delay: float = 0.0
@export_range(0.0, 5.0, 0.1, "or_greater") var in_post_delay: float = 0.0
@export_range(0.0, 5.0, 0.1, "or_greater") var out_pre_delay: float = 0.0
@export_range(0.0, 5.0, 0.1, "or_greater") var out_post_delay: float = 0.0

# Preview
@export_tool_button("Preview In") var _preview_in_button = play_in


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func play_in(callback: Callable = func(): return) -> Variant:
	if not is_zero_approx(in_pre_delay):
		await get_tree().create_timer(in_pre_delay).timeout
	await _on_play_in()
	var result: Variant = await callback.call()
	if not is_zero_approx(in_post_delay):
		await get_tree().create_timer(in_post_delay).timeout
	step_finished.emit()
	return result


func play_out(callback: Callable = func(): return) -> Variant:
	if not is_zero_approx(out_pre_delay):
		await get_tree().create_timer(out_pre_delay).timeout
	await _on_play_out()
	var result: Variant = await callback.call()
	if not is_zero_approx(out_post_delay):
		await get_tree().create_timer(out_post_delay).timeout
	step_finished.emit()
	return result


# Overridable
func _on_play_in() -> void:
	pass


# Overridable
func _on_play_out() -> void:
	pass
