package com.alptugan.experiments.extras
{
	import com.alptugan.experiments.extras.proximity.ProximityManager;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	public class ProximmityTest2 extends CasaSprite
	{
		
		protected var proximityManager:ProximityManager;
		protected var itemCount:uint=0;
		protected var bases:Vector.<DisplayObject>;
		protected var items:Vector.<DisplayObject>;
		protected var canvas:CasaShape;
		protected var resultVector:Vector.<DisplayObject>;
		
		
		public function ProximmityTest2()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			// we'll reuse this Vector for all of our getNeighbor calls:
			resultVector = new Vector.<DisplayObject>();
			
			// offsetting the bounds a little bit to put the bases near the center of a grid position:
			proximityManager = new ProximityManager(40,new Rectangle(0,0,stage.stageWidth,stage.stageHeight));
			
			// create "link" canvas:
			canvas = new CasaShape();
			addChild(canvas);
			
			// create our initial set of items:
			items = new Vector.<DisplayObject>();
			var l:uint=40;
			for (var i:uint=0; i<l; i++) {
				var item:Ship = new Ship();
				resetItem(item);
				item.x = Math.random()*550;
				item.y = Math.random()*550;
				item.graphics.beginFill(0,1);
				item.graphics.drawRect(-1,-1,2,2);
				items.push(item);
				
				addChild(item);
			}
			proximityManager.items = items;
			
			bases = items;
			
			// create bases:
			/*bases = new Vector.<CasaShape>();
			addBase(100,100);*/
			
			
			addEventListener(Event.ENTER_FRAME, tick);
			
		}
		
		protected function addBase(x:Number, y:Number):void {
			var base:CasaShape = new CasaShape();
			base.x = x;
			base.y = y;
			base.graphics.beginFill(0xFFFFFF,1);
			base.graphics.lineStyle(2,0xFF0000,1);
			base.graphics.drawCircle(0,0,7);
			addChild(base);
			bases.push(base);
		}
		
		protected function resetItem(item:Ship):void {
			item.x = (Math.random()>0.5) ? 275 : 0;
			item.y = (Math.random()>0.5) ? 275 : 0;
			item.velX = (Math.random()*4+0.1)*(Math.random()>0.5?1:-1);
			item.velY = (Math.random()*4+0.1)*(Math.random()>0.5?1:-1);
			item.alpha = 1;
		}
		
		
		protected function tick(evt:Event):void {
			var g:Graphics = canvas.graphics;
			g.clear();
			g.lineStyle(1,0xFF0000,1);
			
			var l:uint = items.length;
			for (var i:uint=0; i<l; i++) {
				var item:Ship = items[i] as Ship;
				item.x = (item.x+item.velX+550)%550;
				item.y = (item.y+item.velY+550)%550;
				
				
				
				
				
			}
			proximityManager.update();
		
			
			l = bases.length;
			for (i=0; i<l; i++) {
				var base:DisplayObject = bases[i];
				resultVector.length = 0;
				proximityManager.getNeighbors(base,1,resultVector);
				var jl:uint = resultVector.length;
				for (var j:uint=0; j<jl; j++) {
					item = resultVector[j] as Ship;
					item.alpha-=0.1;
					if (item.alpha<=0) {
						resetItem(item);
					} else {
						g.moveTo(base.x, base.y);
						g.lineTo(item.x,item.y);
					}
				}
				
			}
		}
	}
	
}

import flash.display.Shape;

class Ship extends Shape {
	public var velX:Number;
	public var velY:Number;
}