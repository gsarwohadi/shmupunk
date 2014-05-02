import com.haxepunk.Scene;

import com.haxepunk.HXP;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;
import com.haxepunk.shmup.Command;

import entities.Enemy;
import entities.Bullet;
import entities.Turret;

class MainScene extends Scene
{
	private var shmup:Shmup;
	private var currentSample:String;
	
	public function new()
	{
		super();
		
		//setSample(Sample.s.length - 1);
		setSample(13);
		shmup = new Shmup(HXP.width, HXP.height, this);
		
		shmup.setEntity(ActorType.Enemy, entities.Enemy);
		shmup.setEntity(ActorType.Bullet, entities.Bullet);
		shmup.setEntity(ActorType.Turret, entities.Turret);
	}
	
	public override function begin()
	{
		readShmup();
	}
	
	public override function update()
	{
		super.update();
		shmup.update();
	}
	
	private function readShmup():Void
	{
		Command.read(currentSample.split("\r").join("\n"));
		shmup.create("main");
		//HXP.console.log([currentSample]);
	}
	
	private function setSample(i:Int):Void
	{
		currentSample = Sample.s[i][1].split("\r\n").join("\r");
	}
}