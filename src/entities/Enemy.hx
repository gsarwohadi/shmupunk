package entities;

import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;

import com.haxepunk.graphics.Image;

class Enemy extends ShmupEntity
{
	public function new()
	{
		super();
	}
	
	public override function setup(actor:Actor):Void
	{
		super.setup(actor);
		
		if (actor.name.substr(0, 3) == "big")
		{
			image = new Image("graphics/enemyBlack5.png");
			shield = 50;
			size.x = 90;
			size.y = 60;
		}
		else if (actor.name.substr(0, 3) == "mid")
		{
			image = new Image("graphics/enemyBlack3.png");
			shield = 10;
			size.x = 60;
			size.y = 45;
		}
		else
		{
			image = new Image("graphics/enemyBlack1.png");
			size.v = 30;
		}
		image.centerOrigin();
		image.scale = 0.5;
		
		graphic = image;
	}
}