// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 
package src.com.filikatasarim.cpm.serra.events
{
	import flash.events.Event;

	/**
	 * @author filika tasarim
	*/
	public class CategoryEvent extends Event
	{
		/** 
		 * 
		 */
		public static const CATEGORY_SELECTED:String = "CategoryEvent.category_selected";
		public static const CATEGORY_COMPLETE:String = "CategoryEvent.category_complete";

		private var _catName:String;
		private var _catId:String;
		
		public function CategoryEvent(type:String, catName:String, catId:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._catName = catName;
			this._catId = catId;
		}

		public function get catName():String
		{
			return this._catName;
		}

		public function set catName( value:String ):void
		{
			this._catName = value;
		}

		public function get catId():String
		{
			return this._catId;
		}

		public function set catId( value:String ):void
		{
			this._catId = value;
		}

		override public function clone():Event 
		{ 
			return new CategoryEvent(this.type, this._catName, this._catId, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("CategoryEvent", "type", "catName", "catId", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
