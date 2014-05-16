package com.haxepunk.shmup;

import com.haxepunk.HXP;
import com.haxepunk.shmup.util.Xy;

using Math;

class Actor
{
	/*private static var shmup:Shmup;
	private static var baseSpeed:Float;
	
	public static function initialize(_shmup:Shmup)
	{
		shmup = _shmup;
		baseSpeed = _shmup.baseSpeed;
	}
	
	public static function add(name:String, args:Array<Float> = null, parent:Actor = null):Actor
	{
		HXP.console.log(["Adding Actor", name, "Parent:", parent]);
		var actor = new Actor(name, args, parent);
		shmup.add(actor);
		return actor;
	}*/
	
	public var name:String;
	public var type:ActorType;
	public var xVar:Variable;
	public var yVar:Variable;
	public var angleVar:Variable;
	public var speedVar:Variable;
	public var vars:Map<String, Variable>;
	public var ticks:Int;
	public var parent:Actor;
	public var children:Array<Actor>;
	
	public var exists(get_exists, null):Bool;
	
	private var baseSpeed:Float = 0.01;
	private var waitTicks = 0;
	private var waitCond:Expression = null;
	private var scopeStates:Array<ScopeState>;
	private var currentState:ScopeState;
	private var dynamicValues:Map<String, Float>;
	private var isRemoving = false;
	private var wasInScreen = false;
	private var sPos:Xy;
	private var shmup(default, null):Shmup;
	
	public function new(name:String, args:Array<Float> = null, parent:Actor = null)
	{
		//HXP.console.log(["Pre new Actor", name, Command.s.toString(), parent]);
		var command = Command.s.get(name);
		//if (command == null)
		//	throw "FUNCTION " + name + " doesn't exist";
		
		if ( command != null )
		{
			//HXP.console.log(["Got command", command.toString(), command.args]);
			//HXP.console.log(["Command actor:", command.actorType]);
			
			this.name = name;
			vars = new Map<String, Variable>();
			var ai = 0;
			for (a in command.args)
			{
				var v = addVar(a.getAsName());
				//HXP.console.log(["Actor. +Var", a.getAsName()]);
				if (args != null && ai < args.length) 
					v.value = args[ai];
				ai++;
			}
			
			type = command.actorType;
			xVar = addVar("@x");
			yVar = addVar("@y");
			angleVar = addVar("@angle");
			speedVar = addVar("@speed");
			scopeStates = new Array<ScopeState>();
			children = new Array<Actor>();
			dynamicValues = new Map<String, Float>();
			
			this.parent = parent;
			if (parent == null) 
			{
				xVar.value = 0.5;
				yVar.value = 0.2;
			}
			else
			{
				xVar.value = parent.xVar.value;
				yVar.value = parent.yVar.value;
			}
			angleVar.value = 0;
			speedVar.value = 0;
			currentState = new ScopeState(this, command);
		}
		
		if (parent != null)
			parent.children.push(this);
		
		shmup = Shmup.i;
	}
	
	public function update():Bool
	{
		//HXP.console.log(["update Actor", name, type]);
		for (v in vars)
			v.update(this);
		
		var x = xVar.value;
		var y = yVar.value;
		var angle = angleVar.value * Math.PI / 180;
		var speed = speedVar.value;
		
		//HXP.console.log(["Actor", x, y, angleVar.value, speed]);
		
		if (speed != 0)
		{
			x += angle.sin() * speed * baseSpeed;
			y += angle.cos() * speed * baseSpeed;
			xVar.value = x;
			yVar.value = y;
		}
		
		//HXP.console.log([" >", name, type, x, y, angle, speed]);
		
		if (type == Enemy || type == Turret || type == Bullet)
		{
			if (x > -0.1 && x < 1.1 && y > -0.1 && y < 1.1)
				wasInScreen = true;
			else
			{
				if (wasInScreen)
					remove();
			}
		}
		
		var commandCount = 0;
		while (true)
		{
			//HXP.console.log([waitCond, currentState.actor.name]);
			
			if (waitCond != null)
			{
				if (waitCond.calc(this) == 0)
					break;
				else
					waitCond = null;
			}
			
			if (currentState == null ||	waitTicks > 0) 
				break;
			
			currentState.update();
			
			if (++commandCount > 1000) 
				throw "execute too many commands at a frame";
		}
		
		if (isRemoving)
		{
			if (type == Enemy)
			{
				removeChildTurret();
			}
			//HXP.console.log(["Actor update isRemoving, return false!"]);
			return false;
		}
		ticks++;
		waitTicks--;
		
		return true;
	}
	
