package src.com.innova.katlardaireler 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class StarField extends ScrollingLayer
	{	
		[Embed(source = 'assets/images/grid2.gif')]
		private var bitmapClass:Class
		public function StarField() 
		{
			scrollingBitmap = new bitmapClass().bitmapData;
		}
	}

}