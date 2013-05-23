package src.com.filikatasarim.games.soundgame
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.utils.maths.MathUtils;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.games.soundgame.events.GameEvents;
	
	public class WelcomeGame extends CasaSprite
	{
		private var title:Bitmap;
		private var bubble:Bitmap;
		private var land:Bitmap;
		private var cloud:Array = [];
		private var bg:Bitmap;
		private var titleY:Number ;
		private var cloudPos:Array = [];
		private var char:Ant;
		private var animDelay:*;
		// The game gravity
		private var gravity:Number = 0.8;
		private var speedY : Number= 0;
		private var impulsion : Number = 19;
		private var landed:Boolean = true;

		private var charOrigin:Number;
		
		//miclevel
		private var MicLevel:int = 0;
		
		public function WelcomeGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			for (var i:int = 0; i < 5; i++) 
			{
				cloud[i].alpha = 0;
			}
			
			title.alpha = 0;
			title.y = -100;
			
			bubble.alpha = 0;
			bubble.scaleX = bubble.scaleY = 0;
			
			char.y = charOrigin;
				
			landed = true;
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.removeEventListener(Event.ENTER_FRAME,onLoop);
			
			
			trace("WelcomeGame Class is removed from stage\n-----------------------------------------------------");
		}
		
		public function dispose():void
		{
			onRemoved(null);
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			// Background			
			bg = new Assets.bgClass();
			bg.width = Singleton.getInstance().w;
			bg.height = Singleton.getInstance().h;
			addChild(bg);
			
			// Speech Bubble for Ant
			bubble = Assets.getTexture("BubbleClass");
			addChild(bubble);
			bubble.alpha = 0;
			bubble.scaleX = bubble.scaleY = 0;
			bubble.x = 280;
			bubble.y = 380;
			
			// Land For Ant
			land  = Assets.getTexture("LandClass");
			addChild(land);
			Aligner.alignBottomMiddleToBounds(land,Singleton.getInstance().w,Singleton.getInstance().h,33,0);
			
			// Clouds with osicllations
			for (var i:int = 0; i < 5; i++) 
			{
				cloud[i] = new Assets.CloudClass();
				addChild(cloud[i]);
				
				cloud[i].smoothing = true;
				cloud[i].scaleX = cloud[i].scaleY = MathUtils.getRandomNumber(0.2,1.5);
				cloud[i].alpha = 0;
				
			}
			cloud[0].x = 153;
			cloud[0].y = cloudPos[0] = 55;
			
			cloud[1].x = -cloud[1].width*0.5;
			cloud[1].y = cloudPos[1] = 331;
			
			cloud[2].x = 438;
			cloud[2].y = cloudPos[2] =140;
			
			cloud[3].x = 875;
			cloud[3].y =cloudPos[3] = 67;
			
			cloud[4].x = 940;
			cloud[4].y = cloudPos[4] =325;
			
			// Title of the game
			title = Assets.getTexture("TitleClass");
			addChild(title);
			Aligner.alignCenterMiddleToBounds(title,Singleton.getInstance().w,Singleton.getInstance().h,0,-297);
			titleY = title.y;
			title.alpha = 0;
			title.y = -100;
			
			
			// Add Character to stage at last
			char = new Ant();
			addChild(char);
			
			char.scaleX = char.scaleY = 0.7;
			char.x = Singleton.getInstance().w- char.width >> 1;
			charOrigin = Singleton.getInstance().h - land.height + 7;
			char.y = charOrigin;
			
			trace("WelcomeGame Class added to stage\n-----------------------------------------------------");
		}
		
		public function initialize():void
		{
			landed = true;
			
			for (var i:int = 0; i < 5; i++) 
			{
				TweenLite.to(cloud[i],1.4,{alpha:1,delay:i*0.4});
			}
			
			TweenLite.to(title,0.5,{alpha:1,delay:1.2,y:titleY,onComplete:onWelcomeAnimFinished,ease:Expo.easeOut});
			
			TweenLite.to(bubble,0.8,{alpha:1,scaleX:1,scaleY:1,delay:1.6,ease:Elastic.easeOut});
			
			trace("WelcomeGame Class is initialized\n-----------------------------------------------------");
		}
		
		protected function onWelcomeAnimFinished():void
		{
			// ENTER FRAME LOOP
			this.addEventListener(Event.ENTER_FRAME,onLoop);
			//this.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onLoop(event:Event):void
		{
			MicLevel = (Singleton.getInstance().myMic.activityLevel);
			speedY 		  += gravity;
			char.y 		  += speedY;
			
			var currentDate:Date = new Date();
			//0002 is speed -25 vertical limit
			title.y = titleY - (Math.cos(currentDate.getTime() * 0.002) * 5);

			cloud[0].y = cloudPos[0] + (Math.cos(currentDate.getTime() * 0.0015) * 2);
			cloud[1].y = cloudPos[1] + (Math.cos(currentDate.getTime() * 0.002) * 5);
			cloud[2].y = cloudPos[2] + (Math.cos(currentDate.getTime() * 0.0005) * 10);
			cloud[3].y = cloudPos[3] + (Math.cos(currentDate.getTime() * 0.0009) * 4);
			cloud[4].y = cloudPos[4] + (Math.cos(currentDate.getTime() * 0.002) * 9);
			
			bubble.y = 380 + (Math.cos(currentDate.getTime() * 0.003) * 3);
			
			if (char.y > charOrigin)
			{
				char.y = charOrigin;
				
			}
			
			if(MicLevel > Singleton.getInstance().micLevel && landed == true)
			{
				onClick(null);
				landed = false;
				
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK,onClick);
			
			animDelay = setInterval(JumpAnimation,200);
			char.gotoAndPlay("jump");
			
			landed = true;
		}
		
		protected function JumpAnimation():void
		{
			clearInterval(animDelay);
			speedY = -impulsion;
			
			animDelay = setInterval(JumpAnimationFinished,750);
			
		}
		
		private function JumpAnimationFinished():void
		{
			clearInterval(animDelay);
			var evt:GameEvents = new GameEvents(GameEvents.GAME_STARTED);
			dispatchEvent(evt);
		}
	}
}