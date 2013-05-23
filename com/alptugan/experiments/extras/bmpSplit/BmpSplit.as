package com.alptugan.experiments.extras.bmpSplit
{
	import com.alptugan.layout.Aligner;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import org.casalib.display.CasaSprite;
	
	public class BmpSplit extends CasaSprite
	{
		[Embed(source="assets/spacewo.jpg")]
		protected var ImageClass:Class;
		
		private var ImageBmp:Bitmap;
		private var sw:int;
		private var sh:int;
		
		
		//Split
		private var expand:Boolean = false;
		private var bitmapsArray:Array = new Array();
		
		
		public function BmpSplit()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			
			
			ImageBmp = new ImageClass() as Bitmap;
			
			addChild(ImageBmp);
			
			
			Aligner.alignCenterMiddleToBounds(ImageBmp,sw,sh);
			//addEventListener(Event.ENTER_FRAME, onFrame);
			//initSplit(ImageBmp.bitmapData,10,10);
			splitBitmap(ImageBmp.bitmapData,10,10);
			
		}
		
		private function initSplit(_source:BitmapData, _columns:int, _rows:int):void
		{
				
		}
		
		
		private function splitBitmap(_source:BitmapData, _columns:int, _rows:int):void
		{
			var _bitmapWidth:int = _source.width;
			var _bitmapHeight:int = _source.height;
			
			var _onePieceWidth:Number = Math.round(_bitmapWidth / _columns);
			var _onePieceHeight:Number = Math.round(_bitmapWidth / _rows);
			
			var _copyRect:Rectangle = new Rectangle(0, 0, _onePieceWidth, _onePieceHeight);
			for(var i:int = 0; i < _columns; i++)
			{
				var tempArray:Array = new Array();
				
				for(var j:int = 0; j < _rows; j++)
				{
					var _piece:String = "piece"+String(i)+String(j);
					var temp:* = [_piece];
					temp = new BitmapData(_onePieceWidth, _onePieceHeight, true, 0xFF0000CC);
					
					var newBytes:ByteArray = _source.getPixels(_copyRect);
					newBytes.position = 0;
					temp.setPixels(_copyRect, newBytes);
					
					var _newBitmap:String = "newBitmap"+String(i)+String(j);
					var tempBitmap:* = [_newBitmap];
					tempBitmap = new Bitmap(temp);
					
					tempBitmap.x = i * (_onePieceWidth) + ImageBmp.x;
					tempBitmap.y = j * (_onePieceHeight)+ ImageBmp.y;
					addChild(tempBitmap);
					
					tempArray.push(tempBitmap);
				}
				bitmapsArray.push(tempArray);
			}
		}
		
		private function onFrame(evt:Event):void
		{
			if(expand)
			{
				ImageBmp.alpha = 0;
				for(var k:uint = 0; k < bitmapsArray.length; k++)
				{
					var curr:uint = bitmapsArray[k].length;
					
					for(var l:uint = 0; l < curr; l++)
					{
						TweenLite.to(bitmapsArray[k][l],3,{x:20*l+10, y:33*k+10, alpha:0.5});
						expand = false;
						
					}
				}
			}
		}

		
	}
}