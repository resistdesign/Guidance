package org.guidanceframework.events.global
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.FlexEvent;
	
	import org.guidanceframework.constants.GlobalApplicationConstants;
	
	public class GlobalEventDispatcher extends EventDispatcher
	{
		
		public function GlobalEventDispatcher()
		{
			
			super( null );
			
			if( GlobalApplicationConstants.APPLICATION_COMPLETE ){
				
				processQueues();
				
			}else{
				
				GlobalApplicationConstants.APPLICATION.addEventListener( FlexEvent.APPLICATION_COMPLETE, processQueues );
				
			}
			
		}
		
		//**********
		// Overrides
		//**********
		
		private var eventQueue:Array = new Array();
		
		public override function dispatchEvent( event:Event ):Boolean
		{
			
			if( GlobalApplicationConstants.APPLICATION_COMPLETE ){
				
				return GlobalApplicationConstants.APPLICATION.stage.dispatchEvent( event );
				
			}else{
				
				eventQueue.push( event );
				
			}
			
			return true;
			
		}
		
		private var listenerQueue:Array = new Array();
		
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
			
			if( GlobalApplicationConstants.APPLICATION_COMPLETE ){
				
				GlobalApplicationConstants.APPLICATION.stage.addEventListener( type, listener, useCapture, priority, useWeakReference );
				
			}else{
				
				listenerQueue.push( new GlobalEventListener( type, listener, useCapture, priority, useWeakReference ) );
				
			}
			
		}
		
		//**********
		// Queue methods
		//**********
		
		protected function processQueues( event:FlexEvent = null ):void
		{
			
			addListenerQueue();
			
			GlobalApplicationConstants.APPLICATION.callLater( dispatchEventQueue );
			
		}
		
		protected function addListenerQueue():void
		{
			
			for( var i:int = 0; i < listenerQueue.length; i++ ){
				
				var currentListener:GlobalEventListener = listenerQueue[ i ] as GlobalEventListener;
				
				GlobalApplicationConstants.APPLICATION.stage.addEventListener( currentListener.type, currentListener.listener, currentListener.useCapture, currentListener.priority, currentListener.useWeakReference );
				
			}
			
			listenerQueue = new Array();
			
		}
		
		protected function dispatchEventQueue():void
		{
			
			for( var i:int = 0; i < eventQueue.length; i++ ){
				
				var currentEvent:Event = Event( eventQueue[ i ] );
				
				GlobalApplicationConstants.APPLICATION.stage.dispatchEvent( currentEvent );
				
			}
			
			eventQueue = new Array();
			
		}
		
	}
	
}