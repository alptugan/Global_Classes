package src.com.filikatasarim.games.soundgame.enemy
{
	import com.alptugan.drawing.shape.CircleShape;
	import com.alptugan.drawing.style.FillStyle;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;
	
	public class Enemy extends beee_Mc
	{
		//private var enemyObj:beee_Mc;
		private var _enemySpeed:Number = 3;
		private var _enemyBump:Boolean = false;
		private var _enemyDirection:Number = -1;
		private var _enemyY:Number = 200;
		private var _enemyOrigin :Number;
		public var id:int = 0;
		
		
		public function Enemy(_enemySpeed:Number,_enemyDirection:Number,_enemyY:Number,_enemyOrigin :Number)
		{
			this._enemySpeed = _enemySpeed;
			this._enemyDirection = _enemyDirection;
			this._enemyY = _enemyY;
			this._enemyOrigin = _enemyOrigin;
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		public function onRemoved(e:Event=null):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			
			null;
			trace("Scene Start is removed from stage\n-----------------------------------------------------");
		}
		
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			trace("Enemy "+id+" added to stage\n-----------------------------------------------------");
			
			// init
			initEnemy();
			
			// init Event Listeners
			initEventListeners();
		}
		
		private function initEnemy():void
		{
			/*var ko:CircleShape = new CircleShape(new Point(0,0),10,new FillStyle(0,1));
			addChild(ko);*/
			this.scaleX = this.scaleY = 0.5;
			if(_enemyDirection == -1)
			{
				this.scaleX = -0.5;
				this.x = 0;
			}else{
				this.scaleX = 0.5;
				this.x = stage.stageWidth;
			}
			
			this.y = _enemyOrigin;
		}
		
		
		public function update():void
		{
			if(this.x > stage.stageWidth - this.width*0.5)
			{
				enemyDirection = -1;
				this.scaleX = 0.5;
				enemyBump = false;
			}
			if(this.x - this.width*0.5 < 0){
				enemyBump = true;
				enemyDirection = 1;
				this.scaleX = -0.5;
			}
			
			this.x  += enemySpeed*enemyDirection;
			//this.x = stage.stageWidth - this.width >> 1;
		}
		
		
		private function initEventListeners():void
		{
			
		}
		
		// GETTER and SETTERS
		public function get enemySpeed():Number
		{
			return _enemySpeed;
		}

		public function set enemySpeed(value:Number):void
		{
			_enemySpeed = value;
		}

		public function get enemyBump():Boolean
		{
			return _enemyBump;
		}

		public function set enemyBump(value:Boolean):void
		{
			_enemyBump = value;
		}

		public function get enemyDirection():Number
		{
			return _enemyDirection;
		}

		public function set enemyDirection(value:Number):void
		{
			_enemyDirection = value;
		}

		public function get enemyY():Number
		{
			return _enemyY;
		}

		public function set enemyY(value:Number):void
		{
			_enemyY = value;
		}

		public function get enemyOrigin():Number
		{
			return _enemyOrigin;
		}

		public function set enemyOrigin(value:Number):void
		{
			_enemyOrigin = value;
			this.y = value;
		}


	}
}