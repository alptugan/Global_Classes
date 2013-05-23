package alptugan
{
	import flash.display.Shape;

	public class CreateMaske
	{
		public static var maske : Shape;
		
		public static function Create(_x:Number,_y:Number,_w:Number,_h:Number):Shape
		{
			maske = new Shape();
			maske.graphics.beginFill(0x000000,0.6);
			maske.graphics.drawRect(0,0,_w,_h);
			maske.graphics.endFill();
			maske.x = _x;
			maske.y = _y;
			return maske;
		}
		
		public static function Destroy():void
		{
			maske.graphics.clear();
			maske = null;
		}
		
	}
}