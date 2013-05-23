package src.com.filikatasarim.games.soundgame
{
	import com.alptugan.utils.keys.KeyCode;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.games.soundgame.events.GameEvents;
	
	public class CoreClass extends CasaSprite
	{
		private var StartScene:StartGame;
		private var WelcomeScene:WelcomeGame;
		private var EndScene:EndGame;
		
		
		
		[Embed(source="com/alptugan/assets/font/akaDylan Plain.ttf", embedAsCFF="false", fontName="bold", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		
		private var ant:Ant = new Ant();
		
		public function CoreClass()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			trace("Core Class is removed from stage\n-----------------------------------------------------");
		}
		
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			trace("CoreClass added to stage\n-----------------------------------------------------");
			
			
			Singleton.getInstance().w = stage.stageWidth;
			Singleton.getInstance().h = stage.stageHeight;
			
			WelcomeScene = new WelcomeGame();
			WelcomeScene.visible = true;
			addChild(WelcomeScene);
			WelcomeScene.initialize();
			
			/*StartScene = new StartGame();
			StartScene.visible = false;
			addChild(StartScene);*/
			
			EndScene   = new EndGame();
			
			addChild(EndScene);
			EndScene.visible = false;
			
			
			
			MicrophoneController();
			
			
			initEventListeners();
		}
		
		
		
		private function MicrophoneController():void
		{
			Singleton.getInstance().myMic = Microphone.getMicrophone();
			//Security.showSettings(SecurityPanel.MICROPHONE);
			Singleton.getInstance().myMic.setLoopBack(true);
			Singleton.getInstance().myMic.setUseEchoSuppression(true);
			Singleton.getInstance().myMic.gain = 100;
		}
		
		/**
		 * EVENT LISTENERS TO TRACK GAME STATES 
		 * 
		 */
		private function initEventListeners():void
		{
			WelcomeScene.addEventListener(GameEvents.GAME_STARTED,onGameStarted);
			addEventListener(GameEvents.TIME_IS_UP, onTimeIsUp,true);
			EndScene.addEventListener(GameEvents.GAME_READY, onGameReady);
		
		}
		
		
		
		/**
		 * START GAME  SCENE
		 * @param event
		 * 
		 */
		protected function onGameStarted(event:Event):void
		{
			
			WelcomeScene.dispose();
			WelcomeScene.visible = false;
			
			if(!StartScene)
			{
				StartScene = new StartGame();
				addChild(StartScene);
				StartScene.initialize();
			}
		}
		
		/**
		 * GAME WELCOME SCENE 
		 * @param event
		 * 
		 */
		protected function onGameReady(event:Event):void
		{
			EndScene.visible = false;
			
			WelcomeScene.visible = true;
			WelcomeScene.initialize();
		}
		
		
		
		/**
		 * END GAME SCENE
		 * @param e
		 * 
		 */
		protected function onTimeIsUp(e:Event):void
		{
			removeChild(StartScene);
			StartScene = null;
			//StartScene.visible = false;
			
			EndScene.visible = true;
			EndScene.initialize();
			
		}
	}
}