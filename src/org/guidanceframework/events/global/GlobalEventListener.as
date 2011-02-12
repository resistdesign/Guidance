package org.guidanceframework.events.global
{
	
	public class GlobalEventListener
	{
		
		public var type:String;
		
		public var listener:Function;
		
		public var useCapture:Boolean = false;
		
		public var priority:int = 0;
		
		public var useWeakReference:Boolean = false;
		
		public function GlobalEventListener( eventType:String, listenerClosure:Function, useCaptureFlag:Boolean = false, priorityLevel:int = 0, useWeakReferenceFlag:Boolean = false )
		{
			
			type = eventType;
			
			listener = listenerClosure;
			
			useCapture = useCaptureFlag;
			
			priority = priorityLevel;
			
			useWeakReference = useWeakReferenceFlag;
			
		}
		
	}
	
}