	public function addVar(name:String):Variable
	{
		var v = new Variable(name);
		vars.set(name, v);
		return v;
	}
	
	public function pushScopeState(state:ScopeState):Void
	{
		scopeStates.push(currentState);
		currentState = state;
	}
	
	public function popScopeState():Void
	{
		currentState = scopeStates.pop();
	}
	
	public function setWaitTicks(v:Int):Void
	{
		waitTicks = v;
	}
	
	public function setWaitCond(cond:Expression):Void
	{
		waitCond = cond;
	}
	
	public function vanish(actorName:String = null):Void
	{
		//HXP.console.log(["[Actor] vanish", actorName]);
		if (actorName == null)
		{
			remove();
		}
		else
		{
			for (ca in children)
			{
				if (ca.name == actorName)
					ca.remove();
			}
		}
	}
	
	public function remove():Void
	{
		isRemoving = true;
		//HXP.console.log(["[Actor] isRemoving", isRemoving]);
	}
	
	public function notify(actorName:String = null):Void
	{
		if (actorName == null)
		{
			if (parent != null)
				parent.notifyThis();
			return;
		}
		for (ca in children)
		{
			if (ca.name == actorName)
				ca.notifyThis();
		}
	}
	
	public function notifyThis():Void
	{
		waitTicks = 0;
		waitCond = null;
	}
	
	public function getReadOnlyVariableValue(name:String):Float
	{
		//HXP.console.log(["[Actor] getReadOnlyVariableValue", name]);
		//HXP.console.log([shmup]);
		switch (name)
		{
			case "$playerX", "$px":
				//return shmup.playerX / (shmup.screenX + shmup.screenWidth);
				return shmup.playerX / shmup.screenWidth;
				
			case "$playerY", "$py":
				//return shmup.playerY / (shmup.screenY + shmup.screenHeight);
				return shmup.playerY / shmup.screenHeight;
				
			case "$enemyCount", "$ec":
				return shmup.enemyCount;
				
			case "$angleToPlayer", "$atp":
				//HXP.console.log([shmup.playerX, shmup.playerY]);
				//var px = shmup.playerX / (shmup.screenX + shmup.screenWidth);
				var px = shmup.playerX / shmup.screenWidth;
				//var py = shmup.playerY / (shmup.screenY + shmup.screenHeight);
				var py = shmup.playerY / shmup.screenHeight;
				HXP.console.log([shmup.playerX, shmup.playerY, px, py]);
				return Math.atan2(px - xVar.value, py - yVar.value) * 180 / Math.PI;
				
			case "$distanceToPlayer", "$dtp":
				var ox = shmup.playerX - xVar.value * shmup.screenWidth;
				var oy = shmup.playerY - yVar.value * shmup.screenHeight;
				return Math.sqrt(ox * ox + oy * oy) / Math.min(shmup.screenWidth, shmup.screenHeight);
				
			case "$ticks", "$t":
				return ticks;
				
			case "$parentX", "$prx":
				if (parent == null)
					throw "parent doesn't exist";
				return parent.xVar.value;
				
			case "$parentY", "$pry":
				if (parent == null)
					throw "parent doesn't exist";
				return parent.yVar.value;
				
			case "$infinity", "$inf":
				return 9999999;
				
			default:
				throw "invalid READ_ONLY_VARIABLE: " + name;
		}
	}
	
	function removeChildTurret():Void
	{
		for (c in children)
		{
			if (c.type == ActorType.Turret)
				c.remove();
		}
	}
	
	function get_exists():Bool
	{
		return !isRemoving;
	}
}

enum ActorType 
{
	None;
	Stage;
	Enemy;
	Turret;
	Bullet;
	Ally;
	AllyBullet;
}