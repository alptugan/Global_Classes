// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 
package  src.com.filikatasarim.games.soundgame.events
{
	import flash.events.Event;

	/**
	 * @author filika
	*/
	public class GameEvents extends Event
	{
		/** 
		 * 
		 */
		public static const GAME_READY:String = "GameEvents.game_ready";
		/** 
		 * 
		 */
		public static const GAME_END:String = "GameEvents.game_end";
		/** 
		 * 
		 */
		public static const GAME_REMOVED:String = "GameEvents.game_removed";
		/** 
		 * 
		 */
		public static const GAME_STARTED:String = "GameEvents.game_started";
		/** 
		 * 
		 */
		public static const TIME_IS_UP:String = "GameEvents.time_is_up";

		
		public function GameEvents(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
		}

		override public function clone():Event 
		{ 
			return new GameEvents(this.type, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("GameEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
