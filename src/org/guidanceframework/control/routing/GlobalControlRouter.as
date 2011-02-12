package org.guidanceframework.control.routing
{
	
	import mx.collections.ArrayCollection;
	
	import org.guidanceframework.events.GuidanceEvent;
	
	public class GlobalControlRouter
	{
		
		private static var routingHooks:Object;
		
		public function GlobalControlRouter()
		{
			
		}
		
		//**********
		// Route Events
		//**********
		
		public static function routeEvent( event:GuidanceEvent ):void
		{
			
			// Return in the rare case the event is null.
			if( event == null ) return;
			
			// Return if the event has already been globally routed as multiple controller instances could be routing this event.
			if( event.routingCount != 0 ) return;
			
			// Process Routing Hooks.
			if( routingHooks != null ){
				
				if( routingHooks[ event.type ] != null ){
					
					var typeObject:Object = routingHooks[ event.type ] as Object;
					
					if( typeObject[ event.routingTag ] != null ){
						
						var currentHooks:ArrayCollection = typeObject[ event.routingTag ] as ArrayCollection;
						
						for( var i:int = 0; i < currentHooks.length; i++ ){
							
							var currentHookHandler:Function = currentHooks.getItemAt( i ) as Function;
							
							currentHookHandler( event );
							
						}
						
					}
					
				}
				
			}
			
			// Increment the event's routing count so that it doesn't globally routed more than once.
			event.routingCount++;
			
		}
		
		//**********
		// Routing Hooks
		//**********
		
		public static function addRoutingHook( type:String, routingTag:String, functionReference:Function, addAsDuplicateIfExists:Boolean = false ):void
		{
			
			// Return if any required arguments are null.
			if( type == null || routingTag == null || functionReference == null ) return;
			
			// Instantiate the routingHooks Object if it has not been already.
			if( routingHooks == null ) routingHooks = new Object();
			
			// Instantiate the "type" Object if it does not exist.
			if( routingHooks[ type ] == null ) routingHooks[ type ] = new Object();
			
			var typeObject:Object = routingHooks[ type ] as Object;
			
			// Instantiate the collection of hook functions at the "tag" index of the typeObject if it does not exist.
			if( typeObject[ routingTag ] == null ) typeObject[ routingTag ] = new ArrayCollection();
			
			var currentHooks:ArrayCollection = typeObject[ routingTag ] as ArrayCollection;
			
			if( addAsDuplicateIfExists ){
				
				currentHooks.addItem( functionReference );
				
			}else{
				
				if( currentHooks.getItemIndex( functionReference ) == -1 ){
					
					currentHooks.addItem( functionReference );
					
				}
				
			}
			
		}
		
		public static function removeRoutingHook( type:String, routingTag:String, functionReference:Function, removeAll:Boolean = false ):void
		{
			
			// Return if any required arguments are null.
			if( type == null || routingTag == null || functionReference == null ) return;
			
			// Return if routingHooks is null.
			if( routingHooks == null ) return;
			
			// Return if the "type" Object is null.
			if( routingHooks[ type ] == null ) return;
			
			var typeObject:Object = routingHooks[ type ] as Object;
			
			// Return if the collection of hook functions at the "tag" index of the typeObject is null.
			if( typeObject[ routingTag ] == null ) return;
			
			var currentHooks:ArrayCollection = typeObject[ routingTag ] as ArrayCollection;
			
			if( removeAll ){
				
				while( currentHooks.getItemIndex( functionReference ) != -1 ){
					
					currentHooks.removeItemAt( currentHooks.getItemIndex( functionReference ) );
					
					currentHooks.refresh();
					
				}
				
			}else{
				
				currentHooks.removeItemAt( currentHooks.getItemIndex( functionReference ) );
				
			}
			
		}
		
	}
	
}