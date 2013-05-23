//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.media.video.player
{
	import com.video.controls.RichShape;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.media.Video;
	
	import org.casalib.display.CasaSprite;
	
	/**
	 * ...
	 * @author Martin Legris
	 */
	public class DemoVideoPlayer extends CasaSprite
	{
		
		override public function get height() : Number
		{
			return _player.video.height;
		}
		
		override public function set height( value : Number ) : void
		{
			_player.video.height = value;
		}
		
		override public function get width() : Number
		{
			return _player.video.width;
		}
		
		override public function set width( value : Number ) : void
		{
			_player.video.width = value;
		}
		
		public function set volume(val:Number):void
		{
			_volume = val;
			_player.setVolume(_volume);
		}
		
		// player Instance to control the playback
		protected var _player : FLVPlayer;
		
		// Video instance to display the video
		protected var _video : Video,str : String;
		
		private var close_button : RichShape    = new RichShape( true );
		
		private var pause_button : RichShape    = new RichShape(true);
		
		private var play_button : RichShape     = new RichShape( true );
		
		private var play_button_bg : RichShape  = new RichShape();
		
		private var play_button_tri : RichShape = new RichShape();
		private var _volume :Number;
		
		private var _w : Number;
		private var _h :Number;
		public function DemoVideoPlayer( str : String, _w:Number,_h:Number )
		{
			this.str = str;
			this._h  = _h;
			this._w  = _w;
			addEventListener( Event.REMOVED_FROM_STAGE,onRemoved );
			addEventListener( Event.ADDED_TO_STAGE,onAdded);
			
			
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE,onAdded);
			
			init();
			createChilds();
			initEvents();
			startVid();
			
		}
		
		protected function init() : void
		{
			// create the player
			_player = new FLVPlayer();
		}
		
		protected function createChilds() : void
		{
			// create the video
			_video = new Video();
			// add to displayList
			addChild( _video );
			// connect the player with the video
			_player.video = _video;
			
		}
		
		protected function initEvents() : void
		{
			_player.addEventListener( MediaSizeEvent.SIZE,doMediaSize );
			_player.addEventListener( MediaEvent.FINISHED_PLAYING,onFinishPlaying );
			_player.addEventListener( MediaEvent.STARTED_PLAYING,onStartPlaying );
			
		}
		
		protected function doMediaSize( evt : MediaSizeEvent ) : void
		{
			// here we fit the Video object to the exact dimensions of the FLV video
			_video.width = evt.width;
			_video.height = evt.height;
			
			/*_video.width = this._h/this._w * evt.width;
			_video.height = this._w/this._h  * evt.height;*/
			
			
			_video.smoothing = true;
			//place play button to center
			//createButtons();
			play_button.addEventListener( MouseEvent.CLICK,onPlay );
			pause_button.addEventListener( MouseEvent.CLICK,onPause );
			
			_player.removeEventListener( MediaSizeEvent.SIZE,doMediaSize );

			dispatchEvent( new MediaSizeEvent( evt.type,_video.width,_video.height ));
		}
		
		public function startVid() : void
		{
			// create a mediaData instance, with the URL of the media we want to play
			var media : MediaData = new MediaData( str );
			// play the media..
			_player.playMedia( media );
			_player.pause();
			
			
		}
		
		protected function onStartPlaying(e:MediaEvent):void
		{
			_player.removeEventListener( MediaEvent.STARTED_PLAYING,onStartPlaying );
			dispatchEvent( new MediaEvent(e.type,''));
		}
		
		private function onFinishPlaying( e : MediaEvent ) : void
		{
			_player.seek(0);
			pause_button.visible = false;
			//!_player.paused ? _player.pause() : void;
			play_button.visible = true;
			_player.play();
		}
		
		private function createButtons() : void
		{
			//create close button
			close_button.drawRoundedRectangle( 20,20,4,0x202020,0x202020,0x202020 );
			close_button.setLabel({ color: 0xFFFFFF,profile: 'X',alpha: 1,size: 12 });
			addChild( close_button );
			close_button.addEventListener( MouseEvent.CLICK,onClickClose );
			close_button.setLabelPosition( 4,1 );
			close_button.x = _player.video.width - close_button.width;
			close_button.y = -close_button.height;
			// create buttons
			play_button_tri.drawTriangle( 55,55,0xFFFFFF,0xFFFFFF,0 );
			play_button_bg.drawRoundedRectangle( 100,100,4,0x202020,0x202020,0x000000 );
			play_button.addChild( play_button_bg );
			play_button.addChild( play_button_tri );
			play_button_tri.x = ( play_button_bg.width / 2 ) - play_button_tri.width / 2;
			play_button_tri.y += 17;
			play_button_tri.setLabel({ color: 0xFFFFFF,profile: 'PLAY',alpha: 1,size: 14 });
			play_button_tri.setLabelPosition( 10,60 );
			play_button.alpha = .90;
			addChild( play_button );
			
			pause_button.drawPause( 100,100,0xFFFFFF,0x202020,0);
			
			addChild( pause_button );
			
			play_button.x = ( _player.video.width / 2 ) - play_button.width / 2;
			play_button.y = ( _player.video.height / 2 ) - play_button.height / 2;
			pause_button.x = play_button.x;
			pause_button.y = play_button.y;
			play_button.visible = true;
			pause_button.visible = false;
		
		}
		
		private function onClickClose( e : MouseEvent ) : void
		{
			dispatchEvent( new Event( "remove" ));
		}
		
		public function pauseVideo():void
		{
			_player.pause();
			
		}
		
		
		private function onPause( e : MouseEvent ) : void
		{
			play_button.visible = true;
			pause_button.visible = false;
			_player.pause();
		}
		
		private function onRemoved( e : Event ) : void
		{
			_player.video.clear();
			_player.reset();
			_player.close();
		}
		
		/**
		 * PLAY VİDEO 
		 * @param e
		 * 
		 */
		
		override public function destroy():void
		{
			
		}
		public function onPlay( e : MouseEvent = null) : void
		{
			play_button.visible = false;
			pause_button.visible = true;
			_player.play();
		}
		
	}
}