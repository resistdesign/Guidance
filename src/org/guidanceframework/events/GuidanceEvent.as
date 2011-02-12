package org.guidanceframework.events
{
	import flash.events.Event;
	
	/**
	 * Extend this class,
	 * Then call super( type, data, routingTag ) in the constructor.
	 * */
	public class GuidanceEvent extends Event
	{
		
		public var data:Object;
		
		public var routingTag:String;
		
		public var routingCount:int = 0;
		
		public function GuidanceEvent( type:String, data:Object, routingTag:String )
		{
			
			this.data = data;
			
			this.routingTag = routingTag;
			
			super( type, true, false );
			
		}
		
	}
	
}