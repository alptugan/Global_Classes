package com.alptugan.experiments.extras.network
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;
	
	public class StarParticles extends CasaSprite
	{
		private var d:Number // distance from center
		private var r:Number // angle of travel in radians
		private var stageCenter:Point;
		private var speed:Number; // applies a random speed to stars so they do not all travel at the same speed.
		private var acceleration:Number = 1;
		private var _color:uint = 0xffffff;
			
		public function StarParticles()
		{
			this.alpha = 0;
			init();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//addEventListener(Event.ENTER_FRAME, update);
			stageCenter = new Point(stage.stageWidth / 2, stage.stageHeight / 2);
		}
		
		public function update(e:Event = null):void
		{
			d*= acceleration + (speed*0.025);
			alpha= 0.2+d/500; // fades in the stars as they get closer.
			x = stageCenter.x + Math.cos(r) * d ;
			y = stageCenter.y + Math.sin(r) * d ;
			// loop star when it goes off the stage.
			if (x > stageCenter.x *2 || x < 0 || y > stageCenter.y *2 || y < 0) {
				init()
			}
		}	
		
		private function init():void
		{
			// init values;
			r = Math.random() * 36;
			d = Math.random() * 150;
			speed = Math.random() * 0.0510;
			// draw circle
			this.graphics.clear();
			this.graphics.beginFill(_color);
			this.graphics.drawCircle(0, 0, speed*50);
		}
	}
}