package com.haxepunk.shmup;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.util.Random;
import com.haxepunk.shmup.util.Xy;

class Shmup
{
	public static var i:Shmup;
	
	public var baseSpeed = 0.01;
	
	public var screenX:Float;
	public var screenY:Float;
	public var screenWidth:Float;
	public var screenHeight:Float;
	public var mode:ShmupMode;
	
	public var playerX = 160.0;
	public var playerY = 240.0;
	
	public var enemyCount(get_enemyCount, null):Int;
	public var entities:Array<ShmupEntity>;
	
	private var EnemyClass:Class<ShmupEntity>;
	private var BulletClass:Class<ShmupEntity>;
	private var TurretClass:Class<ShmupEntity>;
	private var AllyClass:Class<ShmupEntity>;
	private var AllyBulletClass:Class<ShmupEntity>;
	
	private var scene:Scene;
	
	public function new(x:Float, y:Float, width:Float, height:Float, scene:Scene, ?mode:ShmupMode = ShumpMode.Vertical)
	{
		screenX = x;
		screenY = y;
		screenWidth = width;
		screenHeight = height;
		
		this.scene = scene;
		this.mode = mode;
		
		entities = new Array<ShmupEntity>();
		
		// static singleton?
		i = this;
	}
	
	public function setEntity(type:ActorType, entityClass:Class<ShmupEntity>):Void
	{
		//HXP.console.log(["Shmup set entity", type]);
		
		switch (type)
		{
			case Enemy:
				EnemyClass = entityClass;
			case Bullet:
				BulletClass = entityClass;
			case Turret:
				TurretClass = entityClass;
			case Ally:
				AllyClass = entityClass;
			case AllyBullet:
				AllyBulletClass = entityClass;
			default:
				
		}
	}
	
	private function getClass(type:ActorType):Class<ShmupEntity>
	{
		switch(type)
		{
			case Enemy:
				return EnemyClass;
			case Bullet:
				return BulletClass;
			case Turret:
				return TurretClass;
			case Ally:
				return AllyClass;
			case AllyBullet:
				return AllyBulletClass;
			default:
				return ShmupEntity;
		}
		return ShmupEntity;
	}
	
	public function create(name:String, args:Array<Float> = null, parent:Actor = null):Void
	{
		//HXP.console.log(["[SHMUP] Create Actor", name, "Parent: ", parent]);
		//HXP.console.log(["[SHMUP] >> Args:", args]);
		var actor:Actor = new Actor(name, args, parent);
		
		var EntityClass:Class<ShmupEntity> = getClass(actor.type);
		if ( EntityClass != null )
		{
			//HXP.console.log([" [SHMUP] > ", actor.name]);
			var shmupEntity = scene.create(EntityClass, true);
			//HXP.console.log([" > ", shmupEntity]);
			shmupEntity.setup(actor);
			entities.push(shmupEntity);
		}
		else
			HXP.console.log(["Entity for actor", actor.type, " is NULL!"]);
	}
	
	public function update():Void
	{
		//HXP.console.log([entities.length]);
		var i = 0;
		while (i < entities.length)
		{
			var entity = entities[i];
			if (entity.updateActor())
				i++;
			else
			{
				//HXP.console.log(["Entity updateActor = false", entity.actor.name]);
				scene.recycle(entity);
				entities.splice(i, 1);
			}
		}
	}

	public function cleanup():Void
	{
		for ( entity in entities )
		{
			scene.recycle(entity);
		}
		entities = [];
	}
	
	public static function isIn(p:Xy, spacing:Float = 0):Bool
	{
		var minX:Float = (-spacing + Shmup.i.screenX);
		var maxX:Float = (Shmup.i.screenX + Shmup.i.screenWidth) + spacing;
		var minY:Float = (-spacing + Shmup.i.screenY);
		var maxY:Float = (Shmup.i.screenY + Shmup.i.screenHeight) + spacing;
		return p.x >= minX && p.x <= maxX && p.y >= minY && p.y <= maxY;
	}
	
	private function get_enemyCount():Int
	{
		var c = 0;
		for (entity in entities)
		{
			if (entity.actor.type == Enemy) 
				c++;
		}
		return c;
	}
}

enum ShmupMode
{
	Horizontal;
	Vertical;
}