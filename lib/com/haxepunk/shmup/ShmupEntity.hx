package com.haxepunk.shmup;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

import com.haxepunk.shmup.util.Xy;

using com.haxepunk.shmup.util.FloatUtil;

class ShmupEntity extends Entity
{
	public var actor:Actor;
	
	public var pos:Xy;
	public var vel:Xy;
	public var size:Xy;
	
	public var angle:Float = 0.0;
	public var rad:Float = 0.0;
	public var speed:Float = 0.0;
	public var radius:Float = -1.0;
	
	private var pPos:Xy;
	private var sVel:Xy;
	private var shield:Int = 1;
	
	private var image:Image;
	
	public function new()
	{
		super();
	}
	
	// override this
	public function setup(actor:Actor):Void
	{
		this.actor = actor;
		
		pos = new Xy();
		vel = new Xy();
		size = new Xy();

		pPos = new Xy();
		sVel = new Xy();
		
		//HXP.console.log([" [!] ShmupEntity created!", actor.name, actor.type]);
	}
	
	public function updateActor():Bool
	{
		//if ( actor != null )
		//{
			if ( !actor.update() )
			{
				//HXP.console.log([" [!] ShmupEntity update return false!", actor.name, actor.type]);
				return false;
			}
			
			pos.x = Shmup.i.screenX + (actor.xVar.value * Shmup.i.screenWidth);
			pos.y = Shmup.i.screenY + (actor.yVar.value * Shmup.i.screenHeight);
			//angle = actor.angleVar.value * Math.PI / 180;
			
			if (actor.type == Bullet)
			{
				
				if (!Shmup.isIn(pos, 10)) 
				{
					//HXP.console.log([" [!] ShmupEntity Bullet beyond screen!"]);
					destroy();
					return false;
				}
				
				//sVel.xy = pos;
				//sVel.decrementBy(pPos);
				
				//var s = sVel.length;
				//var t = actor.ticks;
				//if (t == 2) 
				//{
				//	if (actor.parent.type != Bullet) 
				//	{
						//Particle.add(pos, Color.red.gz.gz, 15, 5, s, 60, angle, 1);
						//fireSe.play();
				//	}
				//}
				//else if (t > 2)
				//{
					//Particle.add(pos, Color.magenta.gz, 5, 1, s, 15, angle + Math.PI, 0);
				//}
				
				//bulletShape.draw(pos, angle);
				
				//if ( entity != null )
				//{
					//var degangle:Float = 180 / Math.PI * angle;
					//HXP.console.log(["Bullet", pos.x, pos.y, actor.angleVar.value]);
					//HXP.console.log([" > Entity", entity.name, entity.x, entity.y]);
					//if (image != null)
					//	image.angle = actor.angleVar.value;
					//x = pos.x;
					//y = pos.y;
					//HXP.console.log([" >> Entity", entity.name, entity.x, entity.y]);
				//}
			}
			
			if ( image != null )
				image.angle = actor.angleVar.value;

			pPos.xy = pos;
			x = pPos.x;
			y = pPos.y;
			
			return true;
		//}
	}

	private function destroy():Void
	{
		//HXP.console.log(["ShmupEntity destroy", actor.name, actor.type]);
		//if (actor.type == Enemy)
		//{
			//Particle.add(pos, Color.red.gz.gz, 20, 20, 10);
			//if (stglActor.name.substr(0, 3) == "big") bigDstSe.play();
			//else if (stglActor.name.substr(0, 3) == "mid") midDstSe.play();
			//else dstSe.play();
		//}
		//else if (actor.type == Bullet)
		//{
			//Particle.add(pos, Color.magenta.gz, 10, 10, 5);
		//}
		
		if ( actor != null && actor.exists )
			actor.vanish();
	}
}