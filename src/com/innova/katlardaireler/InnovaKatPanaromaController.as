package src.com.innova.katlardaireler
{
	import com.alptugan.display.CreateMask;
	import com.alptugan.layout.Aligner;
	import com.alptugan.utils.maths.MathUtils;
	import com.bigspaceship.utils.MathUtils;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	import org.casalib.util.StringUtil;
	
	import src.com.innova.Globals;
	import src.com.innova.panaroma.DonButtonClass;
	import src.com.innova.panaroma.UzaklasButtonClass;
	import src.com.innova.panaroma.YakinlasButtonClass;
	
	public class InnovaKatPanaromaController extends CasaSprite
	{
		[Embed(source="assets/images/grid2.jpg")]
		protected var GridClass:Class;
		
		[Embed(source="assets/images/panaroma/left.png")]
		protected var LeftClass:Class;
		
		[Embed(source="assets/images/panaroma/right.png")]
		protected var RightClass:Class;
		
		[Embed(source="assets/images/panaroma/up.png")]
		protected var UpClass:Class;
		
		[Embed(source="assets/images/panaroma/down.png")]
		protected var DownClass:Class;
		
		private var down:CasaSprite;
		
		
		
		private var up:CasaSprite;
		
		
		private var right:CasaSprite;
		
		
		private var left:CasaSprite;
		
		
		private var bounds:Rectangle;
		
		
		//private var grid:CasaSprite;
				
		private var maske:Shape;
		private var contHolder:CasaSprite;
		private var dragging:Boolean;

		private var posx:Number;

		private var posy:Number;

		private var prePosx:Number;

		private var prePosy:Number;
		private var gridsX:Number;
		private var gridsY:Number;
		private var maske2:Shape;

		private var rotateX:int;
		private var rotateY:int;
		
		public var grid:StarField;

		private var DonBtn:DonButtonClass;

		private var yakin:YakinlasButtonClass;

		private var uzak:UzaklasButtonClass;
		
		private var ZoomHolder:CasaSprite = new CasaSprite();

		private var val:Number = 70;
		private var sal:Number = 49;
		public var _interval:Interval;
		private var pal:Number = 0;
		private var lastX:Number = 0;

		private var donOff:Boolean = false;
		private var info:String ;
		
		private var vhMax:Number = 66;
		private var vhMin :Number = 34;
		
		private var vvMax:Number = 9;
		private var vvMin :Number = -7;
		
		private var curHVal:Number = 66;
		private var isEnd:Boolean = false;
		
		public function InnovaKatPanaromaController(info:String)
		{
			this.info = info;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		
		
		public function resett(newInfo:String):void
		{
			this.info = newInfo;
			val = 70;
			sal = 49;
			pal = 0;
			curHVal = 66;
			lastX = 0;
			grid.x = 0;
			grid.y =0 ;
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			//this.DonBtn._interval.destroy();
			if(_interval)
				_interval.destroy();
			
			ZoomHolder.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownController);
			ZoomHolder.removeEventListener(MouseEvent.MOUSE_UP,onMouseUpController);
			grid.removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
			grid.removeEventListener(MouseEvent.MOUSE_UP,onUp);
			grid.removeEventListener(Event.ENTER_FRAME, trackMousePos);
			
			removeEventListeners();
			
			while(this.numChildren > 0)
				removeChildAt(0);
			
			//trace('InnovaKatPanaromaController is removed from stage');
		}		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			/*
			grid = new CasaSprite();
			addChild(grid);*/
			
			/*grid.addChild(new GridClass() as Bitmap);
			var bmp2:Bitmap = new  GridClass() as Bitmap;
			grid.addChild(bmp2);
			bmp2.alpha = 0.8;
			bmp2.x = -bmp2.width;*/
			
			grid = new StarField();
			// Add Everyone to the stage!
			addChild(grid);
			
			maske = CreateMask.Create(0,0,797,448);
			addChild(maske);
			
			grid.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			grid.addEventListener(MouseEvent.MOUSE_UP,onUp);
			
			grid.mask = maske;
			
			//Controller
			contHolder = new CasaSprite();
			addChild(contHolder);
			contHolder.alpha = 0.5;
			//left
			left = new CasaSprite();
			contHolder.addChild(left);
			left.y = 73;
			left.addChild(new LeftClass() as Bitmap);
			
			//right
			right = new CasaSprite();
			contHolder.addChild(right);
			right.x = 257;
			right.y = left.y;
			right.addChild(new RightClass() as Bitmap);
			
			//up
			up = new CasaSprite();
			contHolder.addChild(up);
			up.x = 112;
			up.addChild(new UpClass() as Bitmap);
			
			//down
			down = new CasaSprite();
			contHolder.addChild(down);
			down.y = 177;
			down.x = up.x;	
			down.addChild(new DownClass() as Bitmap);
			
			Aligner.alignCenter(contHolder,maske);

			addChild(ZoomHolder);
			
			DonBtn = new DonButtonClass();
			ZoomHolder.addChild(DonBtn);
			DonBtn.name = "don";
			DonBtn.y = 16;
			DonBtn.x = 323;
			
			yakin = new YakinlasButtonClass();
			yakin.name = "yakin";
			ZoomHolder.addChild(yakin);
			
			yakin.x = DonBtn.x + DonBtn.width + 9;
			yakin.y = DonBtn.y;
			
			uzak = new UzaklasButtonClass();
			uzak.name = "uzak";
			ZoomHolder.addChild(uzak);
			uzak.y = DonBtn.y;
			uzak.x = yakin.x + yakin.width + 9;
			
			ZoomHolder.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownController);
			ZoomHolder.addEventListener(MouseEvent.MOUSE_UP,onMouseUpController);
			DonBtn.addEventListener(Event.ENTER_FRAME, AutoplayPos);
			//checkExt();
			
		}
		
		private function checkExt():void
		{
			
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("onClickPanaromaZoom",StringUtil.contains(info,"Manzara") ? 52 : 70);
			}else{
				checkExt();
			}
		}
		
		protected function onMouseUpController(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "don":
				{
					
					break;
				}
					
				case "yakin":
				{
					//!this._interval.destroyed ? this._interval.destroy() : void;
					yakin.onMouseUp();
					break;
				}
					
				case "uzak":
				{
					//!this._interval.destroyed ? this._interval.destroy() : void;
					
					uzak.onMouseUp();
					break;
				}
					
					
			}
		}
		
		protected function onMouseDownController(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "don":
				{
					DonBtn.switchOnOff();
					if(DonBtn.bolSwitch)
					{
						DonBtn.addEventListener(Event.ENTER_FRAME, AutoplayPos);
					}else{
						DonBtn.removeEventListener(Event.ENTER_FRAME, AutoplayPos);
					}
					break;
				}
					
				case "yakin":
				{
					yakin.onMouseDown();
					/*this._interval = Interval.setInterval(this._repeatingFunction, 10,'yakin');
					this._interval.repeatCount = 1;
					this._interval.start();*/
					_repeatingFunction('yakin');
					break;
				}
					
				case "uzak":
				{
					
					/*this._interval = Interval.setInterval(this._repeatingFunction, 10,'uzak');
					this._interval.repeatCount = 1;
					this._interval.start();*/
					uzak.onMouseDown();
					_repeatingFunction('uzak');
					break;
				}
					
				
			}
		}
		
		
		
		private function _repeatingFunction(str:String):void
		{
			
			
			if (ExternalInterface.available) 
			{
				if(str=='yakin')
				{
					if(StringUtil.contains(info,"Manzara"))
					{
						if(sal < 5 )
						{
							sal = 5;
							this._interval.destroy();
						}else{
							sal = sal - 0.5;
						}
					}else{
						if(val < 10)
						{
							val = 10;
							this._interval.destroy();
						}else{
							val = val - 0.5;
						}
					}
					
					
				}else{
					if(StringUtil.contains(info,"Manzara"))
					{
						if(sal > 52)
						{
							sal = 52;
							this._interval.destroy();
						}else{
							sal = sal + 0.5;
						}
					}else{
						if(val > 120)
						{
							val = 120;
							this._interval.destroy();
						}else{
							val = val + 0.5;
						}
					}
					
				}
				ExternalInterface.call("onClickPanaromaZoom",StringUtil.contains(info,"Manzara") ? sal : val);
			}
			
			/*this._interval.reset();
			this._interval.start();*/
		}
		
		protected function onUp(e:MouseEvent):void
		{

			if(dragging)
			{
				dragging = false;
				TweenMax.to(contHolder,0.5,{tint:null});
				grid.removeEventListener(Event.ENTER_FRAME, trackMousePos);
				stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
				lastX = rotateX;
			}
		}
		
		protected function onDown(e:MouseEvent):void
		{			
			
			if(DonBtn.bolSwitch == true)
			{
				DonBtn.switchOnOff();
				if(StringUtil.contains(info,"Manzara"))
				{
					
					grid.x = curHVal;
					grid.y = vvMin;
				}else{
					grid.x = pal;
					grid.y = 0;
				}
				
				donOff = true;
				DonBtn.removeEventListener(Event.ENTER_FRAME, AutoplayPos);
			}
			
			grid.addEventListener(Event.ENTER_FRAME, trackMousePos);
			stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
			
			
			gridsX = grid.x;
			gridsY = grid.y;
			
			prePosx = maske.mouseX;
			prePosy = maske.mouseY;
			
			dragging = true;
			TweenMax.to(contHolder,0.5,{tint:0x7ac4e0});
		}		
		
		public function AutoplayPos(e:Event):void
		{
			
			if(StringUtil.contains(info,"Manzara"))
			{
			
				if(isEnd)
				{
					curHVal = curHVal + 0.1;
				}else{
					curHVal = curHVal - 0.1;
				}
				
				
				if(curHVal < vhMin )
					isEnd = true;
				
				if(curHVal > vhMax )
					isEnd = false;
				
				ExternalInterface.call('onClickPanaromaMove',curHVal,vvMin);
				
			}else{
				pal = lastX + 0.1;
				lastX = pal;
				ExternalInterface.call('onClickPanaromaMove',lastX,0);
			}
			
			
			
			
		}
		
		public function trackMousePos(event:Event):void
		{	
				posx =maske.mouseX;
				posy =maske.mouseY;
				
				
				
				if(StringUtil.contains(info,"Manzara"))
				{
					if(curHVal > 33 && curHVal < 67)
					{
						grid.x = gridsX+(posx-prePosx)*0.05;
						grid.y = gridsY+(posy-prePosy)*0.05;
						
						rotateX = (grid.x);
						rotateY = (grid.y);
						
						curHVal = rotateX;
						
						grid.drawCanvas(-grid.x,-grid.y);
						ExternalInterface.call( "onClickPanaromaMove",rotateX,rotateY );
					}
					
					if(curHVal < 34)
					{
						curHVal = gridsX=34;
					}
						
					
					if(curHVal > 66)
						curHVal = gridsX=66;
				}else{
					
					grid.x = gridsX+(posx-prePosx);
					grid.y = gridsY+(posy-prePosy);
					
					rotateX = (grid.x);
					rotateY = (grid.y);
					
					lastX = rotateX;
					grid.drawCanvas(-grid.x,-grid.y);
					ExternalInterface.call( "onClickPanaromaMove",lastX,rotateY );
				}
				
				
				
				
				
				
				/*rotateX = ( 359*(pal+grid.x)/grid.width);
				rotateY = ( 359*grid.y/grid.height);*/
		}
		
	}
}