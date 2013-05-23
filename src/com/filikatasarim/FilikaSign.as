package src.com.filikatasarim
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.casalib.display.CasaSprite;

	public class FilikaSign extends CasaSprite
	{
		[Embed(source="filika_logo_120x120.png")]
		private var filika : Class;
		
		private var Filika : Bitmap;
		
		public function FilikaSign()
		{
			super();
			this.buttonMode = true;
			Filika = new filika();
			addEventListener(MouseEvent.CLICK,onclick);
			addChild(Filika);
		}
		
		protected function onclick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest('http://www.filikatasarim.com'),"_blank");
		}
	}
}