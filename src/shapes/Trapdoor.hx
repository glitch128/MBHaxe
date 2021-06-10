package shapes;

import collision.CollisionInfo;
import src.Util;
import src.DtsObject;
import h3d.Vector;
import src.ForceObject;

class Trapdoor extends DtsObject {
	var lastContactTime = -1e8;
	var timeout:Float = 0;
	var lastDirection:Float;
	var lastCompletion:Float = 0;

	public function new() {
		super();
		this.dtsPath = "data/shapes/hazards/trapdoor.dts";
		this.isCollideable = true;
		this.isTSStatic = false;
		this.identifier = "Trapdoor";
		this.hasNonVisualSequences = true;
	}

	public override function update(currentTime:Float, dt:Float) {
		var currentCompletion = this.getCurrentCompletion(currentTime);

		// Override the keyframe
		this.sequenceKeyframeOverride.set(this.dts.sequences[0], currentCompletion * (this.dts.sequences[0].numKeyFrames - 1));
		super.update(currentTime, dt);

		var diff = (currentCompletion - this.lastCompletion);
		var direction = 0;
		if (diff > 0)
			direction = 1;
		if (diff < 0)
			direction = -1;
		if (direction != 0 && direction != this.lastDirection) {
			// If the direction has changed, play the sound
			// AudioManager.play(this.sounds[0], 1, AudioManager.soundGain, this.worldPosition);
		}

		this.lastCompletion = currentCompletion;
		this.lastDirection = direction;
	}

	function getCurrentCompletion(time:Float) {
		var elapsed = time - this.lastContactTime;
		var completion = Util.clamp(elapsed / 1.6666676998138428, 0, 1);
		if (elapsed > 5)
			completion = Util.clamp(1 - (elapsed - 5) / 1.6666676998138428, 0, 1);
		return completion;
	}

	override function onMarbleContact(time:Float, ?contact:CollisionInfo) {
		super.onMarbleContact(this.level.currentTime, contact);
		if (this.level.currentTime - this.lastContactTime <= 0)
			return; // The trapdoor is queued to open, so don't do anything.
		var currentCompletion = this.getCurrentCompletion(this.level.currentTime);

		// Set the last contact time accordingly so that the trapdoor starts closing (again)
		this.lastContactTime = this.level.currentTime - currentCompletion * 1.6666676998138428;
		if (currentCompletion == 0)
			this.lastContactTime += this.timeout;

		// this.level.replay.recordMarbleContact(this);
	}
}
