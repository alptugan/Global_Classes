/* Blurry Lights Animation */
/* Developed by Carlos Yanez */

package src.com.alptugan.textexplode
{
	/* Import required classes */
	
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.events.Event;
	
	public class Bokeh extends MovieClip
	{
		/* Vars */
		
		private var lightsNumber:int;
		private var xSpeed:int;
		private var ySpeed:int;
		private var lightsDir:String;
		private var areaW:int;
		private var areaH:int;
		private var lights:Array = new Array();
		
		/* Main function */
		
		public function init(areaWidth:int, areaHeight:int, numberOfLights:int, lightSize:int, lightColor:uint, minimumScale:Number, hSpeed:int, vSpeed:int, dir:String, quality:int):void
		{
			
			/* Set variables */
			
			areaW = areaWidth;
			areaH = areaHeight;
			lightsNumber = numberOfLights;
			lightsDir = dir;
			
			/* Use a for to create the parameter-specified number of lights*/
			
			for (var i:int = 0; i < numberOfLights; i++)
			{
				/* Create the specified number of lights */
				
				var light:MovieClip = new MovieClip();
				
				/* Set random speed to x and y based on the params*/
				
				xSpeed = Math.floor((Math.random() * (hSpeed - -hSpeed + 1)) + -hSpeed);
				ySpeed = Math.round((Math.random() * vSpeed) + 0.5);
				
				light.xSpeed = xSpeed;
				light.ySpeed = ySpeed;
				
				/* Create lights */
				
				light.graphics.beginFill(lightColor);
				light.graphics.drawCircle(0, 0, lightSize / 2);
				light.graphics.endFill();
				
				/* Set a position based on the params specified */
				
				light.x = Math.floor(Math.random() * areaWidth);
				light.y = Math.floor(Math.random() * areaHeight);
				
				/* Add blur, we declare the var here to get a new blur w/every light */
				
				var b:int = Math.floor(Math.random() * 10) + 5;
				
				var blur:BitmapFilter = new BlurFilter(b,b,quality);
				
				var filterArray:Array = new Array(blur);
				
				light.filters = filterArray;
				
				/* Change alpha */
				
				light.alpha = Math.random() * 0.6 + 0.1;
				
				/* Scale */
				
				light.scaleX = Math.round(((Math.random() * (1 - minimumScale)) + minimumScale) * 100) / 100;
				light.scaleY = light.scaleX;
				
				/* Add the lights */
				
				addChild(light);
				
				/* Store lights in an array to use it later */
				
				lights.push(light);
				
				/* Check for lights direction */
				
				checkDirection();
			}
		}
		
		/* Check direction */
		
		private function checkDirection():void
		{
			for (var i:int = 0; i < lights.length; i++)
			{
				switch ( lightsDir )
				{
					case "up" :
						
						lights[i].addEventListener(Event.ENTER_FRAME, moveUp);
						
						break;
					case "down" :
						
						lights[i].addEventListener(Event.ENTER_FRAME, moveDown);
						
						break;
					case "right" :
						
						lights[i].addEventListener(Event.ENTER_FRAME, moveRight);
						
						break;
					case "left" :
						
						lights[i].addEventListener(Event.ENTER_FRAME, moveLeft);
						
						break;
					default :
						
						trace("Something weird just happened!");
				}
			}
		}
		
		/* Move Up function */
		
		private function moveUp(e:Event):void
		{
			e.target.x += e.target.xSpeed;
			e.target.y-=e.target.ySpeed;
			
			/* Reset light position, Y first, then X  */
			
			if (e.target.y + (e.target.height / 2) < 0)
			{
				e.target.y = areaH + (e.target.height / 2);
				e.target.x=Math.floor(Math.random()*areaW);
			}
			
			if ((e.target.x + e.target.width / 2) < 0 || (e.target.x - e.target.width / 2) > areaW)
			{
				e.target.y = areaH + (e.target.height / 2);
				e.target.x=Math.floor(Math.random()*areaW);
			}
		}
		
		/* Move Down function */
		
		private function moveDown(e:Event):void
		{
			e.target.x+=e.target.xSpeed;
			e.target.y+=e.target.ySpeed;
			
			/* Reset light position, Y first, then X */
			
			if (e.target.y - (e.target.height / 2) > areaH)
			{
				e.target.y = 0 - (e.target.height / 2);
				e.target.x=Math.floor(Math.random()*areaW);
			}
			
			if ((e.target.x + e.target.width / 2) < 0 || (e.target.x - e.target.width / 2) > areaW)
			{
				e.target.y = areaH + (e.target.height / 2);
				e.target.x=Math.floor(Math.random()*areaW);
			}
		}
		
		/* Move Right function */
		
		private function moveRight(e:Event):void
		{
			e.target.x+=e.target.ySpeed;
			e.target.y+=e.target.xSpeed;
			
			/* Reset light position, Y first, then X */
			
			if (e.target.y - (e.target.height / 2) > areaH || e.target.y + (e.target.height / 2) < 0)
			{
				e.target.x = 0 - (e.target.height / 2);
				e.target.y = Math.floor(Math.random()*areaH);
			}
			
			if ((e.target.x - e.target.width / 2) > areaW)
			{
				e.target.x = 0 - (e.target.height / 2);
				e.target.y = Math.floor(Math.random()*areaW);
			}
		}
		
		/* Move Left function */
		
		private function moveLeft(e:Event):void
		{
			e.target.x-=e.target.ySpeed;
			e.target.y-=e.target.xSpeed;
			
			/* Reset light position, Y first, then X */
			
			if (e.target.y - (e.target.height / 2) > areaH || e.target.y + (e.target.height / 2) < 0)
			{
				e.target.x = areaW + (e.target.width / 2);
				e.target.y=Math.floor(Math.random()*areaH);
			}
			
			if ((e.target.x + e.target.width / 2) < 0)
			{
				e.target.x = areaW + (e.target.width / 2);
				e.target.y=Math.floor(Math.random()*areaW);
			}
		}
	}
}