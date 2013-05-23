
package com.reflektions.tween{

  import flash.events.*;
  import flash.display.Sprite;
  import flash.display.MovieClip;
  import com.reflektions.tween.TweenEventDispatcher;		
  import com.reflektions.tween.equations.Quadratic;
   
  public class Tween extends EventDispatcher{

	//- PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------

	// Initial variables
	private var id:Number;								// Tween ID
	private var targetClip:*;							// Target Clip we are tweening can be Sprite of MovieClip
	private var renderClip:Sprite;						// Sprite we use to create Enterfrane for tween	(since targetClip enterframe can be in use)
	private var tobj:Object;							// Tween Object
	private var t:Number = 0;							// Current tim
	private var steps:Number;							// Steps needed to get to target
	private var diff:Number;							// Difference in position to travel
	private var speed:Number=5;						// Current speed
	private var equation:Function = Quadratic.easeIn;	// Equation used for the Animation (default is quadrtaic)
	private var isAnimating:Boolean = false;			// (T/F) is animating?
	
	// # class propeties
	private static var arr_allTweens:Array= new Array(); // contains reference to all tweens
	private static var all_speed:Number;					// all tween speed
	private static var obj_equation:Function;				// all equation
	
	//- PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------


	//- CONSTRUCTOR -------------------------------------------------------------------------------------------
	
	public function Tween() 
	{
		
		// Set ID
		id = arr_allTweens.length;
		
		// Add reference to this object to ar_allSounds
		arr_allTweens[id] = this;
	  
	}
	  
	//- SETTERD AND GETTERS -------------------------------------------------------------------------------------------
	
	// Set speed
    public static function set speed(num:Number):void 
	{
		
		// set all sounds
		for(var i:String in arr_allTweens){
			arr_allTweens[i].speed = num;
			trace(arr_allTweens[i])
		}
		
		// set all speed
		all_speed = num;
	}
	
	// Get speed
	public static function get speed():Number 
	{
		return all_speed;
	}
	
	// Set tween equation
	public static function set equation(e:Function):void 
	{
		// set all equation
		for(var i:String in arr_allTweens){
			arr_allTweens[i].equation = e;
		}
		// set equation
		obj_equation = e;
	}
	
	// get tween equation
	public static function get equation():Function {
		return obj_equation;
	}

	//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
	
	// Populate tween object with correct values for animation
	private function populateTweenObject():void{

		// Associate Clip to move
		targetClip = tobj.mc;
		
		// crate empty sprite for tween to enable onEnterFrame event
		// dont want to put enterFrame on targetClip since it can already 
		// have an enterframe event.
		renderClip = new Sprite();
		
		// get difference as it is the number of pixels to travel
		tobj.diffX = tobj.dx - tobj.x;
		tobj.diffY = tobj.dy - tobj.y;
		tobj.diffXscale = tobj.dxscale - tobj.xscale;
		tobj.diffYscale = tobj.dyscale - tobj.yscale;
		tobj.diffR = tobj.dr - tobj.r;
		tobj.diffA = tobj.da - tobj.a;
		tobj.diffW = tobj.dw - tobj.w;
		tobj.diffH = tobj.dh - tobj.h;
		
		// replace all NaN into 0 (Number)
		for (var i:String in tobj){
			// if object element has not been defined set to 0
			(isNaN(tobj[i])) ? tobj[i] = 0 : null;
		}

		// Find total differnences
		diff = Math.sqrt((tobj.diffX*tobj.diffX)+(tobj.diffY*tobj.diffY)+
						(tobj.diffXscale*tobj.diffXscale)+(tobj.diffYscale*tobj.diffYscale)+
						(tobj.diffR*tobj.diffR)+(tobj.diffA*tobj.diffA)+(tobj.diffW*tobj.diffW)+(tobj.diffH*tobj.diffH));
						
						
		
		// calculate steps needed (diff/speed squared)
		steps = diff/(speed*speed);
		
		// reset timer to 0
		t = 0;
		
		// Add Listener to embed complete
		renderClip.addEventListener(Event.ENTER_FRAME, tweenEnterFrameListener);

	}
	
	// render tween on selected clip
	private function tweenEnterFrameListener(e:Event):void
	{
		// Get value of t
		t += (t+steps)/diff;
		
		// animate with ease equation and associate to original movieClip property 
		if (tobj.x != undefined) targetClip.x = equation(tobj.x,tobj.diffX,t);
		if (tobj.y != undefined) targetClip.y = equation(tobj.y,tobj.diffY,t);
		if (tobj.xscale != undefined) targetClip.scaleX = equation(tobj.xscale,tobj.diffXscale,t);
		if (tobj.yscale != undefined) targetClip.scaleY = equation(tobj.yscale,tobj.diffYscale,t);
		if (tobj.r != undefined) targetClip.rotation = equation(tobj.r,tobj.diffR,t);
		if (tobj.a != undefined)  targetClip.alpha = equation(tobj.a,tobj.diffA,t);
		if (tobj.w != undefined)  targetClip.width = equation(tobj.w,tobj.diffW,t);
		if (tobj.h != undefined)  targetClip.height = equation(tobj.h,tobj.diffH,t);
		
		// Dispatch custom progress Event and pass clip and time as parameter
		dispatchEvent(new TweenEventDispatcher(TweenEventDispatcher.TWEEN_PROGRESS, {target:targetClip,time:t}));
		
		// if time is equal to steps stop animation Snap clip to final position
		if(t >= 1) snapToFinalPosition();
	}
	
	// Snap mc clip to final position by setting clip properties to final values
	private function snapToFinalPosition():void
	{
		// Depending on property tweened snap
		if (tobj.x != undefined) targetClip.x = tobj.dx;
		if (tobj.y != undefined) targetClip.y = tobj.dy;
		if (tobj.xscale != undefined) targetClip.scaleX = tobj.dxscale;
		if (tobj.yscale != undefined) targetClip.scaleY = tobj.dyscale;
		if (tobj.r != undefined) targetClip.rotation = tobj.dr;
		if (tobj.a != undefined) targetClip.alpha = tobj.da;
		if (tobj.w != undefined) targetClip.width = tobj.dw;
		if (tobj.h != undefined) targetClip.height = tobj.dh;
		
		// Dispatch custom complete Event
		dispatchEvent(new TweenEventDispatcher(TweenEventDispatcher.TWEEN_COMPLETE,{target:targetClip,time:t}));
	  
		// remove all listeners & enterFrames
		garbageCollect();
	}
	
	//remove animation and listeners
	private function garbageCollect():void
	{
		// delete this enterframe for memory management
		renderClip.removeEventListener(Event.ENTER_FRAME, tweenEnterFrameListener);
		renderClip = null;
		tobj = null;
		// Set isAnimating to false
		isAnimating = false;
	}
	
	//- PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
	
	// Initiates tween
	public function initTween(obj:Object,...params):void 
	{
		// check if already animating, prevent double animation requests
		if (!isAnimating){
			// set tween equation [this is optional]
			if (params[0] != undefined) equation = params[0];

			// set Speed value [this is optional]
			if (params[1] != undefined) speed = params[1];
	
			// Create new object and transfer all arguments
			//tobj = new Object();
			tobj = obj;
			
			// set if tween is currently animating
			isAnimating = true;
			
			// Populate tween object with tween values
			populateTweenObject();
			
		}else{
			trace("sorry already tweening, try again later")
		}
		
	}
	
	//- EVENT HANDLERS ----------------------------------------------------------------------------------------

	
	//- END CLASS ---------------------------------------------------------------------------------------------
  }
}


