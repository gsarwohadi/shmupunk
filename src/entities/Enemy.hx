package entities;

import com.haxepunk.HXP;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.Shmup;
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
		
		type = "Enemy";
		collidable = true;
		setHitbox(16, 16, 8, 8);

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
			shield = 1;
			size.v = 30;
		}
		image.centerOrigin();
		image.scale = 0.5;
		
		graphic = image;
	}

	public override function update()
	{
		super.update();

		//var collides:Array<ShmupEntity> = new Array<ShmupEntity>();
		//collideInto("AllyBullet", x, y, collides);
		//HXP.console.log(["Check collide", collides.length]);
		//if ( collides != null && collides.length > 0 )
		//{
		//	HXP.console.log(["Collide with AllyBullet!"]);
		//}

		//var collide:ShmupEntity = cast collide("AllyBullet", x, y);
		//if ( collide != null )
		//{
		//	HXP.console.log(["Collide with AllyBullet!"]);
		//}

		if ( shield <= 0 )
		{
			destroy();
			scene.recycle(this);
		}
	}
}