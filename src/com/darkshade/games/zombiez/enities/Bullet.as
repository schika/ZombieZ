package com.darkshade.games.zombiez.enities {
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;

	/**
	 * @author DarkShade
	 */
	public class Bullet extends Entity {
		public function Bullet(x : Number = 0, y : Number = 0) {
			super(x, y);
			
			graphic = new Image(new BitmapData(1, 1, true, 0xffffff));
		}
	}
}
