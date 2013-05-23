package  src.com.filikatasarim.games.soundgame {

	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;

	/*
		class to simulate a realistic rope effect
	*/
	public class Rope extends CasaSprite {

		public var nodeaantal:uint = 4; //amount of nodes
		public var tension:Number = 9; //the tension
		public var damp:Number = .8; //de damp
		public var gravity:Number = 0; //the gravityy
		public var canvas:CasaSprite = new CasaSprite(); //the actual rope
		public var nodes:Vector.<Object>; //a vector with the nodes
		
		public var gThickness:Number = 1; //thickness of the rope
		public var gColor:uint = 0xFFFFFF; //color of the rope
		public var gAlpha:Number = 1; //alpha of the rope

		public var p1:Object; //connection object 1
		public var p2:Object; //connection object 2

		/*
			constructor for the rope
		*/
		public function Rope(p1:Object, p2:Object, gravity:Number = 0, tension:Number = 9, damp:Number = 0.8) {
			this.p1 = p1;
			this.p2 = p2;
			this.gravity = gravity;
			this.tension = tension;
			this.damp = damp;
			init();
		}
		
		/*
			method to set linestyle
		*/
		public function setLineStye(gThickness:Number = 1, gColor:uint = 0xFFFFFF, gAlpha:Number = 1){
			this.gThickness = gThickness;
			this.gColor = gColor;
			this.gAlpha = gAlpha;
		}

		private function init() {
			var n:Number = nodeaantal;
			++n;
			var dx: Number = ( p2.x - p1.x ) / n;
			var dy: Number = ( p2.y - p1.y ) / n;
			nodes = new Vector.<Object>();
			var node:Object;
			var lastNode:Object;
			while ( --n > 0 ) {
				node = {x:p1.x + dx * n,y:p1.y + dy * n};
				if (n < nodeaantal) {
					node.next = lastNode;
					lastNode.prev = node;
				} else {
					node.next = p2;
				}
				node.vx = node.vy = 0;
				lastNode = node;
				nodes.push( node );
			}
			node.prev = p1;
			addChild(canvas);
			redraw();
		}


		/*
			call this function to recalculate and redraw the rope
		*/
		public function redraw() {
			var vx:Number;
			var vy:Number;
			var next:Object;
			var prev:Object;
			var node:Object;
			var n:Number = nodes.length;
			var sumx:Number = 0;
			var sumy:Number = 0;
			while ( --n > -1 ) {
				node = nodes[n];
				next = node.next;
				prev = node.prev;
				node.vx += ( next.x + prev.x - node.x * 2 ) / tension;
				node.vy += ( next.y + prev.y - node.y * 2 ) / tension;
				node.vy+=gravity;
				node.vx*=damp;
				node.vy*=damp;
				node.x+=node.vx;
				node.y+=node.vy;
				sumx+=vx;
				sumy+=vy;
			}
			var p1=nodes[nodeaantal-1].prev;
			var p2=nodes[0].next;
			canvas.graphics.clear();
			var mx:Number;
			var my:Number;
			var px:Number;
			var i:Number;
			n=3;
			while ( --n > -1 ) {
				canvas.graphics.lineStyle(gThickness, gColor, gAlpha);
				canvas.graphics.moveTo( p1.x , p1.y );
				i=nodeaantal;
				while ( --i > -1 ) {
					if ( Math.abs( ( mx = ( node = nodes[i] ).x ) - ( px = ( prev = node.next ).x ) ) < 3 ) {
						canvas.graphics.lineTo( ( mx + px ) / 2 , ( ( my = node.y ) + prev.y ) / 2 );
					} else {
						canvas.graphics.curveTo( mx , ( my = node.y ) , ( mx + px ) / 2 , ( node.y + prev.y ) / 2  );
					}
				}
				canvas.graphics.curveTo( ( p2.x + mx ) / 2 , ( p2.y + my ) / 2 , p2.x , p2.y );
			}
		}
	}
}