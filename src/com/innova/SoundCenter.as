package src.com.innova
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundCenter
	{
		[Embed(source="assets/sound/application/19.mp3")]
		private static var soundClass:Class;
		
		private static var clickSound:Sound;
		private static var _volume:Number;
		private static var channel:SoundChannel = new SoundChannel();
		private static var st:SoundTransform;
		
		public function SoundCenter()
		{
			super();
		}
		
		public static function play():void
		{
			
			//if( clickSound != null ) trace( "Sound already loaded." );
			if( clickSound == null ) 
			{
				//trace( "Sound loaded loaded." );
				clickSound = new soundClass() as Sound;
			}
			
			
			channel = clickSound.play();
			setVolume();
		}
		
		public static function set volume(val:Number):void
		{
			if(_volume > 1.)
				_volume = 1.;
			
			_volume = val;
			setVolume();			
		}
		
		private static function setVolume():void
		{
			st = channel.soundTransform;
			st.volume = _volume; // set to 70% volume
			channel.soundTransform = st;
		}
		
		
		
	}
}