/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : AHorizontalSlider.as
 * Release Date : Dec 8, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/

/*

//right Left Buttons
rigthBtn = new LeftRightButton({w:17,h:190,color:0xffffff,direction:"right",tw:5,th:9,tcolor:0x000000});
addChild(rigthBtn);


leftBtn = new LeftRightButton({w:17,h:190,color:0xffffff,direction:"left",tw:5,th:9,tcolor:0x000000});
addChild(leftBtn);


// Horizontal Slider
var slider:AHorizontalSlider = new AHorizontalSlider(itemsHolder,leftBtn,rigthBtn,items[0].width,items.length / 3,3);


*/
package com.alptugan.template
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class AHorizontalSlider
	{
		private var slideTo:Number = 0;
		private var target:DisplayObjectContainer;
		private var nbDisplayed:int;
		private var imageWidth:Number;
		private var totalImages:int;
		
		
		/**
		 * 
		 * @param target		: Target object to slide
		 * @param previous_btn	: Send your previous button as displayobject container
		 * @param next_btn		: Send your next button as displayobject container
		 * @param imageWidth    : Set the movement amount
		 * @param totalImages	: If you have multi-row images, you should set this with number of columns, Lets say you have 3 rows of images so, the number should be "number of images/number of rows"
		 * @param nbDisplayed	: set the number of images per click to be shown
		 * 
		 */
		public function AHorizontalSlider(target:DisplayObjectContainer,previous_btn:DisplayObject,next_btn:DisplayObject,imageWidth:Number,totalImages:int,nbDisplayed:int = 3)
		{
			this.target = target;
			this.nbDisplayed = nbDisplayed;
			this.imageWidth = imageWidth;
			this.totalImages = totalImages;
			previous_btn.addEventListener(MouseEvent.CLICK,slideLeft);
			next_btn.addEventListener(MouseEvent.CLICK,slideRight);
		}
		


		
		private function slideLeft(e:MouseEvent):void{
			slideTo -= nbDisplayed;
			slideContainer();
		}
		
		private function slideRight(e:MouseEvent):void{
			slideTo += nbDisplayed;
			slideContainer();
		} 
		
		private function slideContainer():void{
			if(totalImages - slideTo < nbDisplayed)
			{
				slideTo = totalImages - nbDisplayed;
				
			}
			
				
			if(slideTo < 0)
			{
				slideTo = 0;
			}
				
			
	
			
			TweenLite.to(target,.5,{x: -slideTo*imageWidth,ease:Expo.easeOut});
		}
		
	
	}
}