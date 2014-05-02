package com.haxepunk.shmup;

import com.haxepunk.HXP;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.Command;

class ScopeState
{
	public var actor:Actor;
	
	private var rootCommand:Command;
	private var programCount = 0;
	private var repeatCount = 1;
	private var whileCond:Expression;
	
	public function new (actor:Actor, rootCommand:Command, repeatCount:Int = 1, whileCond:Expression = null)
	{
		//HXP.console.log(["New ScopeState.", actor.name, rootCommand.name]);
		this.actor = actor;
		this.rootCommand = rootCommand;
		this.repeatCount = repeatCount;
		this.whileCond = whileCond;
	}
	
	public function update():Void
	{
		//HXP.console.log([" > ScopeState update", programCount, rootCommand.children.length]);
		if (programCount >= rootCommand.children.length)
		{
			//HXP.console.log([" >> ", programCount]);
			repeatCount--;
			if (repeatCount > 0 || (whileCond != null && whileCond.calc(actor) == 1))
			{
				programCount = 0;
			}
			else
			{
				//HXP.console.log(["Popping state from actor"]);
				actor.popScopeState();
				return;
			}
		}
		
		var command = rootCommand.children[programCount];
		programCount++;
		
		//HXP.console.log([" >>", programCount, command.name, command.type, command.actorType]);
		
		try
		{
			doCommand(command);
		}
		catch (msg:String)
		{
			var tMsg = msg;
			if (msg.indexOf("l.") != 0)
				tMsg = "l." + command.lineCount + " " + msg + " (" + command.toString() + ")";
			throw tMsg;
		}
	}
	
	function doCommand(command:Command):Void
	{
		//HXP.console.log([">SS cmd:", actor.name, actor.type, command.name, command.type, command.args.toString()]);
		//HXP.console.log([">SS cmd:", command.type, command.name, actor.type]);
		switch (command.type)
		{
			case Repeat:
				var count = 9999999;
				if (command.args.length > 0) count = Std.int(command.args[0].calc(actor));
				actor.pushScopeState(new ScopeState(actor, command, count));
				
			case While:
				var cond:Expression;
				if (command.args.length > 0) cond = command.args[0];
				else cond = Expression.TRUE();
				actor.pushScopeState(new ScopeState(actor, command, 1, cond));
				
			case Wait:
				var count = 9999999;
				if (command.args.length > 0) count = Std.int(command.args[0].calc(actor));
				actor.setWaitTicks(count);
				
			case WaitUntil:
				var cond:Expression;
				if (command.args.length > 0) cond = command.args[0];
				else cond = Expression.FALSE();
				actor.setWaitCond(cond);
				
			case Vanish:
				//HXP.console.log([" >>>SS do Vanish"]);
				var name:String = null;
				if (command.args.length > 0) name = command.args[0].getAsName();
				actor.vanish(name);
				
			case Notify:
				var name:String = null;
				if (command.args.length > 0) name = command.args[0].getAsName();
				actor.notify(name);
				
			case Function(name):
				//HXP.console.log([">SS do Function", name, command.args.length]);
				var args = new Array<Float>();
				for (a in command.args) args.push(a.calc(actor));
				//HXP.console.log([args]);
				Shmup.i.create(name, args, actor);
				
			case Var(name, type):
				//HXP.console.log([" >SS", name, type]);
				var v = actor.vars.get(name);
				
				if (v == null)
					v = actor.addVar(name);
				
				v.targetTicks = 0;
				v.consistentlyValue = null;
				v.consistentlyAdd = null;
				v.consistentlySub = null;
				
				var a = command.args[0];
				
				if (a == null)
					throw "lack of the assignment value";
				
				switch (type)
				{
					case Assignment:
						v.value = a.calc(actor);
					case Add:
						v.value += a.calc(actor);
					case Sub:
						v.value -= a.calc(actor);
					case Target:
						v.target = a.calc(actor);
					case ConsistentlyAssignment:
						v.consistentlyValue = a;
					case ConsistentlyAdd:
						v.consistentlyAdd = a;
					case ConsistentlySub:
						v.consistentlySub = a;
				}
				if (type == VarCommandType.Target)
				{
					if (command.args.length < 2) throw "lack of the target ticks argument";
					v.targetTicks = Std.int(command.args[1].calc(actor));
				}
		}
	}
}