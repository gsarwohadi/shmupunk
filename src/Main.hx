import com.haxepunk.RenderMode;
import com.haxepunk.Engine;
import com.haxepunk.HXP;

import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import com.haxepunk.gui.Label;

class Main extends Engine
{
	public static var padding:Int = 8;
	
	public static var sampleText:TextField;
	
	override public function new(width:Int=0, height:Int=0, frameRate:Float=60, fixed:Bool=false, ?renderMode:RenderMode)
	{
		super(640, 480, frameRate, fixed, renderMode);
		
		var font = openfl.Assets.getFont("font/pf_ronda_seven.ttf");
		Label.defaultFont = font;
		//Label.defaultSize = 16;
		
		var _format:TextFormat = new TextFormat(Label.defaultFont.fontName, Label.defaultSize);
		_format.color = Label.defaultColor;
		
		sampleText = new TextField();
		//sampleText.text = (Sample.s[13][1].split("\r\n").join("\r"));
		sampleText.defaultTextFormat = _format;
		sampleText.type = TextFieldType.INPUT;
		sampleText.embedFonts = true;
		sampleText.multiline = true;
		sampleText.wordWrap = true;
		sampleText.setTextFormat(_format);
		sampleText.width = HXP.halfWidth - 2 * padding;
		sampleText.height = (HXP.height - 2 * padding) - 24;
		sampleText.x = padding;
		sampleText.y = padding;
		
		this.addChild(sampleText);
		//sampleText.text = (Sample.s[13][1].split("\r\n").join("\r"));
    }

    public function getText():String
    {
    	return sampleText.text;
    }
	
	public function modifyText(text:String):Void
	{
		sampleText.text = text;
	}

	public function displayText(status:Bool):Void
	{
		HXP.console.log(["Display text", status]);
		sampleText.visible = status;
	}
	
	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new MainScene(this);
	}

	public static function main() { new Main(); }

}