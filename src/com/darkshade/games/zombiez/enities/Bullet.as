package com.darkshade.games.zombiez.enities {
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;

	/**
	 * @author DarkShade
	 */
	public class Bullet extends Entity {
		private var dir : Number = 1;
		public var damage : Number = 1;
		public function Bullet(x : Number = 0, y : Number = 0, dir : Number = 1, damage : Number = 1) {
			super(x + (dir == 1 ? 8 : 0), y + 3);
			
			this.dir = dir;
			this.damage = damage;
			
			var image:Image = new Image(new BitmapData(1, 1, false, 0xffffff));
			image.originX = dir == -1 ? 0 : 7;
			image.originY = 3;
			image.scaleX = dir;
			graphic = image;
			
			setHitbox(1, 1);
			type = "bullet";			
		}

		override public function update() : void {
			super.update();
			x += dir * 5;
			if (x < 0 || x > 320) FP.world.remove(this);
		}

	}
}
