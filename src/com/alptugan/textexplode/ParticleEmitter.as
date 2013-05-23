
package src.com.alptugan.textexplode
{
	import com.alptugan.utils.maths.MathUtils;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	public class ParticleEmitter extends Sprite
	{
		
		/*
		========================================================
		| Private Variables                         | Data Type  
		========================================================
		*/
		
		private var _emitterRate:                   int;
		
		private var _particleLifeMin:               int;
		private var _particleLifeMax:               int;
		
		private var _particleSizeMin:               Number;
		private var _particleSizeMax:               Number;
		
		private var _gravity:                       Number;
		private var _speed:                         Number;
		private var _spray:                         Number;
		private var _wind:                          Number;
		
		private var _particles:                     Array;
		private var _particle:                      String;
		private var _method:                        String;
		
		private var _timer:                         Timer;
		
		/*
		========================================================
		| Public Variables                          | Data Type  
		========================================================
		*/
		
		public var emitting:                        Boolean = false;
		
		/*
		========================================================
		| Constructor
		========================================================
		*/
		private var len:Object;
		private var facSize:Number;

		private var size:Number;
		public function ParticleEmitter( stage:Stage, show:Boolean, rate:int, speed:Number, life:Array, size:Array, spray:Number, gravity:Number, wind:Number, method:String ) 
		{
			_emitterRate = 1000 / rate;
			_method = method; // Not yet implimented
			
			_gravity = gravity;
			_speed = speed / 100;
			_spray = spray;
			_wind = wind;
			
			_particleLifeMin = life[0] * stage.frameRate;
			_particleLifeMax = life[1] * stage.frameRate;
			
			_particleSizeMin = size[0];
			_particleSizeMax = size[1];
			
			_particles = new Array();
			
			if( show ) showEmitter();
		}
		
		/*
		========================================================
		| Private Methods
		========================================================
		*/
		
		private function emit( event:TimerEvent ):void
		{
			var rIndex:int = MathUtils.getRandomInt(0,Globals.Style.word.length()-1);

			var life:int = randomBetween( _particleLifeMin, _particleLifeMax, true );
			size = randomBetween( _particleSizeMin, _particleSizeMax );
			
			
			var particle:ATextSingleLineExplode =new ATextSingleLineExplode(Globals.Style.word[rIndex].toString().toUpperCase(),Globals.css[0].name,Globals.css[0].color,Globals.css[0].size,true,false,false,life,0.1 );
			addChild( particle );
			
			
			
			/*var ct:ColorTransform = new ColorTransform();
			ct.color = random( 0xFFFF00 );
			ct.color = 0xffffff;
			particle.transform.colorTransform = ct;*/
			
			particle.vx = randomBetween( -_spray, _spray ) / 10;
			particle.vy = randomBetween( -_spray, _spray ) / 10;
			particle.vr = randomBetween( -1, 1 );
			
			_particles.push( particle );
			
			len = Globals.Style.word.length();
		}
		
		private function render( event:Event ):void
		{
			for ( var i:int = 0; i < _particles.length; i++ ) 
			{
				var particle:ATextSingleLineExplode = _particles[i];
				
				// Move
				
				particle.x += particle.vx;
				particle.y += particle.vy;
				// Rotate
				
				particle.rotation += particle.vr;
				particle.scaleX=particle.scaleY += 0.02;
				// Set properties
				
				particle.vx += randomBetween( -_speed, _speed );
				particle.vy += randomBetween( -_speed, _speed );
				
				if( particle.age < 20 ) particle.alpha += .01;
				if( particle.age > particle.life - 20 ) particle.alpha -= .01;
				
				// Atmospherics
				
				particle.vx += _wind / 20;
				particle.vy += _gravity / 20;
				
				// Age
				
				if( particle.age >= particle.life || particle.x < 0 - x || particle.x > stage.stageWidth - x || particle.y < 0 - y || particle.y > stage.stageHeight - y )
				{
					kill( i );
				}
				else
				{
					particle.age ++
				}
			}
			
			dispatchEvent( new Event( 'UPDATE' ) );
		}
		
		private function kill( i:int ):void
		{
			TweenLite.to(_particles[i],0.4,{alpha:0,onComplete:function():void{
				_particles[i].destroy();
				removeChild( _particles[i] );
				_particles[i] = null;
				_particles.splice( i, 1 );
				
				
				if( _particles.length == 0 ) end();
			
			}});
		
		}
		
		private function end():void
		{
			trace( 'Particle rendering stopped' );
			removeEventListener( Event.ENTER_FRAME, render );
		}
		
		private function showEmitter():void
		{
			var emitter:Sprite = new Sprite();
			
			emitter.graphics.beginFill( 0x000000, .2 );
			emitter.graphics.drawCircle( 0, 0, 10 );
			emitter.graphics.endFill();
			
			addChild( emitter );
		}
		
		private function random( num:Number, round:Boolean = false ):Number
		{
			var n:Number = Math.random() * num;
			if( round ) { return n<<0 };
			return n;
		}
		
		private function randomBetween( num1:Number, num2:Number, round:Boolean = false ):Number
		{
			var n:Number = num1 + Math.random() * ( num2 - num1 );
			if( round ) { return n<<0 };
			return n;
		}
		
		/*
		========================================================
		| Public Methods
		========================================================
		*/
		
		public function init():void
		{
			emitting = true;
			
			_timer = new Timer( _emitterRate );
			_timer.addEventListener( TimerEvent.TIMER, emit );
			_timer.start();
			
			addEventListener( Event.ENTER_FRAME, render );
			stage.addEventListener( MouseEvent.CLICK, handleMouseClick);
		}
		private function handleMouseClick( event:MouseEvent ): void
		{
			for(var i:int = 0; i<len; i++)
			{
				if( !_particles[i])
				{
					if ( _particles[i].assembled )	
					{
						_particles[i].explode( 4, null, Math.random()*stage.stageHeight )
					} else {
						_particles[i].assemble();
					}
				}
				
			}
			
		}
		
		public function stop():void
		{
			emitting = false;
			_timer.stop();
		}
		
		/*
		========================================================
		| Getters + Setters
		========================================================
		*/
		
		public function get particles():int
		{
			return _particles.length;
		}
		
		public function set emitterRate( n:int ):void
		{
			_timer.delay = _emitterRate = _emitterRate = 1000 / n;
		}
		
		public function set spray( n:Number ):void
		{
			_spray = n;
		}
		
		public function set wind( n:Number ):void
		{
			_wind = n;
		}
		
		public function set gravity( n:Number ):void
		{
			_gravity = n;
		}
		
	}
	
}
