package  
{
	/**
	 * ...
	 * @author sakurati
	 */
	import flash.events.Event;
    import org.axgl.*;
	import org.axgl.input.AxKey;
    import org.axgl.input.AxMouseButton;
    import org.axgl.render.AxColor;
	import org.axgl.text.AxFont;
    import org.axgl.text.AxText;
	public class Touch extends AxGroup
	{
		public var touch1:AxSprite;
		public var touch2:AxSprite;
		
		public var ghost1:AxSprite;
		public var ghost2:AxSprite;
		public var ghost3:AxSprite;
		
		public var rel1:Boolean;
		public var rel2:Boolean;
		
		public var justTouched1:Boolean;
		public var justTouched2:Boolean;
		
		public var down1:Boolean;
		public var down2:Boolean;
		
		public var justReleased1:Boolean;
		public var justReleased2:Boolean;
		
		public var useScreen:Boolean;
		
		/**
		 * 
		 * @param	Screen	Screen Set to true if using screen values
		 * @param	Size	size of each box
		 */
		public function Touch(Screen:Boolean = false,Size:uint = 1):void 
		{
			super();
			
			useScreen = Screen;
			rel1 = false;
			rel2 = false;
			
			justTouched1 = false;
			justTouched2 = false;
			
			down1 = false;
			down2 = false;
			
			justReleased1 = false;
			justReleased2 = false;
			
			touch1 = new AxSprite(0, 0).create(Size, Size, 0x00A75F5F);
			add(touch1);
			
			touch2 = new AxSprite(0, 0).create(Size, Size, 0x001183F4);
			add(touch2);
			
			ghost1 = new AxSprite(0, 0).create(Size, Size, 0x001183F4); add(ghost1); ghost1.num = 1;
			ghost2 = new AxSprite(0, 0).create(Size, Size, 0x001183F4); add(ghost2); ghost2.num = 2;
			ghost3 = new AxSprite(0, 0).create(Size, Size, 0x001183F4); add(ghost3); ghost3.num = 3;
		}
		
		override public function destroy():void 
		{
			touch1.destroy();
			touch2.destroy();
			ghost1.destroy();
			ghost2.destroy();
			ghost3.destroy();
			
			super.destroy();
		}
		
		override public function update():void 
		{
			init();
			justTouch();
			downPressed();
			justRelease();
			
			if (Ax.touch.length == 1) ss = "one";
			if (Ax.touch.length == 2) ss = "two";
			
			super.update();
		}
		public var ss:String;
		private function init():void
		{
			//init
			justTouched1 = justTouched2 = false;
			justReleased1 = justReleased2 = false;
			down1 = down2 = false;
			
			if (Ax.touch.length == 1)
			{
				touch1.num = Ax.touch[0]._id;
				touch2.num = -2;
			}	
			else if (Ax.touch.length == 2)
			{
				touch1.num = Ax.touch[0]._id;
				touch2.num = Ax.touch[1]._id;
			}
			else if (Ax.touch.length == 0)
			{
				touch1.num = -1;
				touch2.num = -2;
			}
			
			if (touch1.num >= 0)
			{
				touch1.exists = true;
			}
			if (touch2.num >= 0) 
			{
				touch2.exists = true;
			}
			
			if (touch1.num < 0) touch1.exists = false;
			if (touch2.num < 0) touch2.exists = false;		
		}
		
		private function justTouch():void 
		{
			// justpressed
			if (touch1.num >= 0)
			{
				if (Ax.touch[0]._t >= Ax.then && Ax.touch[0]._t<Ax.now && Ax.touch[0]._t>0)
				{
					justTouched1 = true;
					rel1 = false;
					updateTouch1();
				}
			}
			
			if (touch2.num > 0)
			{
				if (Ax.touch[1]._t >= Ax.then && Ax.touch[1]._t<Ax.now && Ax.touch[1]._t>0)
				{
					justTouched2 = true;
					rel2 = false;
					updateTouch2();
				}
			}
		}
		
		private function downPressed():void 
		{
			// down
			if (touch1.num >= 0) 
			{
				if (Ax.touch[0]._t > 0)
				{
					down1 = true;
					updateTouch1();
				}
			}
			
			if (touch2.num > 0) 
			{
				if (Ax.touch[1]._t > 0)
				{
					down2 = true;
					updateTouch2();
				}
			}
		}
		
		private function justRelease():void 
		{
			//released
			if (touch1.num < 0 && !rel1)
			{
				justReleased1 = true;
				rel1 = true;
			}
			if (touch2.num < 0 && !rel2)
			{
				justReleased2 = true;
				rel2 = true;
			}
			
			ghost1.x = touch1.x;
			ghost1.y = touch1.y;
			
			ghost2.x = touch2.x;
			ghost2.y = touch2.y;
			
			ghost3.x = touch1.x+ Ax.camera.position.x;
			ghost3.y = touch1.y + Ax.camera.position.y;
			ghost3.num = touch1.num;
		}
		
		
		private function updateTouch1():void
		{
			if (useScreen)
			{
				touch1.x = Ax.touch[0]._x / Ax.zoom;
				touch1.y = Ax.touch[0]._y / Ax.zoom;
			}
			else
			{
				touch1.scrn.x = Ax.touch[0]._x / Ax.zoom;
				touch1.scrn.y = Ax.touch[0]._y / Ax.zoom;
				
				touch1.x = touch1.scrn.x + Ax.camera.position.x;
				touch1.y = touch1.scrn.y + Ax.camera.position.y;
			}
		}
		
		private function updateTouch2():void 
		{
			if (useScreen)
			{
				touch2.x = Ax.touch[1]._x / Ax.zoom;
				touch2.y = Ax.touch[1]._y / Ax.zoom;
			}
			else
			{
				touch2.scrn.x = Ax.touch[1]._x / Ax.zoom;
				touch2.scrn.y = Ax.touch[1]._y / Ax.zoom;
				
				touch2.x = touch2.scrn.x + Ax.camera.position.x;
				touch2.y = touch2.scrn.y + Ax.camera.position.y;
			}
		}
	}
}
