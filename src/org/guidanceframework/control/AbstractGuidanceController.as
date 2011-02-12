package org.guidanceframework.control
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import org.guidanceframework.control.routing.GlobalControlRouter;
	import org.guidanceframework.events.GuidanceEvent;
	import org.guidanceframework.events.global.GlobalEventDispatcher;
	
	/**
	 * Extend this class,
	 * Create an eventMapObject in your constructor,
	 * Then call super( eventTypeString, eventMapObject ).
	 * */
	public class AbstractGuidanceController extends GlobalEventDispatcher
	{
		
		private var eventMap:Object;
		
		private var eventType:String;
		
		public function AbstractGuidanceController( eventTypeString:String, eventMapObject:Object )
		{
			
			eventType = eventTypeString;
			
			eventMap = eventMapObject;
			
			addEventListener( eventType, routeEvent );
			
		}
		
		/**
		 * Route events.
		 * */
		private function routeEvent( event:GuidanceEvent ):void
		{
			
			if( eventMap == null ) return;
			
			var eventHandler:Function = eventMap[ event.routingTag ] as Function;
			
			// Process Local Event Handler.
			if( eventHandler != null ) eventHandler( event );
			
			// Process Global Event Handlers.
			GlobalControlRouter.routeEvent( event );
			
		}
		
	}
	
}