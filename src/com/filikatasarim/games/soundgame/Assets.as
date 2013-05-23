package src.com.filikatasarim.games.soundgame
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	public class Assets
	{
		// Welcome Screen
		[Embed(source="assets/welcome/land.png")]
		public static var LandClass:Class;
		
		[Embed(source="assets/welcome/bubble.png")]
		public static var BubbleClass:Class;
		
		[Embed(source="assets/welcome/title.png")]
		public static var TitleClass:Class;
		
		[Embed(source="assets/welcome/cloud.png")]
		public static var CloudClass:Class;
		
		// Game Started
		[Embed(source="assets/bg.jpg")]
		public static var bgClass:Class;
		
		[Embed(source="assets/bg2.jpg")]
		public static var bgClass2:Class;
		
		[Embed(source="assets/bg3.jpg")]
		public static var bgClass3:Class;
		
		[Embed(source="assets/cloud1.png")]
		public static var clClass1:Class;
		
		[Embed(source="assets/cloud2.png")]
		public static var clClass2:Class;
		
		// end game
		[Embed(source="assets/end/gameover.png")]
		public static var gameOverClass:Class;
		
		// Zeplin
		[Embed(source="assets/zeplin.png")]
		public static var zeplinClass:Class;
		
		// Zeplin Sticker
		[Embed(source="assets/zeplinsticker.png")]
		public static var zeplinStickerClass:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Bitmap
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = bitmap;
			}
			return gameTextures[name];
		}
	}
}