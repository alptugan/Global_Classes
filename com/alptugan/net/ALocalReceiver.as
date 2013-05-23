package com.alptugan.net
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class ALocalReceiver extends LocalConnection
	{
		
		public var connectionName:String;
		private var _data:Object;
		
		public function ALocalReceiver(connectionName:String)
		{
			super();
			
			
		
			
			this.connectionName = connectionName;
			
			this.allowDomain('localhost');
			this.allowDomain('*');
			
			this.connect(connectionName);
			this.client=this;
			this.addEventListener(StatusEvent.STATUS, onLocalConnectionStatus);
		}
		

		
		public function get data():Object
		{
			return _data;
		}

		public function processData(args:Object):void
		{
			_data = args;
			
		}
		
		
		
		
		protected function onLocalConnectionStatus(e:StatusEvent):void
		{
			switch (e.level) {
				case "status":
					trace("LocalConnection.send() succeeded");
					break;
				case "error":
					trace("LocalConnection.send() failed");
					break;
			}
		}	
		

	}
}