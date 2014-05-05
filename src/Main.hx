import com.haxepunk.RenderMode;
import com.haxepunk.Engine;
import com.haxepunk.HXP;

import flash.text.Font;
import com.haxepunk.gui.Label;

class Main extends Engine
{
	public static var font:Font;
	
	override public function new(width:Int=0, height:Int=0, frameRate:Float=60, fixed:Bool=false, ?renderMode:RenderMode)
	{
		super(640, 480, frameRate, fixed, renderMode);
    }
	
	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		
		font = openfl.Assets.getFont("font/pf_ronda_seven.ttf");
		Label.defaultFont = font;
		//Label.defaultSize = 16;
		HXP.scene = new MainScene();
	}

	public static function main() { new Main(); }

}