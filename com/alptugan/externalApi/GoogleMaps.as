//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.externalApi
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.Map3D;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.View;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.MapTypeControl;
	import com.google.maps.controls.MapTypeControlOptions;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.geom.Attitude;
	import com.google.maps.overlays.*;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import com.alptugan.ui.SWFWheel;	
	public class GoogleMaps extends Sprite
	{
		// Variables
		public var map : Map3D;
		
		private var Lan : Number,Len : Number,w : int,h : int,xml : XML,c : uint;
		
		// Add Markers On The Map
		
		private var bd : BitmapData;
		
		private var bmp : Bitmap;
		
		private var markerPin : Shape;
		
		private var mt : Matrix;
		
		public function GoogleMaps( Lan : Number,Len : Number,w : int,h : int,xml : XML,c : uint )
		{
			this.Lan = Lan;
			this.Len = Len;
			this.w = w;
			this.h = h;
			this.xml = xml;
			this.c = c;
		
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		public function setRegistrationPoint( s : Sprite,regx : Number,regy : Number,showRegistration : Boolean ) : void
		{
			//translate movieclip 
			
			s.transform.matrix = new Matrix( 1,0,0,1,-regx,-regy );
			
			//registration point.
			if ( showRegistration )
			{
				var mark : Sprite = new Sprite();
				mark.graphics.lineStyle( 1,0x000000 );
				mark.graphics.moveTo( -5,-5 );
				mark.graphics.lineTo( 5,5 );
				mark.graphics.moveTo( -5,5 );
				mark.graphics.lineTo( 5,-5 );
				s.parent.addChild( mark );
			}
		}
		
		private function init( e : Event ) : void
		{
			// No focus line
			stage.stageFocusRect = false;
			SWFWheel.initialize( stage );
			
			this.addEventListener( MouseEvent.MOUSE_DOWN,onClickMap );
			this.addEventListener( MouseEvent.MOUSE_UP,onClickUpMap );
			
			// Call the function to create the map
			add_map();
			
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onClickMap( e : MouseEvent ) : void
		{
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function onClickUpMap( e : MouseEvent ) : void
		{
			Mouse.cursor = MouseCursor.ARROW;
		}
		
		// Function that adds the map on stage
		private function add_map() : void
		{
			map = new Map3D();
			map.key = 'ABQIAAAA9Sg1JzmjkgGJgEGX-jKRPhSK9stSdYFRxLxrSWwgc1XoURMkxxSAYsgh3I5K70DUJAXAspXq1jQs4A';
			map.setSize( new Point( this.w,this.h ));
			map.addEventListener( MapEvent.MAP_READY,onMapReady );
			this.addChild( map );
		}
		
		// Function that will fire once map is created
		private function onMapReady( event : MapEvent ) : void
		{
			map.setCenter( new LatLng( this.Lan,this.Len ),13 );
			map.viewMode = View.VIEWMODE_2D;
			map.setAttitude( new Attitude( 20,40,0 ));
			//map.addControl(new MapTypeControl());
			/** Preview Screen which is placed at the bottom right corner **/
			//map.addControl(new OverviewMapControl()); 
			//var position : ControlPosition        = new ControlPosition( ControlPosition.ANCHOR_TOP_RIGHT,16,10 );
			
			//map.addControl(new NavigationControl());
			/** Custom Tooltip welcome message **/
			//map.openInfoWindow(map.getCenter(), new InfoWindowOptions({title: "Hello", content: "World"}));
			//var topRight : ControlPosition        = new ControlPosition( ControlPosition.ANCHOR_TOP_RIGHT,16,10 );
			//var bottomRight : ControlPosition     = new ControlPosition( ControlPosition.ANCHOR_BOTTOM_RIGHT,16,10 );
			
			//var myZoomControl : ZoomControl       = new ZoomControl( new ZoomControlOptions({ position: topRight }));
			//var myMapTypeControl : MapTypeControl = new MapTypeControl( new MapTypeControlOptions({ position: bottomRight }));
			
			//map.addControl( myZoomControl );
			//map.addControl( myMapTypeControl );
			map.enableScrollWheelZoom();
			map.enableContinuousZoom();
			
			// Load the xml
			loadXML();
		}
		
		private function createMarker( latlng : LatLng,number : Number,tip : *,myTitle : *,myContent : * ) : Marker
		{
			// create Custom marker object
			// If your marker is to big you can scale it down here
			markerPin = new Shape();
			with ( markerPin.graphics )
			{
				lineStyle( 10 * 0.2,c );
				beginFill( 0xffffff );
				drawCircle( 0,0,10 );
				lineStyle( 0,0,0 );
				beginFill( c );
				drawCircle( 0,0,10 * 0.7 );
				endFill();
				
			}
			//var rect : Rectangle = new Rectangle(-20,-20,20,20);
			bd = new BitmapData( 25,25,true,0x00000000 );
			mt = new Matrix( 1,0,0,1,12,12 );
			bd.draw( markerPin,mt );
			
			mt.identity();
			
			bmp = new Bitmap( bd );
			bmp.name = "b";
			
			bmp.smoothing = true;
			var i : Marker                     = new Marker( latlng,new MarkerOptions({ hasShadow: true,icon: this.addChild( bmp ),tooltip: "" + tip }));
			
			//Info Window
			var Bg : Sprite                    = new Sprite();
			with ( Bg.graphics )
			{
				lineStyle( 2,0x599DD1 );
				beginFill( 0xffffff,0.8 );
				drawRoundRect( 0,0,195,40,10,10 );
				endFill();
			}
			
			var Cross : Shape                  = new Shape();
			with ( Cross.graphics )
			{
				beginFill( 0x333333,0.9 );
				drawRect( 0,0,1,1 );
				drawRect( 1,1,1,1 );
				drawRect( 2,2,1,1 );
				drawRect( 3,3,1,1 );
				drawRect( 4,4,1,1 );
				drawRect( 5,5,1,1 );
				drawRect( 0,5,1,1 );
				drawRect( 1,4,1,1 );
				drawRect( 2,3,1,1 );
				drawRect( 3,2,1,1 );
				drawRect( 4,1,1,1 );
				drawRect( 5,0,1,1 );
				endFill();
			}
			
			Cross.x = 184;
			Cross.y = 6;
			Bg.addChild( Cross );
			//addChild(Bg);
			
		/*	var DO : DisplayObject             = new LogoLib();
			DO.scaleX = DO.scaleY = 0.5;
			DO.x = 5;
			DO.y = 5;
			Bg.addChild( DO );*/
			
			var titleFormat : TextFormat       = new TextFormat( "Arial",10 );
			var tf : TextField                 = new TextField();
			tf.multiline = true;
			tf.wordWrap = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.width = 130;
			tf.height = 40;
			tf.defaultTextFormat = titleFormat;
			tf.text = myTitle + "\n" + myContent;
			tf.x = 60;
			tf.y = 8;
			Bg.addChild( tf );
			// Specifying all InfoWindowOptions properties.
			
			titleFormat.bold = true;
			var titleStyleSheet : StyleSheet   = new StyleSheet();
			var h1 : Object                    = {
					color: "#FFFF80",fontWeight: "bold" };
			titleStyleSheet.setStyle( "h1",h1 );
			var contentStyleSheet : StyleSheet = new StyleSheet();
			var body : Object                  = {
					color: "#FF0080",fontStyle: "italic" };
			contentStyleSheet.setStyle( "body",body );
			var contentFormat : TextFormat     = new TextFormat( "Arial",10 );
			var options : InfoWindowOptions    = new InfoWindowOptions({ strokeStyle: { color: 0x599DD1 },fillStyle: { color: 0xffffff,alpha: 0.8 },titleFormat: titleFormat,titleHTML: "" + myTitle,titleStyleSheet: titleStyleSheet,contentFormat: contentFormat,customContent: Bg,contentStyleSheet: contentStyleSheet,contentHTML: "" + myContent,width: 200,cornerRadius: 12,padding: 10,hasCloseButton: true,hasTail: true,tailWidth: 20,tailHeight: 20,tailOffset: -12,tailAlign: InfoWindowOptions.ALIGN_LEFT,pointOffset: new Point( 3,-40 ),hasShadow: true });
			
			i.addEventListener( MapMouseEvent.CLICK,function( event : MapMouseEvent ) : void
			{
				map.openInfoWindow( event.latLng,options );
			
			});
			AnimateCustomMarker();
			return i;
		}
		
		private function AnimateCustomMarker() : void
		{
			
			var tt : TweenMax = TweenMax.to( bmp,1,{ scaleX: 0.95,scaleY: 0.95,repeat: -1,yoyo: true });
		
		}
		
		// Function that will load the xml
		private function loadXML() : void
		{
			xml.ignoreWhitespace = true;
			for ( var i : int = 0;i < xml.location.length();i++ )
			{
				var latlng : LatLng    = new LatLng( xml.location[ i ].lat,xml.location[ i ].lon );
				var tip : *            = xml.location[ i ].name_tip;
				var myTitle : String   = xml.location[ i ].title_tip;
				var myContent : String = xml.location[ i ].content_tip;
				
				map.addOverlay( createMarker( latlng,i,tip,myTitle,myContent ));
			}
		}
		
		private function onRemoved( e : Event ) : void
		{
			removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
			if ( map.isLoaded())
				map.unload();
		
		}
		
		private function addEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.addEventListener( type,listener,false,0,true );
		}
		
		private function removeEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.removeEventListener( type,listener );
		}
	}
}
