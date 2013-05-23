package com.alptugan.experiments.extras.network
{
	import com.s2paganini.kinect.MultiTouchKinect;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	
	import org.casalib.display.CasaSprite;
	import org.tuio.TuioCursor;
	
	import src.com.galea.FullBrowserSlideShow;
	
	
	
	
	public class Connection extends MultiTouchKinect
	{
		
		[Embed(source="assets/bg.jpg")]
		protected var BgClass:Class;
		
		private var holder:CasaSprite;
		
		
		private var netHolder:CasaSprite;
		
		public var Particles:Array;
		public var ball:Ball;
		public var numParticle:int = 8;
		
		public var minDist:Number = 100;
		public var spring:Number = 0.005;
		public var size:int = 40;
		
		private var colorBall:uint = 0x0efeff;
		private var colorLine:uint = 0x0efeff;
		
		/*private var colorBall:uint = 0xFF00FF;
		private var colorLine:uint = 0xFF00FF;*/
		
		private var sW:int;
		private var sH:int;

		private var s:Vector.<StarParticles> = new Vector.<StarParticles>;

		private var dx:Number;

		private var dy:Number;

		private var dist:Number;
		
		
		private var ss:FullBrowserSlideShow;
		
		
		public function Connection()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			sW = stage.stageWidth;
			sH = stage.stageHeight;
			
			addBg();
			addPeople();
		}
		
		
		
		private function addPeople():void
		{
			/*
			holder = new CasaSprite();
			addChild(holder);
			
			
			
			holder.addChild(new BgClass() as Bitmap);
			*/
			
			netHolder = new CasaSprite();
			addChild(netHolder);
			//netHolder.blendMode = BlendMode.ADD;
			Particles =[];
			/*for (var i:int = 0; i <numParticle; i++){
				Particles.push(new Ball(size,colorBall));
				Particles[i].mass = size;
				Particles[i].alpha = 1;
				Particles[i].x = Math.random() * sW;
				Particles[i].y = Math.random() * sH;
				Particles[i].vx = Math.random()* 6 - 3;
				Particles[i].vy = Math.random() * 6 - 3;
				netHolder.addChild(Particles[i]);
				
				Particles[i].filters = [new GlowFilter(colorBall,1,20,20)]
			}*/
			
			for (var j:int = 0; j < 150; j++) 
			{
				s[j] = new StarParticles();
				s[j].x = Math.random() * sW;
				s[j].y = Math.random() * sH;
				netHolder.addChild(s[j]);
			}
			
			
			
			netHolder.addEventListener(Event.ENTER_FRAME, onenterframe);
		}
		
		//======================================================================================================================
		// ADD BACKGROUND DATA
		//======================================================================================================================
		private function addBg():void
		{
			ss = new FullBrowserSlideShow();
			addChildAt(ss,0);
			//ss.addEventListener(FullBrowserXShow.BG_LOADED, handleLoadedEvent);
		}
		
		public function onenterframe(e:Event):void{
			for (var i:int = 0;i < numParticle;i++){
				Particles[i].x += Particles[i].vx;
				Particles[i].y += Particles[i].vy;
				if (Particles[i].x >sW + Particles[i].width/2){
					Particles[i].x =0;
				} else if (Particles[i].x < -Particles[i].width){
					Particles[i].x = sW;	
				}
				if (Particles[i].y > sH + Particles[i].height/2){
					Particles[i].y = 0;
				} else if (Particles[i].y < -Particles[i].height) {
					Particles[i].y = sH;	
				}
			}
			
			for (var j:int = 0; j < 150; j++) 
			{
				s[j].update();
			}
			
			netHolder.graphics.clear();
			particleLineAll();   		
		}
		
		public function Spring(pA:Ball,pB:Ball):void{
			dx = pB.x - pA.x;
			dy = pB.y - pA.y;
			dist = Math.sqrt(dx * dx + dy * dy);
			
			if (dist < minDist){
				var ax:Number = dx * spring;
				var ay:Number = dy * spring;
				pA.vx += ax / pA.mass;
				pA.vy += ay / pA.mass;
				pB.vx -= ax / pB.mass;
				pB.vy -= ay / pB.mass;
			}
		}
		
		/*public function particleLine():void{
			for (var i:int = 0;i < numParticle; i++){
				graphics.lineStyle(1,colorLine);
				graphics.lineTo(Particles[i].x, Particles[i].y);
				graphics.moveTo(Particles[i].x, Particles[i].y);
			}
		}*/
		
		public function particleLineAll():void{
			
			for (var i:int = 0;i < numParticle; i++)
			{
				var j :int = i + 1;
				for (j; j < numParticle; j++) 
				{
						Spring(Particles[i],Particles[j]);						
						netHolder.graphics.lineStyle(7-Math.floor(dist/100),colorLine,1 - (dist/1000));
						netHolder.graphics.moveTo(Particles[i].x, Particles[i].y);
						netHolder.graphics.lineTo(Particles[j].x, Particles[j].y);
						
				}	
			}
			
			
		}
		
		//======================================================================================================================
		// TUIO KINECT METHODS
		//======================================================================================================================
		public var  xMax:Number = 1.,
			yMax:Number = 1.,
			xMin:Number = 0.,
			yMin:Number = 0.;
		
		public var TUIO_X:Number = 0;
		public var TUIO_Y:Number = 0;
		private var xPos:int;
		private var yPos:Number;
		
		private var active:Boolean = false;
		private var i:int = 0;
		
		override public function addTuioCursor(tuioCursor : TuioCursor) : void
		{
			//new Ring(tuioCursor.sessionID.toString(), this, tuioCursor.x * stage.stageWidth, tuioCursor.y * stage.stageHeight, 30);
			if(!active)
			{
				if(tuioCursor.x < xMin || tuioCursor.x > xMax || tuioCursor.y < yMin || tuioCursor.y > yMax)
				{
				}else{
					getPos(tuioCursor.x,tuioCursor.y);
					addParticle();
					
				}
				TUIO_X = tuioCursor.x;
				TUIO_Y = tuioCursor.y;
				active = true;
			}
			
			
		}
		
		private function addParticle():void
		{
			
			Particles.push(new Ball(size,colorBall));
			Particles[i].mass = size;
			Particles[i].x = xPos;
			Particles[i].y = yPos;
			
			netHolder.addChild(Particles[i]);
			
			Particles[i].filters = [new GlowFilter(colorBall,1,20,20)];
			i++;
		}
		
		private function removeParticle():void
		{
			
			//netHolder.removeChild(Particles[i]);
			
		
		}
		
		private function getPos(_x:Number,_y:Number):void
		{
			xPos = /*stage.stageWidth -*/ (_x - xMin) / (xMax - xMin) * stage.stageWidth;
			yPos = stage.stageHeight - (_y-yMin) / (yMax - yMin) * stage.stageHeight;
			
			/*star.x = xPos;
			star.y = yPos;*/
			
		}
		
		override public function updateTuioCursor(tuioCursor : TuioCursor) : void
		{
			try
			{
				if(tuioCursor.x < xMin || tuioCursor.x > xMax || tuioCursor.y < yMin || tuioCursor.y > yMax)
				{
				}else{
					getPos(tuioCursor.x,tuioCursor.y);
				}
				
			}
			catch(e : Error)
			{
			}
		}
		
		override public function removeTuioCursor(tuioCursor : TuioCursor) : void
		{
			try
			{
				active = false;
			}
			catch(e : Error)
			{
			}
		}
	}
}

