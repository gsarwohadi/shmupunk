package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("graphics/debug/console_debug.png", __ASSET__graphics_debug_console_debug_png);
		type.set ("graphics/debug/console_debug.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_hidden.png", __ASSET__graphics_debug_console_hidden_png);
		type.set ("graphics/debug/console_hidden.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_logo.png", __ASSET__graphics_debug_console_logo_png);
		type.set ("graphics/debug/console_logo.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_output.png", __ASSET__graphics_debug_console_output_png);
		type.set ("graphics/debug/console_output.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_pause.png", __ASSET__graphics_debug_console_pause_png);
		type.set ("graphics/debug/console_pause.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_play.png", __ASSET__graphics_debug_console_play_png);
		type.set ("graphics/debug/console_play.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_step.png", __ASSET__graphics_debug_console_step_png);
		type.set ("graphics/debug/console_step.png", AssetType.IMAGE);
		className.set ("graphics/debug/console_visible.png", __ASSET__graphics_debug_console_visible_png);
		type.set ("graphics/debug/console_visible.png", AssetType.IMAGE);
		className.set ("graphics/preloader/haxepunk.png", __ASSET__graphics_preloader_haxepunk_png);
		type.set ("graphics/preloader/haxepunk.png", AssetType.IMAGE);
		className.set ("font/04B_03__.ttf", __ASSET__font_04b_03___ttf);
		type.set ("font/04B_03__.ttf", AssetType.FONT);
		className.set ("font/04B_03__.ttf.png", __ASSET__font_04b_03___ttf_png);
		type.set ("font/04B_03__.ttf.png", AssetType.IMAGE);
		className.set ("gfx/test/0.png", __ASSET__gfx_test_0_png);
		type.set ("gfx/test/0.png", AssetType.IMAGE);
		className.set ("gfx/test/1.png", __ASSET__gfx_test_1_png);
		type.set ("gfx/test/1.png", AssetType.IMAGE);
		className.set ("gfx/test/2.png", __ASSET__gfx_test_2_png);
		type.set ("gfx/test/2.png", AssetType.IMAGE);
		className.set ("gfx/test/3.png", __ASSET__gfx_test_3_png);
		type.set ("gfx/test/3.png", AssetType.IMAGE);
		className.set ("gfx/test/4.png", __ASSET__gfx_test_4_png);
		type.set ("gfx/test/4.png", AssetType.IMAGE);
		className.set ("gfx/test/5.png", __ASSET__gfx_test_5_png);
		type.set ("gfx/test/5.png", AssetType.IMAGE);
		className.set ("gfx/test/6.png", __ASSET__gfx_test_6_png);
		type.set ("gfx/test/6.png", AssetType.IMAGE);
		className.set ("gfx/test/7.png", __ASSET__gfx_test_7_png);
		type.set ("gfx/test/7.png", AssetType.IMAGE);
		className.set ("gfx/test/8.png", __ASSET__gfx_test_8_png);
		type.set ("gfx/test/8.png", AssetType.IMAGE);
		className.set ("gfx/test/9.png", __ASSET__gfx_test_9_png);
		type.set ("gfx/test/9.png", AssetType.IMAGE);
		className.set ("gfx/ui/blueMagda.png", __ASSET__gfx_ui_bluemagda_png);
		type.set ("gfx/ui/blueMagda.png", AssetType.IMAGE);
		className.set ("gfx/ui/greenMagda.png", __ASSET__gfx_ui_greenmagda_png);
		type.set ("gfx/ui/greenMagda.png", AssetType.IMAGE);
		className.set ("gfx/ui/greyDefault.png", __ASSET__gfx_ui_greydefault_png);
		type.set ("gfx/ui/greyDefault.png", AssetType.IMAGE);
		className.set ("gfx/ui/purpleMagda.png", __ASSET__gfx_ui_purplemagda_png);
		type.set ("gfx/ui/purpleMagda.png", AssetType.IMAGE);
		className.set ("gfx/ui/themes.png", __ASSET__gfx_ui_themes_png);
		type.set ("gfx/ui/themes.png", AssetType.IMAGE);
		className.set ("graphics/enemyBlack1.png", __ASSET__graphics_enemyblack1_png);
		type.set ("graphics/enemyBlack1.png", AssetType.IMAGE);
		className.set ("graphics/enemyBlack2.png", __ASSET__graphics_enemyblack2_png);
		type.set ("graphics/enemyBlack2.png", AssetType.IMAGE);
		className.set ("graphics/enemyBlack3.png", __ASSET__graphics_enemyblack3_png);
		type.set ("graphics/enemyBlack3.png", AssetType.IMAGE);
		className.set ("graphics/enemyBlack4.png", __ASSET__graphics_enemyblack4_png);
		type.set ("graphics/enemyBlack4.png", AssetType.IMAGE);
		className.set ("graphics/enemyBlack5.png", __ASSET__graphics_enemyblack5_png);
		type.set ("graphics/enemyBlack5.png", AssetType.IMAGE);
		className.set ("graphics/laserBlue01.png", __ASSET__graphics_laserblue01_png);
		type.set ("graphics/laserBlue01.png", AssetType.IMAGE);
		className.set ("graphics/laserBlue10.png", __ASSET__graphics_laserblue10_png);
		type.set ("graphics/laserBlue10.png", AssetType.IMAGE);
		className.set ("graphics/laserGreen11.png", __ASSET__graphics_lasergreen11_png);
		type.set ("graphics/laserGreen11.png", AssetType.IMAGE);
		className.set ("graphics/playerShip1_green.png", __ASSET__graphics_playership1_green_png);
		type.set ("graphics/playerShip1_green.png", AssetType.IMAGE);
		className.set ("font/04B_03__.ttf", __ASSET__font_5);
		type.set ("font/04B_03__.ttf", AssetType.FONT);
		className.set ("font/lythgame.ttf", __ASSET__font_lythgame_ttf);
		type.set ("font/lythgame.ttf", AssetType.FONT);
		className.set ("font/lythgamescript.ttf", __ASSET__font_lythgamescript_ttf);
		type.set ("font/lythgamescript.ttf", AssetType.FONT);
		className.set ("font/pf_ronda_seven.ttf", __ASSET__font_pf_ronda_seven_ttf);
		type.set ("font/pf_ronda_seven.ttf", AssetType.FONT);
		
		
		#elseif html5
		
		var id;
		id = "graphics/debug/console_debug.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_hidden.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_output.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_pause.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_play.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_step.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/debug/console_visible.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/preloader/haxepunk.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "font/04B_03__.ttf";
		className.set (id, __ASSET__font_04b_03___ttf);
		type.set (id, AssetType.FONT);
		id = "font/04B_03__.ttf.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/0.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/5.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/6.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/7.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/8.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/test/9.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/ui/blueMagda.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/ui/greenMagda.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/ui/greyDefault.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/ui/purpleMagda.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/ui/themes.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/enemyBlack1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/enemyBlack2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/enemyBlack3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/enemyBlack4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/enemyBlack5.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/laserBlue01.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/laserBlue10.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/laserGreen11.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "graphics/playerShip1_green.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "font/04B_03__.ttf";
		className.set (id, __ASSET__font_5);
		type.set (id, AssetType.FONT);
		id = "font/lythgame.ttf";
		className.set (id, __ASSET__font_lythgame_ttf);
		type.set (id, AssetType.FONT);
		id = "font/lythgamescript.ttf";
		className.set (id, __ASSET__font_lythgamescript_ttf);
		type.set (id, AssetType.FONT);
		id = "font/pf_ronda_seven.ttf";
		className.set (id, __ASSET__font_pf_ronda_seven_ttf);
		type.set (id, AssetType.FONT);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("graphics/debug/console_debug.png", __ASSET__graphics_debug_console_debug_png);
		type.set ("graphics/debug/console_debug.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_hidden.png", __ASSET__graphics_debug_console_hidden_png);
		type.set ("graphics/debug/console_hidden.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_logo.png", __ASSET__graphics_debug_console_logo_png);
		type.set ("graphics/debug/console_logo.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_output.png", __ASSET__graphics_debug_console_output_png);
		type.set ("graphics/debug/console_output.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_pause.png", __ASSET__graphics_debug_console_pause_png);
		type.set ("graphics/debug/console_pause.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_play.png", __ASSET__graphics_debug_console_play_png);
		type.set ("graphics/debug/console_play.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_step.png", __ASSET__graphics_debug_console_step_png);
		type.set ("graphics/debug/console_step.png", AssetType.IMAGE);
		
		className.set ("graphics/debug/console_visible.png", __ASSET__graphics_debug_console_visible_png);
		type.set ("graphics/debug/console_visible.png", AssetType.IMAGE);
		
		className.set ("graphics/preloader/haxepunk.png", __ASSET__graphics_preloader_haxepunk_png);
		type.set ("graphics/preloader/haxepunk.png", AssetType.IMAGE);
		
		className.set ("font/04B_03__.ttf", __ASSET__font_04b_03___ttf);
		type.set ("font/04B_03__.ttf", AssetType.FONT);
		
		className.set ("font/04B_03__.ttf.png", __ASSET__font_04b_03___ttf_png);
		type.set ("font/04B_03__.ttf.png", AssetType.IMAGE);
		
		className.set ("gfx/test/0.png", __ASSET__gfx_test_0_png);
		type.set ("gfx/test/0.png", AssetType.IMAGE);
		
		className.set ("gfx/test/1.png", __ASSET__gfx_test_1_png);
		type.set ("gfx/test/1.png", AssetType.IMAGE);
		
		className.set ("gfx/test/2.png", __ASSET__gfx_test_2_png);
		type.set ("gfx/test/2.png", AssetType.IMAGE);
		
		className.set ("gfx/test/3.png", __ASSET__gfx_test_3_png);
		type.set ("gfx/test/3.png", AssetType.IMAGE);
		
		className.set ("gfx/test/4.png", __ASSET__gfx_test_4_png);
		type.set ("gfx/test/4.png", AssetType.IMAGE);
		
		className.set ("gfx/test/5.png", __ASSET__gfx_test_5_png);
		type.set ("gfx/test/5.png", AssetType.IMAGE);
		
		className.set ("gfx/test/6.png", __ASSET__gfx_test_6_png);
		type.set ("gfx/test/6.png", AssetType.IMAGE);
		
		className.set ("gfx/test/7.png", __ASSET__gfx_test_7_png);
		type.set ("gfx/test/7.png", AssetType.IMAGE);
		
		className.set ("gfx/test/8.png", __ASSET__gfx_test_8_png);
		type.set ("gfx/test/8.png", AssetType.IMAGE);
		
		className.set ("gfx/test/9.png", __ASSET__gfx_test_9_png);
		type.set ("gfx/test/9.png", AssetType.IMAGE);
		
		className.set ("gfx/ui/blueMagda.png", __ASSET__gfx_ui_bluemagda_png);
		type.set ("gfx/ui/blueMagda.png", AssetType.IMAGE);
		
		className.set ("gfx/ui/greenMagda.png", __ASSET__gfx_ui_greenmagda_png);
		type.set ("gfx/ui/greenMagda.png", AssetType.IMAGE);
		
		className.set ("gfx/ui/greyDefault.png", __ASSET__gfx_ui_greydefault_png);
		type.set ("gfx/ui/greyDefault.png", AssetType.IMAGE);
		
		className.set ("gfx/ui/purpleMagda.png", __ASSET__gfx_ui_purplemagda_png);
		type.set ("gfx/ui/purpleMagda.png", AssetType.IMAGE);
		
		className.set ("gfx/ui/themes.png", __ASSET__gfx_ui_themes_png);
		type.set ("gfx/ui/themes.png", AssetType.IMAGE);
		
		className.set ("graphics/enemyBlack1.png", __ASSET__graphics_enemyblack1_png);
		type.set ("graphics/enemyBlack1.png", AssetType.IMAGE);
		
		className.set ("graphics/enemyBlack2.png", __ASSET__graphics_enemyblack2_png);
		type.set ("graphics/enemyBlack2.png", AssetType.IMAGE);
		
		className.set ("graphics/enemyBlack3.png", __ASSET__graphics_enemyblack3_png);
		type.set ("graphics/enemyBlack3.png", AssetType.IMAGE);
		
		className.set ("graphics/enemyBlack4.png", __ASSET__graphics_enemyblack4_png);
		type.set ("graphics/enemyBlack4.png", AssetType.IMAGE);
		
		className.set ("graphics/enemyBlack5.png", __ASSET__graphics_enemyblack5_png);
		type.set ("graphics/enemyBlack5.png", AssetType.IMAGE);
		
		className.set ("graphics/laserBlue01.png", __ASSET__graphics_laserblue01_png);
		type.set ("graphics/laserBlue01.png", AssetType.IMAGE);
		
		className.set ("graphics/laserBlue10.png", __ASSET__graphics_laserblue10_png);
		type.set ("graphics/laserBlue10.png", AssetType.IMAGE);
		
		className.set ("graphics/laserGreen11.png", __ASSET__graphics_lasergreen11_png);
		type.set ("graphics/laserGreen11.png", AssetType.IMAGE);
		
		className.set ("graphics/playerShip1_green.png", __ASSET__graphics_playership1_green_png);
		type.set ("graphics/playerShip1_green.png", AssetType.IMAGE);
		
		className.set ("font/04B_03__.ttf", __ASSET__font_5);
		type.set ("font/04B_03__.ttf", AssetType.FONT);
		
		className.set ("font/lythgame.ttf", __ASSET__font_lythgame_ttf);
		type.set ("font/lythgame.ttf", AssetType.FONT);
		
		className.set ("font/lythgamescript.ttf", __ASSET__font_lythgamescript_ttf);
		type.set ("font/lythgamescript.ttf", AssetType.FONT);
		
		className.set ("font/pf_ronda_seven.ttf", __ASSET__font_pf_ronda_seven_ttf);
		type.set ("font/pf_ronda_seven.ttf", AssetType.FONT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__graphics_debug_console_debug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_hidden_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_output_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_pause_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_step_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_debug_console_visible_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_preloader_haxepunk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__font_04b_03___ttf extends openfl.text.Font { }
@:keep class __ASSET__font_04b_03___ttf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_test_9_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_ui_bluemagda_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_ui_greenmagda_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_ui_greydefault_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_ui_purplemagda_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_ui_themes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_laserblue01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_laserblue10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_lasergreen11_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_playership1_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__font_5 extends openfl.text.Font { }
@:keep class __ASSET__font_lythgame_ttf extends openfl.text.Font { }
@:keep class __ASSET__font_lythgamescript_ttf extends openfl.text.Font { }
@:keep class __ASSET__font_pf_ronda_seven_ttf extends openfl.text.Font { }


#elseif html5










@:keep class __ASSET__font_04b_03___ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/04B_03__.ttf"; } #end }

























@:keep class __ASSET__font_5 extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/04B_03__.ttf"; } #end }
@:keep class __ASSET__font_lythgame_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/lythgame.ttf"; } #end }
@:keep class __ASSET__font_lythgamescript_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/lythgamescript.ttf"; } #end }
@:keep class __ASSET__font_pf_ronda_seven_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/pf_ronda_seven.ttf"; } #end }


#elseif (windows || mac || linux)


@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_debug.png") class __ASSET__graphics_debug_console_debug_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_hidden.png") class __ASSET__graphics_debug_console_hidden_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_logo.png") class __ASSET__graphics_debug_console_logo_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_output.png") class __ASSET__graphics_debug_console_output_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_pause.png") class __ASSET__graphics_debug_console_pause_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_play.png") class __ASSET__graphics_debug_console_play_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_step.png") class __ASSET__graphics_debug_console_step_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/debug/console_visible.png") class __ASSET__graphics_debug_console_visible_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/graphics/preloader/haxepunk.png") class __ASSET__graphics_preloader_haxepunk_png extends flash.display.BitmapData {}
@:font("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/font/04B_03__.ttf") class __ASSET__font_04b_03___ttf extends flash.text.Font {}
@:bitmap("/usr/lib/haxe/lib/HaxePunk/2,5,3/assets/font/04B_03__.ttf.png") class __ASSET__font_04b_03___ttf_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/0.png") class __ASSET__gfx_test_0_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/1.png") class __ASSET__gfx_test_1_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/2.png") class __ASSET__gfx_test_2_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/3.png") class __ASSET__gfx_test_3_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/4.png") class __ASSET__gfx_test_4_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/5.png") class __ASSET__gfx_test_5_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/6.png") class __ASSET__gfx_test_6_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/7.png") class __ASSET__gfx_test_7_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/8.png") class __ASSET__gfx_test_8_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/test/9.png") class __ASSET__gfx_test_9_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/ui/blueMagda.png") class __ASSET__gfx_ui_bluemagda_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/ui/greenMagda.png") class __ASSET__gfx_ui_greenmagda_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/ui/greyDefault.png") class __ASSET__gfx_ui_greydefault_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/ui/purpleMagda.png") class __ASSET__gfx_ui_purplemagda_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/ui/themes.png") class __ASSET__gfx_ui_themes_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/enemyBlack1.png") class __ASSET__graphics_enemyblack1_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/enemyBlack2.png") class __ASSET__graphics_enemyblack2_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/enemyBlack3.png") class __ASSET__graphics_enemyblack3_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/enemyBlack4.png") class __ASSET__graphics_enemyblack4_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/enemyBlack5.png") class __ASSET__graphics_enemyblack5_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/laserBlue01.png") class __ASSET__graphics_laserblue01_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/laserBlue10.png") class __ASSET__graphics_laserblue10_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/laserGreen11.png") class __ASSET__graphics_lasergreen11_png extends flash.display.BitmapData {}
@:bitmap("assets/graphics/playerShip1_green.png") class __ASSET__graphics_playership1_green_png extends flash.display.BitmapData {}
@:font("assets/font/04B_03__.ttf") class __ASSET__font_5 extends flash.text.Font {}
@:font("assets/font/lythgame.ttf") class __ASSET__font_lythgame_ttf extends flash.text.Font {}
@:font("assets/font/lythgamescript.ttf") class __ASSET__font_lythgamescript_ttf extends flash.text.Font {}
@:font("assets/font/pf_ronda_seven.ttf") class __ASSET__font_pf_ronda_seven_ttf extends flash.text.Font {}


#end
