package com.alptugan.experiments.extras.network
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.motionPaths.*;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;
	
	public class CreateField extends CasaSprite
	{

		private var ball:Ball;
		private var ball2:Ball;
		private var ballArr:Array = [];
		
		private var xNum:int = 20;
		private var yNum:int = 10;
		private var ballNum:int = xNum * yNum;
		
		private var Lines : Array = [];
		
		private var firstX:Array = [];
		private var firstY:Array = [];
		
		public function CreateField()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			ball = new Ball();
			addChild(ball);
			
			for(var i:int = 0; i < xNum; i++)
			{
				for(var j:int = 0; j < yNum; j++)
				{
					ball2 = new Ball();
					addChild(ball2);
					ball2.x = (ball.width) + i * 50;
					ball2.y = (ball.width) + j * 50;
					firstX.push(ball2.x);
					firstY.push(ball2.y);
					ballArr.push(ball2);
					
					
					with(graphics)
					{
						clear();
						lineStyle(1,0,Math.random()*0.5);
						moveTo(firstX[i],firstY[i]);
						lineTo(Math.random()*((ball.width) + i * 50),Math.random()*((ball.width) + j * 50));
					}
					
				}
			}
			
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(event:Event):void{
			ball.x = mouseX;
			ball.y = mouseY;
			var lastX : Number = 0;
			var lastY : Number = 0; 
			for(var i:int = 0; i < ballNum; i++)
			{
				var ball2:Ball = ballArr[i];
				var rad:Number = Math.atan2(ball2.y - mouseY, ball2.x - mouseX);
				var dist:Number = Math.sqrt(Math.pow(mouseX - ball2.x, 2) + Math.pow(mouseY - ball2.y, 2));
				var per:Number = 500 / dist;
				ball2.x += per * Math.cos(rad) + (firstX[i] - ball2.x) * 0.1;
				ball2.y += per * Math.sin(rad) + (firstY[i] - ball2.y) * 0.1;
				
				
				with(graphics)
				{
					clear();
					lineStyle(1,0,Math.random()*0.5);
					moveTo(ballArr[i].x,ballArr[i].y);
					lineTo( ball2.x, ball2.y);
				}
				
				if((ball.x - ballArr[i].x < 20) && (ball.x - ballArr[i].x > 0))
				{
					trace("jk");		
				}
			}
			
			
			
		}
		
	}
}



import flash.display.Sprite;
class Ball extends Sprite{
	function Ball(radian:int = 1, color:uint = 0x333333){
		graphics.beginFill(color);
		graphics.drawCircle(0, 0, radian);
		graphics.endFill()
	}
	
}



