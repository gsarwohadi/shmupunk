import com.haxepunk.Scene;

import com.haxepunk.HXP;
import com.haxepunk.shmup.Shmup;
import com.haxepunk.shmup.Actor;
import com.haxepunk.shmup.ShmupEntity;
import com.haxepunk.shmup.Command;

import com.haxepunk.gui.Panel;
import com.haxepunk.gui.Button;
import com.haxepunk.gui.ToggleButton;
import com.haxepunk.gui.Label;
import com.haxepunk.gui.MenuList;
import com.haxepunk.gui.MenuItem;
import com.haxepunk.gui.event.ControlEvent;

import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import entities.Enemy;
import entities.Bullet;
import entities.Turret;
import entities.Player;

class MainScene extends Scene
{
	private var main:Main;
	private var shmup:Shmup;
	private var currentSample:String;
	
	private var startbutton:ToggleButton;
	private var selectbutton:ToggleButton;
	private var samplelist:MenuList;

	private var player:Player;
	
	public function new(main:Main)
	{
		this.main = main;
		
		super();
		
		setSample(Sample.s.length - 1);
		//setSample(1);
		shmup = new Shmup(HXP.halfWidth, 0, HXP.halfWidth, HXP.height, this);
		
		HXP.console.log([shmup.playerX, shmup.playerY]);
		
		shmup.setEntity(ActorType.Enemy, entities.Enemy);
		shmup.setEntity(ActorType.Bullet, entities.Bullet);
		shmup.setEntity(ActorType.Turret, entities.Turret);
		
		var panel = new Panel(0, 0, Math.round(HXP.halfWidth), Math.round(HXP.height), true);
		var innerpanel = new Panel(Main.padding, Main.padding, Math.round(HXP.halfWidth - 2 * Main.padding), Math.round(HXP.height - 2 * Main.padding) - 24, true);
		startbutton = new ToggleButton("Start", true, 8, panel.height - 8 - 24, Math.round(panel.width * 0.5) - 8, 24);
		startbutton.addEventListener(Button.CLICKED, onClickedStart);
		selectbutton = new ToggleButton("Select", false, Math.round(panel.width * 0.5), panel.height - 8 - 24, Math.round(panel.width * 0.5) - 8, 24);
		selectbutton.addEventListener(Button.CLICKED, onClickedSelect);
		samplelist = new MenuList(selectbutton.x, selectbutton.y, Math.round(HXP.halfWidth * 0.5));
		for ( sample in Sample.s )
		{
			var sampleitem = new MenuItem(sample[0]);
			
			samplelist.addControl(sampleitem);
		}
		samplelist.localY = selectbutton.y - samplelist.height;
		samplelist.addEventListener(MenuList.CLICKED, onClickedList);
		
		panel.addControl(startbutton);
		panel.addControl(selectbutton);
		panel.addControl(innerpanel);
		panel.addControl(samplelist);
		add(panel);
	}
	
	public override function begin()
	{
		readShmup();
		main.modifyText(currentSample);
		checkSelectButton();

		player = new Player();
		player.x = shmup.screenX + (shmup.screenWidth * 0.15);
		player.y = shmup.screenHeight * 0.18;
		add(player);

		HXP.console.log(["Created player pos:", player.x, player.y]);
		HXP.console.log([" > player actor pos:", player.pos.x, player.pos.y]);
	}
	
	public override function update()
	{
		super.update();
		if ( player != null )
		{
			shmup.playerX = player.pos.x;
			shmup.playerY = player.pos.y;
		}
		shmup.update();
	}

	private function onClickedStart(e:ControlEvent):Void
	{
		currentSample = main.getText();
		shmup.cleanup();
		readShmup();
	}

	private function onClickedSelect(e:ControlEvent):Void
	{
		checkSelectButton();
	}

	private function onClickedList(e:ControlEvent):Void
	{
		HXP.console.log([e.control, samplelist.selectedId]);
		setSample(samplelist.selectedId);
		main.modifyText(currentSample);
		selectbutton.checked = false;
		checkSelectButton();

		shmup.cleanup();
		readShmup();
	}

	private function checkSelectButton():Void
	{
		for ( sampleitem in samplelist.children )
		{
			var mitem:MenuItem = cast sampleitem;
			mitem.visible = selectbutton.checked;
			mitem.label.visible = selectbutton.checked;
		}
		samplelist.visible = selectbutton.checked;

		main.displayText(!samplelist.visible);
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