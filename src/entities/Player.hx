package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;
import com.haxepunk.shmup.util.Xy;

import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import entities.PlayerBullet;

class Player extends ShmupEntity
{
	private var velocityX:Int;
	private var velocityY:Int;
	private var velocityValue:Int;

	private var fireRate:Int;
	private var fireTick:Int;

	public function new()
	{
		super();

		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("fire", [Key.SPACE, Key.L]);

		velocityX = 0;
		velocityY = 0;
		velocityValue = 8;
		fireRate = 6;

		image = new Image("graphics/playerShip1_green.png");
		image.centerOrigin();
		image.scale = 0.5;
		graphic = image;

		setup(null);

		shield = 200;
		size.x = 64;
		size.y = 64;
	}

	private function handleInput()
	{
		velocityX = 0;
		velocityY = 0;
		
		if ( Input.check("left") )
		{
			velocityX = -velocityValue;
		}
		else if ( Input.check("right") )
		{
			velocityX = velocityValue;
		}
		
		if ( Input.check("up") )
		{
			velocityY = -velocityValue;
		}
		else if ( Input.check("down") )
		{
			velocityY = velocityValue;
		}

		if ( Input.check("fire") )
		{
			fireTick++;

			if ( fireTick >= fireRate )
			{
				var bullet:PlayerBullet = scene.create(PlayerBullet, true);
				bullet.setup(null);
				bullet.x = this.x;
				bullet.y = this.y;

				fireTick = 0;

				//HXP.console.log(["FIRE!", scene, bullet.x, bullet.y, bullet.type]);
			}
		}
	}

	public override function update()
	{
		super.update();
		handleInput();
		moveBy(velocityX, velocityY);
		pos.x = (Shmup.i.screenX > 0)? x - Shmup.i.screenWidth : x;
		pos.y = (Shmup.i.screenY > 0)? y - Shmup.i.screenHeight : y;
	}
}