package src.com.filikatasarim.games.soundgame
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.globals.Root;
	import com.alptugan.globals.RootAir;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.alptugan.utils.keys.KeyCode;
	import com.alptugan.utils.maths.MathUtils;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.ui.Key;
	
	import src.com.filikatasarim.games.soundgame.enemy.Enemy;
	import src.com.filikatasarim.games.soundgame.events.GameEvents;
	
	public class StartGame extends CasaSprite
	{
		// Hero
		private var char:Ant;
		private var xColFac:Number = 40;
		private var yColFac:Number = 40;
		private var landed : Boolean = false;
		private var charLandFac:Number = 20;
		
		// Timer
		private var TimerTxt:ATextSingleLine;

		private var timer:Timer;
		private var minute:int;
		private var second:int;
		
		// Jumping
		private var charOrigin:Number;
		private var charCurrentFloor:int = 0;

		// The game gravity
		private var gravity:Number = 0.8;
		private var speedY : Number= 0;
		private var impulsion : Number = 15;
		
		//Enemy
		private var enemySpeed:Number = 3;
		private var enemyBump:Boolean = false;
		private var enemyDirection:Number = -1;
		private var enemyY:Number = 205;
		private var enemyOrigin :Number;
		private var enemyH : Number = 40;
		//private var enemy:beee_Mc;
		private var enemyNum:int;
		private var enemyHolder:CasaSprite;
		private var enemyArr:Array = [];
		private var currentEnemyPos:Number = -enemyY;
		private var enemyId:int = 0;

		private var animDelay:*;
		
		// Background
		private var bg:Bitmap;
		private var bg2:Bitmap;
		private var bg3:Bitmap;
		private var bgCloud1:Bitmap;
		private var bgCloud2:Bitmap;
		private var speedBg:Number = 0.08;
		private var speedCloud:Number = 0.2;

		private var xFac:Number;

		private var MicLevel:int;
		private var onFloor:Boolean = true;
		private var prevPosY:Number = -1;
		
		private var aboveThres : Boolean = false;
		private var onSameFloor:Boolean = true;
		private var intervalCleared:Boolean = true;

		private var zep:Zeplin;
		private var passedTime:int;
		private var zepInvisibleTime:int = 5;
		public function StartGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onStartAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		
		public function onRemoved(e:Event=null):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.removeEventListeners();
			timer.removeEventListener(TimerEvent.TIMER, clock);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(Event.RESIZE, onResize);
			//removeAllChildrenAndDestroy(true,true);
			while(this.numChildren > 0)
				removeChildAt(0);
			
			null;
			trace("Scene Start is removed from stage\n-----------------------------------------------------");
		}
		
		protected function onStartAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onStartAddedToStage);
			trace("Scene Start added to stage\n-----------------------------------------------------");
			
			//initialize();
		}
		
		public function initialize():void
		{
			
			// add Background
			initBackground();
			
			// init Zeplin Adver
			initZeplin();
			
			//add Character to stage
			initChar();
			
			//init Enemy
			initEnemy();
			
			// add timer
			initTimer();
			
			// init Event Listeners
			initEventListeners();
			
			
		}
		
		private function initZeplin():void
		{
			zep = new Zeplin();
			zep.y = Singleton.getInstance().h * 0.5;
			
			addChild(zep);
			zep.x = Singleton.getInstance().w;
		}		
		
		
		private function initEventListeners():void
		{
			timer.addEventListener(TimerEvent.TIMER, clock);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		protected function onResize(e:Event):void
		{
			Singleton.getInstance().w = stage.stageWidth;
			Singleton.getInstance().h = stage.stageHeight;
			
			if(bg)
			{
				bg.width = bg2.width = bg3.width= Singleton.getInstance().w;
				bg.height = bg2.height = bg3.height = Singleton.getInstance().h;
			}
		}
		
		/**
		 * INITIALIZE PARALLAX BACKGROUND 
		 * 
		 */
		private function initBackground():void
		{
			bg = Assets.getTexture("bgClass");
			this.addChild(bg);
			
			bg2 = Assets.getTexture("bgClass2");
			
			bg2.y = -Singleton.getInstance().h;
			this.addChild(bg2);
			
			bg3 = Assets.getTexture("bgClass3");
			bg3.y = -Singleton.getInstance().h*2;
			this.addChild(bg3);
			
			bgCloud1 = Assets.getTexture("clClass1");
			this.addChild(bgCloud1);
			
			bgCloud2 = Assets.getTexture("clClass2");
			bgCloud2.y = -Singleton.getInstance().h;
			this.addChild(bgCloud2);
			
			onResize(null);
		}
		
		private function initChar():void
		{
			enemyHolder = new CasaSprite();
			addChild(enemyHolder);
			
			char  = new Ant();
			enemyHolder.addChild(char);
			
			char.scaleX = char.scaleY = 0.5;
			char.x = Singleton.getInstance().w- char.width >> 1;
			char.y = Singleton.getInstance().h;
			
			
			// currrent origin 
			charOrigin = char.y;
		}
		
		private function initEnemy():void
		{
			
			//enemyNum = ((stage.stageHeight + 50) / enemyY) + 1;
			enemyNum = 3;
			enemyOrigin = Singleton.getInstance().h - char.height - 50
			
			for (var i:int = 0; i < enemyNum; i++) 
			{
				enemyDirection = MathUtils.getRandomInt(-1,1);
				enemySpeed = MathUtils.getRandomNumber(3,4.5);
				enemyArr[i]= new Enemy(enemySpeed,enemyDirection,enemyY,enemyOrigin);
				//enemyArr[i].name = "enemy"+String(i);
				enemyArr[i].id = i;
				enemyHolder.addChild(enemyArr[i]);
				enemyOrigin -=enemyY;
			}
		}
		
		protected function loop(event:Event):void
		{
			prevPosY = char.y;
			
			// Gravity and Speed
			speedY 		  += gravity;
			char.y 		  += speedY;
			
			if(MicLevel > Singleton.getInstance().micLevel)
			{
				makeJump();
				MicLevel = 0;
			}
			
			
			
			// Apply parallax effect if Ant is not on the land
			if(charCurrentFloor != 0)
			{
				enemyHolder.y += (speedY * -1);
				bg.y  		  += (speedY * -speedBg);
				bg2.y 		  += (speedY * -speedBg);
				bg3.y 		  += (speedY * -speedBg);
				
				bgCloud1.y    += (speedY * -speedCloud);
				bgCloud2.y    += (speedY * -speedCloud);
				zep.y         += (speedY * -speedCloud);
			}
				
			
			
			// Update enemies positions
			for (var i:int = 0; i < enemyNum; i++) 
			{
				enemyArr[i].update();
			}
			
			// set Ant's horizontal position when it lands onto an enemy
			if(charCurrentFloor != 0)
			{
				xFac = enemyArr[enemyId-1 < 0 ? enemyNum-1 : enemyId-1].x-charLandFac;
				char.x = xFac;
			}
				
		
			// proximity and hit detection
			if(char.x - enemyArr[enemyId].x < xColFac && char.x - enemyArr[enemyId].x > -xColFac)
			{
				
				if((enemyArr[enemyId].y) - (char.y )> yColFac / 10 )
				{
					if(!landed)
					{
						charOrigin = enemyArr[enemyId].y ;
						
						TweenLite.to(char,0.2,{x:enemyArr[enemyId].x-charLandFac,y:charOrigin});
						
						charCurrentFloor++;
						enemyId = charCurrentFloor % (enemyNum);
						
					
						// Bir öncekini en üste taşı
						if(charCurrentFloor > 1)
						{
							var moveenemyId:int;
							switch(enemyId)
							{
								case 0:
								{
									moveenemyId = enemyArr.length - 2;
									break;
								}
									
								case 1:
								{
									moveenemyId = enemyArr.length - 1;
									break;
								}
									
								default:
								{
									moveenemyId = enemyId - 2;
									break;
								}
							}
							
							enemyArr[(moveenemyId)].y -= enemyArr.length * enemyY;
						}
						currentEnemyPos +=enemyY;
						
					}
					
					landed = true;
					
				}
			}
			
			// Ant is on the floor
			if (char.y > charOrigin)
			{
				
				char.y = charOrigin;
				if(charCurrentFloor == 0)
				{
					enemyHolder.y = 0;
					zep.visible ? zep.y = Singleton.getInstance().h*0.5 : void ;
					bg.y  = bgCloud1.y = 0;
					bg2.y = bgCloud2.y = -Singleton.getInstance().h;
					bg3.y = -Singleton.getInstance().h*2;
				}else{
					enemyHolder.y = currentEnemyPos;
					
					bg.y  = currentEnemyPos*speedBg;
					bgCloud1.y = currentEnemyPos*speedCloud;
					
					zep.visible ? zep.y = Singleton.getInstance().h*0.5 + currentEnemyPos*speedCloud : void;
					
					bgCloud2.y = (-Singleton.getInstance().h)+currentEnemyPos*speedCloud;
					bg2.y = (-Singleton.getInstance().h)+currentEnemyPos*speedBg;
					bg3.y = (-Singleton.getInstance().h*2) + +currentEnemyPos*speedBg;
					
					if(bgCloud1.y > Singleton.getInstance().h)
					{
						bgCloud1.y  = -Singleton.getInstance().h;
					}
					
					if(bgCloud2.y > Singleton.getInstance().h)
					{
						bgCloud2.y  = -Singleton.getInstance().h;
					}
					
					if(bg.y > Singleton.getInstance().h*1.5)
					{
						bg.y  = -Singleton.getInstance().h*1.5;
					}
					
					if(bg2.y > Singleton.getInstance().h*1.5)
					{
						bg2.y  = -Singleton.getInstance().h*1.5;
					}
					
					if(bg3.y > Singleton.getInstance().h*1.5)
					{
						bg3.y  = -Singleton.getInstance().h*1.5;
					}
					
					if(zep.y > Singleton.getInstance().h + zep.height)
					{
						zep.y  = Singleton.getInstance().h*0.5;
						zep.x  = Singleton.getInstance().w + 20;
					}
						
				}
					
				speedY = 0; 
				MicLevel = (Singleton.getInstance().myMic.activityLevel);
				landed = false;
			}
			
			// Zeplin Properties
			if(zep.visible)
			{
				zep.update();
				zep.x -=2; 
				
				if(zep.x < -zep.width - 20)
				{
					zep.visible = false;
					zep.x = Singleton.getInstance().w;
					zep.y = Singleton.getInstance().h*0.5;
				}
				
				
			}
			
			if(Math.floor(speedY) == 0)
			{
				if(!stage.hasEventListener(KeyboardEvent.KEY_DOWN))
				{
					stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
				}
					
			}else{
				if(stage.hasEventListener(KeyboardEvent.KEY_DOWN))
				{
					stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
				}
					
			}
			
			
				
		}

		private function initTimer():void
		{
			TimerTxt = new ATextSingleLine("00 : 00",FontParams.timefontName,FontParams.timefontColor,FontParams.timefontSize);
			addChild(TimerTxt);
			TimerTxt.alpha = 0.6;
			TimerTxt.filters = [new GlowFilter(0xfd3dcd,0.5)];
			Aligner.alignToCenterTopToBounds(TimerTxt,RootAir.W,0,20);
			
			// Create the two variables.
			minute = Singleton.getInstance().timeLimitMin;
			second = Singleton.getInstance().timeLimitSec + 1;			
			// Create the timer
			// Checks the clock function every 1000 milisecond (1 second)
			timer = new Timer(1000);
			
			timer.start();
		}
		
		private function clock(evt:TimerEvent):void 
		{
			second -= 1;
			// If the second is 59
			if(second < 0){
				// The minute will be plussed with 1
				minute -= 1;
				//and the zero will be set to 00
				second = 59;
			}
			
			TimerTxt.tf.text = String((minute < 10 ? "0"+minute : minute)+" : "+(second<10 ? "0"+second : second));
			
			if(minute == 0 && second == 0)
			{
				trace("Time is Up...Game Ends\n-----------------------------------------------------");
				var e:GameEvents = new GameEvents(GameEvents.TIME_IS_UP);
				dispatchEvent(e);
			}
			
			if(!zep.visible)
			{
				passedTime ++;
				if(passedTime > zepInvisibleTime)
				{
					zep.visible = true;
					passedTime = 0;
				}
			}
			//trace(String((minute < 10 ? "0"+minute : minute)+" : "+(second<10 ? "0"+second : second)));
		}
		
		/**
		 * KEYBOARD EVENT DETECTS CHAR IS JUMPING OR NOT 
		 * @param e
		 * 
		 */
		protected function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == KeyCode.UP && aboveThres == false)
			{	
				aboveThres = true;
				
				makeJump();
			}
		}
		
		protected function onKeyUp(e:KeyboardEvent):void
		{
			
			aboveThres = false;
		}
		
		private function makeJump():void
		{
			// If the hero is standing
			if(Math.floor(speedY) == 0)		
			{
				if(intervalCleared)
				{
					intervalCleared = false;
					animDelay = setInterval(JumpAnimation,200);
					char.gotoAndPlay("jump");
				}
				
				// Set the new speedY with the hero impulsion
			}
			
		
		}
		
		protected function JumpAnimation():void
		{
			
			speedY = -(charCurrentFloor == 0 ? impulsion+4.5:impulsion+4.5);
			clearInterval(animDelay);
			intervalCleared = true;
			
		}
	}
}