package src.com.azinliklarittifaki
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.primitives.Triangle;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class LeftRightButton extends CasaSprite
	{
		private var rect:RectShape;
		private var tri:Triangle;
		private var props:Object;
		
		public function LeftRightButton(props:Object)
		{
			this.props = props;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			this.buttonMode = true;
			this.alpha = 0.7;
			//Draw Rect
			rect = new RectShape(new Rectangle(0,0,this.props.w,this.props.h),new FillStyle(this.props.color));
			addChild(rect);
			
			// draw triangle
			tri = new Triangle(props.direction,props.tw, props.th,props.tcolor);
			addChild(tri);
			Aligner.alignCenter(tri,rect);
			
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			TweenLite.to(this,0.5,{alpha:0.7,ease:Expo.easeOut});
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			TweenLite.to(this,0.5,{alpha:1,ease:Expo.easeOut});
		}
	}
}