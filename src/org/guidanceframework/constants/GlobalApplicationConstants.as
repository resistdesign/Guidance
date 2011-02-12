package org.guidanceframework.constants
{
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	
	public class GlobalApplicationConstants
	{
		
		[Bindable]
		public static var APPLICATION:Application = FlexGlobals.topLevelApplication as Application;
		
		[Bindable]
		private static var _APPLICATION_COMPLETE:Boolean = false;
		
		public function GlobalApplicationConstants()
		{
			
			
			
		}
		
		public static function get APPLICATION_COMPLETE():Boolean
		{
			
			if( _APPLICATION_COMPLETE ){
				
				return true;
				
			}
			
			APPLICATION.addEventListener( FlexEvent.APPLICATION_COMPLETE, setApplicationComplete );
			
			return false;
			
		}
		
		//**********
		// Event Handlers
		//**********
		
		protected static function setApplicationComplete( event:FlexEvent ):void
		{
			
			_APPLICATION_COMPLETE = true;
			
		}
		
	}
	
}