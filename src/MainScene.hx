import com.haxepunk.Scene;

import com.haxepunk.HXP;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;
import com.haxepunk.shmup.Command;

import com.haxepunk.gui.Panel;
import com.haxepunk.gui.Button;
import com.haxepunk.gui.TextInput;

import entities.Enemy;
import entities.Bullet;
import entities.Turret;

class MainScene extends Scene
{
	private var shmup:Shmup;
	private var currentSample:String;
	
	private var sampleText:TextInput;
	
	public function new()
	{
		super();
		
		//setSample(Sample.s.length - 1);
		setSample(0);
		shmup = new Shmup(HXP.halfWidth, 0, HXP.halfWidth, HXP.height, this);
		
		HXP.console.log([shmup.playerX, shmup.playerY]);
		
		shmup.setEntity(ActorType.Enemy, entities.Enemy);
		shmup.setEntity(ActorType.Bullet, entities.Bullet);
		shmup.setEntity(ActorType.Turret, entities.Turret);
		
		var panel = new Panel(0, 0, Math.round(HXP.halfWidth), Math.round(HXP.height), true);
		var button = new Button("Start", 8, panel.height - 8 - 24, panel.width - 16, 24);
		sampleText = new TextInput(currentSample, 8, 8, panel.width - 16, panel.height - 16 - 8 - 24, true);
		panel.addControl(button);
		panel.addControl(sampleText);
		add(panel);
		
		
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