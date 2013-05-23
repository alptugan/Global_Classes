package com.alptugan.experiments.extras.tentacles
{
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class Tentacle extends CasaSprite
	{
		private var main:Vector.<TentacleItem>;
		
		public function Tentacle()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		

		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			main = new Vector.<TentacleItem>(5,true);
			for(var i:int=0; i<main.length; i++)
			{
				main[i]= new TentacleItem(this);
				addChild(main[i]);
				main[i].resize(stage.stageWidth, stage.stageHeight);
			}
			
			stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(evt:Event):void 
		{
			for(var i:int=0; i<main.length; i++)
			{
				if(main[i])
				main[i].onEnterFrame();
			}
		}
		
		private function onResize(evt:Event):void 
		{
			for(var i:int=0; i<main.length; i++)
			{
				main[i].resize(stage.stageWidth, stage.stageHeight);
			}
		}
	}
}