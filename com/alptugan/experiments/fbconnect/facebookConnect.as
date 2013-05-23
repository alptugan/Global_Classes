package com.alptugan.experiments.fbconnect
{
	import com.facebook.graph.FacebookDesktop;
	
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class facebookConnect extends CasaSprite
	{
		private var appId:String;
		private var currentState:String;
		
		public function facebookConnect(appId:String)
		{
			this.appId = appId;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			initApp();
		}
		
		private function initApp():void
		{
			FacebookDesktop.init(this.appId,handleLogin,"AAAFsMgNTiW8BAM0aeUeBucn52GRl8n5d3tqNBY33pDReJQIvZCA8zGohsNIUr1aeJwhTZA2azKglDxO9bag05Nswd6sKhdQ9jKQZAUBigZDZD");
			doLogin();
		}
		
		/**
		 * LOGIN  HANDLE
		 * 
		 */		
		private function handleLogin(session:Object, fail:Object):void
		{
			
			
			if(session !=null) 
			{
				currentState = "Main";
				trace(session.user.id);
				trace(session.user.name);
				trace(session.user.first_name);
				trace(session.user.middle_name);
				trace(session.user.last_name);
				trace(session.user.gender);
				trace(session.user.locale);
				trace(session.user.languages);
				trace(session.user.link);
				trace(session.user.username);
				trace(session.user.third_party_id);
				trace(session.user.installed);
				trace(session.user.timezone);
				trace(session.user.updated_time);
				trace(session.user.verified);
				trace(session.user.bio);
				trace(session.user.birthday);
				trace(session.user.cover);
				trace(session.user.currency);
				trace(session.user.devices);
				trace(session.user.education);
				trace(session.user.email);
				trace(session.user.hometown);
				trace(session.user.interested_in);
				trace(session.user.location);
				trace(session.user.political);
				trace(session.user.picture);
			}
		}
		
		
		private function doLogin():void
		{
			FacebookDesktop.login(handleLogin, []);
			
			
		}
		
		private function doLogout():void
		{
			FacebookDesktop.logout();
		}
		
		protected function onRemoved(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
	}
}


