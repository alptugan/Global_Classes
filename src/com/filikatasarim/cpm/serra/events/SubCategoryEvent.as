// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 
package src.com.filikatasarim.cpm.serra.events
{
	import flash.events.Event;

	/**
	 * @author filika tasarim
	*/
	public class SubCategoryEvent extends Event
	{
		/** 
		 * 
		 */
		public static const SUBCATEGORY_SELECTED:String = "SubCategoryEvent.subcategory_selected";
		public static const SUBCATEGORY_COMPLETE:String = "SubCategoryEvent.subcategory_complete";

		private var _subcatName:String;
		private var _subcatId:String;
		
		public function SubCategoryEvent(type:String, subcatName:String, subcatId:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._subcatName = subcatName;
			this._subcatId = subcatId;
		}

		public function get subcatName():String
		{
			return this._subcatName;
		}

		public function set subcatName( value:String ):void
		{
			this._subcatName = value;
		}

		public function get subcatId():String
		{
			return this._subcatId;
		}

		public function set subcatId( value:String ):void
		{
			this._subcatId = value;
		}

		override public function clone():Event 
		{ 
			return new SubCategoryEvent(this.type, this._subcatName, this._subcatId, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("SubCategoryEvent", "type", "subcatName", "subcatId", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
