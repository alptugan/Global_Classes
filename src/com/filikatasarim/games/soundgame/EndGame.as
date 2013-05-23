package src.com.filikatasarim.games.soundgame
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.games.soundgame.events.GameEvents;
	
	public class EndGame extends CasaSprite
	{
		private var holder:CasaSprite = new CasaSprite();
		private var end:Bitmap;
		private var bg:Bitmap;
		
		public function EndGame()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			
			
			trace("EndGame Class is removed from stage\n-----------------------------------------------------");
		}
		
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			// Background			
			bg = new Assets.bgClass();
			bg.width = Singleton.getInstance().w;
			bg.height = Singleton.getInstance().h;
			addChild(bg);
			
			addChild(holder);
			
			holder.x = Singleton.getInstance().w >> 1;
			holder.y = Singleton.getInstance().h >> 1;
			
			end = Assets.getTexture("gameOverClass");
			holder.addChild(end);
			end.x = -end.width * 0.5;
			end.y = -end.height * 0.5;
			
			holder.alpha = 0;
			holder.rotation = 570;
			holder.scaleX = holder.scaleY = 0;
			
			
			trace("EndGame Class added to stage\n-----------------------------------------------------");
		}
		
		public function initialize():void
		{
			
			TweenLite.to(holder,1,{ease:Elastic.easeInOut,scaleX:1,scaleY:1,alpha:1,onComplete:onAnimFinish,rotation:0});
			
		}
		
		protected function onAnimFinish():void
		{
			TweenLite.to(holder,1,{scaleX:0,scaleY:0,alpha:0,onComplete:onAnimRemove,rotation:570,delay:0.5});
		}
		
		protected function onAnimRemove():void
		{
			
			var evt:GameEvents = new GameEvents(GameEvents.GAME_READY);
			dispatchEvent(evt);
		}
	}
}