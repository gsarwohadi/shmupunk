package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(flash.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("gfx/debug/console_debug.png", __ASSET__gfx_debug_console_debug_png);
		type.set ("gfx/debug/console_debug.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_hidden.png", __ASSET__gfx_debug_console_hidden_png);
		type.set ("gfx/debug/console_hidden.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_logo.png", __ASSET__gfx_debug_console_logo_png);
		type.set ("gfx/debug/console_logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_output.png", __ASSET__gfx_debug_console_output_png);
		type.set ("gfx/debug/console_output.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_pause.png", __ASSET__gfx_debug_console_pause_png);
		type.set ("gfx/debug/console_pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_play.png", __ASSET__gfx_debug_console_play_png);
		type.set ("gfx/debug/console_play.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_step.png", __ASSET__gfx_debug_console_step_png);
		type.set ("gfx/debug/console_step.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/debug/console_visible.png", __ASSET__gfx_debug_console_visible_png);
		type.set ("gfx/debug/console_visible.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("gfx/preloader/haxepunk.png", __ASSET__gfx_preloader_haxepunk_png);
		type.set ("gfx/preloader/haxepunk.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("font/04B_03__.ttf", __ASSET__font_04b_03___ttf);
		type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		className.set ("graphics/enemyBlack1.png", __ASSET__graphics_enemyblack1_png);
		type.set ("graphics/enemyBlack1.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/enemyBlack2.png", __ASSET__graphics_enemyblack2_png);
		type.set ("graphics/enemyBlack2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/enemyBlack3.png", __ASSET__graphics_enemyblack3_png);
		type.set ("graphics/enemyBlack3.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/enemyBlack4.png", __ASSET__graphics_enemyblack4_png);
		type.set ("graphics/enemyBlack4.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/enemyBlack5.png", __ASSET__graphics_enemyblack5_png);
		type.set ("graphics/enemyBlack5.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/laserBlue01.png", __ASSET__graphics_laserblue01_png);
		type.set ("graphics/laserBlue01.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/laserBlue10.png", __ASSET__graphics_laserblue10_png);
		type.set ("graphics/laserBlue10.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("graphics/playerShip1_green.png", __ASSET__graphics_playership1_green_png);
		type.set ("graphics/playerShip1_green.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("font/04B_03__.ttf", __ASSET__font_5);
		type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
		
		
		#elseif html5
		
		addExternal("gfx/debug/console_debug.png", "image", "gfx/debug/console_debug.png");
		addExternal("gfx/debug/console_hidden.png", "image", "gfx/debug/console_hidden.png");
		addExternal("gfx/debug/console_logo.png", "image", "gfx/debug/console_logo.png");
		addExternal("gfx/debug/console_output.png", "image", "gfx/debug/console_output.png");
		addExternal("gfx/debug/console_pause.png", "image", "gfx/debug/console_pause.png");
		addExternal("gfx/debug/console_play.png", "image", "gfx/debug/console_play.png");
		addExternal("gfx/debug/console_step.png", "image", "gfx/debug/console_step.png");
		addExternal("gfx/debug/console_visible.png", "image", "gfx/debug/console_visible.png");
		addExternal("gfx/preloader/haxepunk.png", "image", "gfx/preloader/haxepunk.png");
		addEmbed("font/04B_03__.ttf", "font", __ASSET__font_04b_03___ttf);
		addExternal("graphics/enemyBlack1.png", "image", "graphics/enemyBlack1.png");
		addExternal("graphics/enemyBlack2.png", "image", "graphics/enemyBlack2.png");
		addExternal("graphics/enemyBlack3.png", "image", "graphics/enemyBlack3.png");
		addExternal("graphics/enemyBlack4.png", "image", "graphics/enemyBlack4.png");
		addExternal("graphics/enemyBlack5.png", "image", "graphics/enemyBlack5.png");
		addExternal("graphics/laserBlue01.png", "image", "graphics/laserBlue01.png");
		addExternal("graphics/laserBlue10.png", "image", "graphics/laserBlue10.png");
		addExternal("graphics/playerShip1_green.png", "image", "graphics/playerShip1_green.png");
		addEmbed("font/04B_03__.ttf", "font", __ASSET__font_5);
		
		
		#else
		
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
						
						var manifest:Array<AssetData> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							path.set (asset.id, asset.path);
							type.set (asset.id, asset.type);
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest");
				
			}
			
		} catch (e:Dynamic) {
			
			trace ("Warning: Could not load asset manifest");
			
		}
		
		#end
		
	}
	
	
	#if html5
	private function addEmbed(id:String, kind:String, value:Dynamic):Void {
		className.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	
	
	private function addExternal(id:String, kind:String, value:String):Void {
		path.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	#end
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
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
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif openfl_html5
		
		return null;
		
		#elseif js
		
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
		
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, true);
		
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
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
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

@:keep class __ASSET__gfx_debug_console_debug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_hidden_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_output_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_pause_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_step_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_debug_console_visible_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_preloader_haxepunk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__font_04b_03___ttf extends flash.text.Font { }
@:keep class __ASSET__graphics_enemyblack1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_enemyblack5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_laserblue01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_laserblue10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__graphics_playership1_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__font_5 extends flash.text.Font { }


#elseif html5










@:keep class __ASSET__font_04b_03___ttf extends flash.text.Font { }








@:keep class __ASSET__font_5 extends flash.text.Font { }


#end
