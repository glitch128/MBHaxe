package;

import shapes.Tornado;
import shapes.DuctFan;
import dts.DtsFile;
import src.InteriorGeometry;
import h3d.Quat;
import src.PathedInteriorMarker;
import src.PathedInterior;
import src.MarbleWorld;
import collision.CollisionWorld;
import src.Marble;
import src.DifBuilder;
import h3d.Vector;
import h3d.scene.fwd.DirLight;
import h3d.mat.Material;
import h3d.prim.Cube;
import h3d.scene.*;
import src.DtsObject;

class Main extends hxd.App {
	var scene:Scene;

	var world:MarbleWorld;
	var dtsObj:DtsObject;

	override function init() {
		super.init();

		dtsObj = new Tornado();

		world = new MarbleWorld(s3d);

		var db = new InteriorGeometry();
		DifBuilder.loadDif("data/interiors/beginner/training_friction.dif", db);
		world.addInterior(db);
		var tform = db.getTransform();
		tform.setPosition(new Vector(0, 0, 7.5));
		db.setTransform(tform);

		// var pi = new PathedInterior();
		// DifBuilder.loadDif("data/interiors/addon/smallplatform.dif", loader, pi);
		// var pim = pi.getTransform();
		// pim.setPosition(new Vector(5, 0, 0));
		// pi.setTransform(pim);

		// var cube = new Cube();
		// cube.addUVs();
		// cube.addNormals();
		// var mat = Material.create();

		// var m1 = new PathedInteriorMarker();
		// m1.msToNext = 5;
		// m1.position = new Vector(0, 0, 0);
		// m1.smoothingType = "";
		// m1.rotation = new Quat();

		// var m2 = new PathedInteriorMarker();
		// m2.msToNext = 3;
		// m2.position = new Vector(0, 0, 5);
		// m2.smoothingType = "";
		// m2.rotation = new Quat();

		// var m3 = new PathedInteriorMarker();
		// m3.msToNext = 5;
		// m3.position = new Vector(0, 0, 0);
		// m3.smoothingType = "";
		// m3.rotation = new Quat();

		// pi.markerData = [m1, m2, m3];

		// world.addPathedInterior(pi);

		world.addDtsObject(dtsObj);

		// for (surf in db.collider.surfaces) {
		// 	var surfmin = new CustomObject(cube, mat, s3d);
		// 	var bound = surf.boundingBox;
		// 	surfmin.setPosition(bound.xMin, bound.yMin, bound.zMin);

		// 	var surfmax = new CustomObject(cube, mat, s3d);
		// 	surfmax.setPosition(bound.xMax, bound.yMax, bound.zMax);
		// }

		// var mat = Material.create();
		// var so = new CustomObject(cube, mat);
		// so.setPosition(0, 0, 0);
		// s3d.addChild(so);

		var dirlight = new DirLight(new Vector(0.5, 0.5, -0.5), s3d);
		dirlight.enableSpecular = true;
		s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);

		// s3d.camera.

		var marble = new Marble();
		marble.controllable = true;
		world.addMarble(marble);
		marble.setPosition(5, 0, 5);

		// var marble2 = new Marble();
		// world.addMarble(marble2);
		// marble2.setPosition(5, 0, 5);
		// marble.setPosition(-10, -5, 5);
	}

	override function update(dt:Float) {
		super.update(dt);
		world.update(dt);
	}

	static function main() {
		new Main();
	}
}
