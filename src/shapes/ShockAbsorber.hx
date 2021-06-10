package shapes;

import src.DtsObject;

class ShockAbsorber extends PowerUp {
	public function new() {
		super();
		this.dtsPath = "data/shapes/items/shockabsorber.dts";
		this.isCollideable = false;
		this.isTSStatic = false;
		this.identifier = "ShockAbsorber";
		this.pickUpName = "Shock Absorber PowerUp";
	}

	public function pickUp():Bool {
		return this.level.pickUpPowerUp(this);
	}

	public function use(time:Float) {
		var marble = this.level.marble;
		marble.enableShockAbsorber(time);
		// marble.body.addLinearVelocity(this.level.currentUp.scale(20)); // Simply add to vertical velocity
		// if (!this.level.rewinding)
		//	AudioManager.play(this.sounds[1]);
		// this.level.particles.createEmitter(superJumpParticleOptions, null, () => Util.vecOimoToThree(marble.body.getPosition()));
		this.level.deselectPowerUp();
	}
}
