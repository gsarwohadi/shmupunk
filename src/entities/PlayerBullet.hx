package entities;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.ShmupEntity;

class PlayerBullet extends ShmupEntity
{
	private var velocityY:Int;
	private var damage:Int;

	public function new()
	{
		super();
	}

	public override function setup(actor:Actor):Void
	{
		super.setup(actor);

		type = "AllyBullet";
		collidable = true;
		setHitbox(16, 16, 8, 8);

		velocityY = -12;
		damage = 1;
		image = new Image("graphics/laserGreen11.png");
		image.centerOrigin();
		image.scale = 0.5;
		graphic = image;

		//HXP.console.log(["[!] Created PlayerBullet!", x, y]);
	}

	public override function update()
	{
		super.update();
		moveBy(0, velocityY);
		pos.x = Shmup.i.screenX + ((Shmup.i.screenX > 0)? x - Shmup.i.screenWidth : x);
		pos.y = Shmup.i.screenY + ((Shmup.i.screenY > 0)? y - Shmup.i.screenHeight : y);

		var collide:ShmupEntity = cast collide("Enemy", x, y);
		if ( collide != null )
		{
			HXP.console.log(["Collide with Enemy!"]);
			collide.shield -= damage;
			scene.recycle(this);
		}

		//HXP.console.log([" >> PlayerBullet", pos.x, pos.y, x, y]);
		if ( !Shmup.isIn(pos, 10) )
		{
			//HXP.console.log(["    > Recycle PlayerBullet!"]);
			scene.recycle(this);
		}
	}
}