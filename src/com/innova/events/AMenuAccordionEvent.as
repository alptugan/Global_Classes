package src.com.innova.events
{
	import flash.events.Event;

	/**
	 * @author alp tugan
	*/
	public class AMenuAccordionEvent extends Event
	{
		/** 
		 * 
		 */
		public static const MENU_CLICKED:String = "AMenuAccordionEvent.menu_clicked";
		/** 
		 * 
		 */
		public static const MENU_ADDED_TO_STAGE:String = "AMenuAccordionEvent.menu_added_to_stage";
		/** 
		 * 
		 */
		public static const SUBMENU_CLICKED:String = "AMenuAccordionEvent.submenu_clicked";
		/** 
		 * 
		 */
		public static const SUBMENU_ADDED_TO_STAGE:String = "AMenuAccordionEvent.submenu_added_to_stage";

		private var _SelectedMenuId:int;
		private var _SelectedSubMenuId:int;
		private var _selectedMenuName:String;
		private var _selectedMenuType:String;
		
		public function AMenuAccordionEvent(type:String, SelectedMenuId:int, selectedMenuName:String, selectedMenuType:String, SelectedSubMenuId:int = 0,bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._SelectedMenuId = SelectedMenuId;
			this._SelectedSubMenuId = SelectedSubMenuId;
			this._selectedMenuName = selectedMenuName;
			this._selectedMenuType = selectedMenuType;
		}
		
		public function get SelectedSubMenuId():int
		{
			return this._SelectedSubMenuId;
		}
		
		public function get SelectedMenuId():int
		{
			return this._SelectedMenuId;
		}

		public function get selectedMenuName():String
		{
			return this._selectedMenuName;
		}

		public function get selectedMenuType():String
		{
			return this._selectedMenuType;
		}

		override public function clone():Event 
		{ 
			return new AMenuAccordionEvent(this.type, this._SelectedMenuId, this._selectedMenuName, this._selectedMenuType, this._SelectedSubMenuId, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("AMenuAccordionEvent", "type", "SelectedMenuId", "selectedMenuName", "selectedMenuType", "SelectedSubMenuId","bubbles", "cancelable", "eventPhase"); 
		}
	}
}
