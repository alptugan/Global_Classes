/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : ContextMenu.as
 * Release Date : Oct 17, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/

/**
 * 
 *  USAGE
 * 	
 * */
/*


private function configureDebugUI():void
{
	debug = new AContextMenu(this);
	debug.addContextMenuItem("debug mode: off");
	debug.addContextMenuHandler(hide);
}

private function hide(e:Event):void
{
	if (debug.customItem[0].caption == "debug mode: off") 
	{
		debug.customItem[0].caption = "debug mode: on";
		UIHolder.visible = false;
	}else{
		debug.customItem[0].caption = "debug mode: off";
		UIHolder.visible = true;
	}
	
}


*/
package com.alptugan.utils
{
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class AContextMenu
	{
		private var cm:ContextMenu;
		public var customItem:Array = [];
		private var i:int = -1;
		
		public function AContextMenu(target:*)
		{
			// CONTEXT MENU SETUP
			cm = new ContextMenu();
			cm.hideBuiltInItems();
			target.contextMenu = cm;
			
		}
		
		public function addContextMenuItem(item:String) : void
		{	
			i++;
			customItem[i] = new ContextMenuItem(item);
			cm.customItems.push(customItem[i]);
		}
		
		public function addContextMenuHandler(listener:Function):void
		{
			customItem[i].addEventListener( ContextMenuEvent.MENU_ITEM_SELECT,listener);
		}
	}
}