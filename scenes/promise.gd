extends Node

static func await_any_signal(promises):
	assert(len(promises) % 2 == 0)

	var emitter = _Emitter.new()
	for i in range(0, len(promises), 2):
		var object = promises[i]
		var signal_name = promises[i + 1]
		object.connect(signal_name, emitter, "emit")

	yield(emitter, "emitted")


static func await_all_signals(promises):
	assert(len(promises) % 2 == 0)

	var emitter = _Emitter.new()
	for i in range(0, len(promises), 2):
		var object = promises[i]
		var signal_name = promises[i + 1]
		object.connect(signal_name, emitter, "emit")

	#warning-ignore:unused_variable
	for i in range(0, len(promises), 2):
		yield(emitter, "emitted")


static func await_any(promises):
	var emitter = _Emitter.new()
	for i in range(0, len(promises)):
		var object = promises[i]
		object.connect("completed", emitter, "emit")

	yield(emitter, "emitted")


static func await_all(promises):
	var emitter = _Emitter.new()
	for i in range(0, len(promises)):
		var object = promises[i]
		object.connect("completed", emitter, "emit")

	#warning-ignore:unused_variable
	for i in range(0, len(promises)):
		yield(emitter, "emitted")


class _Emitter:
	signal emitted
	func emit():
		emit_signal("emitted")
