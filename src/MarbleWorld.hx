package src;

import src.DtsObject;
import src.PathedInterior;
import hxd.Key;
import h3d.Vector;
import src.InteriorGeometry;
import h3d.scene.Scene;
import h3d.scene.CustomObject;
import collision.CollisionWorld;
import src.Marble;

class MarbleWorld {
	var collisionWorld:CollisionWorld;

	public var interiors:Array<InteriorGeometry> = [];
	public var pathedInteriors:Array<PathedInterior> = [];
	public var marbles:Array<Marble> = [];
	public var dtsObjects:Array<DtsObject> = [];

	public var currentTime:Float = 0;

	var scene:Scene;

	public function new(scene:Scene) {
		this.collisionWorld = new CollisionWorld();
		this.scene = scene;
	}

	public function addInterior(obj:InteriorGeometry) {
		this.interiors.push(obj);
		this.collisionWorld.addEntity(obj.collider);
		this.scene.addChild(obj);
	}

	public function addPathedInterior(obj:PathedInterior) {
		this.pathedInteriors.push(obj);
		this.collisionWorld.addMovingEntity(obj.collider);
		this.scene.addChild(obj);
		obj.init();
	}

	public function addDtsObject(obj:DtsObject) {
		this.dtsObjects.push(obj);
		this.scene.addChild(obj);
		obj.init();
		for (collider in obj.colliders) {
			if (collider != null)
				this.collisionWorld.addEntity(collider);
		}
	}

	public function addMarble(marble:Marble) {
		this.marbles.push(marble);
		marble.level = cast this;
		if (marble.controllable) {
			this.scene.addChild(marble.camera);
		}
		this.collisionWorld.addMovingEntity(marble.collider);
		this.scene.addChild(marble);
	}

	public function update(dt:Float) {
		for (obj in dtsObjects) {
			obj.update(currentTime, dt);
		}
		for (marble in marbles) {
			marble.update(currentTime, dt, collisionWorld, this.pathedInteriors);
		}
		currentTime += dt;
	}
}