import com.alptugan.preloader.PreloaderMacStyle;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.casalib.display.CasaSprite;

class Ball extends Sprite {
	
	public var mass:int;
	public var vx:Number;
	public var vy:Number;
	
	private var timer:Timer = new Timer(65);
	private var slices:int;
	private var radius:int;
	private var holder:CasaSprite;
	private var color:uint;
	
	public function Ball (r:Number = 5,color:uint = 0x000000){
		/*cacheAsBitmap = true;
		graphics.lineStyle(5,color);
		graphics.beginFill(color);
		graphics.drawCircle(0,0,r);
		graphics.endFill();*/
		

		this.slices = 20;
		this.radius = r;
		this.color  = color;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		
	}
	
	protected function onAdded(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		draw();
		timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
		timer.start();
	}	
	
	private function onTimer(event:TimerEvent):void
	{
		holder.rotation = (holder.rotation + (360 / slices)) % 360;
	}
	
	
	private function draw():void
	{
		var i:int = slices;
		var degrees:int = 360 / slices;
		
		holder= new CasaSprite();
		addChild(holder);
		
		while (i--)
		{
			var slice:Shape = getSlice();
			slice.alpha = Math.max(0.15, 1 - (0.1 * i));
			var radianAngle:Number = (degrees * i) * Math.PI / 180;
			slice.rotation = -degrees * i;
			slice.x = Math.sin(radianAngle) * radius;
			slice.y = Math.cos(radianAngle) * radius;
			holder.addChild(slice);
		}
		
		
	}
	private function getSlice():Shape
	{
		var slice:Shape = new Shape();
		slice.graphics.beginFill(color);
		slice.graphics.drawRoundRect(-1, 0,10, 16, 12, 12);
		slice.graphics.endFill();
		return slice;
	}
	
	
	
}