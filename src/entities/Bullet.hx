package entities;

import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;

import com.haxepunk.graphics.Image;

class Bullet extends ShmupEntity
{
	public function new()
	{
		super();
	}
	
	public override function setup(actor:Actor):Void
	{
		super.setup(actor);
		
		image = new Image("graphics/laserBlue01.png");
		image.centerOrigin();
		image.scale = 0.5;
		
		graphic = image;
	}
}