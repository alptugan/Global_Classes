package com.alptugan.net
{
	
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class ALocalSender extends LocalConnection
	{
		
		public var connectionName:String;
		private var methodName:String;
		
		public function ALocalSender(connectionName:String,methodName:String)
		{
			super();
			this.connectionName = connectionName;
			this.methodName     = methodName;
			addEventListener(StatusEvent.STATUS, onLocalConnectionStatus);
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
		
		public function sendData(pack:Object):void
		{
			this.send(connectionName,methodName,pack);
			trace( "Packet Size : ",pack.toString());
		}
		
	}
}