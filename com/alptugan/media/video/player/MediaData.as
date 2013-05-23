//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.media.video.player
{
	
	public class MediaData
	{
		protected var _duration : Number;
		
		public function get duration() : Number
		{
			return _duration;
		}
		
		public function set duration( duration : Number ) : void
		{
			_duration = duration;
		}
		
		protected var _height : Number;
		
		public function get height() : Number
		{
			return _height;
		}
		
		public function set height( value : Number ) : void
		{
			_height = value;
		}
		
		protected var _image : String;
		
		public function get image() : String
		{
			return _image;
		}
		
		public function set image( image : String ) : void
		{
			_image = image;
		}
		
		protected var _percentLoaded : Number;
		
		public function get percentLoaded() : Number
		{
			return _percentLoaded;
		}
		
		public function set percentLoaded( value : Number ) : void
		{
			_percentLoaded = value;
		}
		
		protected var _position : Number;
		
		public function get position() : Number
		{
			return _position;
		}
		
		public function set position( value : Number ) : void
		{
			_position = value;
		}
		
		protected var _title : String;
		
		public function get title() : String
		{
			return _title;
		}
		
		public function set title( title : String ) : void
		{
			_title = title;
		}
		
		protected var _uri : String;
		
		public function get uri() : String
		{
			return _uri;
		}
		
		public function set uri( uri : String ) : void
		{
			_uri = uri;
		}
		
		protected var _width : Number;
		
		public function get width() : Number
		{
			return _width;
		}
		
		public function set width( value : Number ) : void
		{
			_width = value;
		}
		
		function MediaData( uri : String = "",title : String = "",duration : Number = 120,image : String = "",width : Number = 320,height : Number = 240,position : Number = 0 )
		{
			_position = position;
			_uri = uri;
			_title = title;
			_duration = duration;
			_image = image;
			_width = width;
			_height = height;
		}
	}
}