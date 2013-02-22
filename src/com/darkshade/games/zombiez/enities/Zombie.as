package com.darkshade.games.zombiez.enities {
	import com.darkshade.games.zombiez.states.PlayState;

	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	import com.darkshade.games.zombiez.utils.Assets;

	/**
	 * @author DarkShade
	 */
	public class Zombie extends Entity {
		private var vspeed : Number = 0;
		private var hspeed : Number = 0;
		private var dir : Number = 1;
		private var hp : Number = 10;

		public function Zombie(x : Number = 0, y : Number = 0) {
			super(x, y);
			var image : Image = new Image(Assets.zombieIMG);
			image.originX = 4;
			graphic = image;
			setHitbox(8, 8);
			type = "enemy";
		}

		override public function update() : void {
			super.update();

			dir = (FP.world as PlayState).getPlayer().x >= x ? 1 : -1;
			hspeed = dir / 10;
			if ((FP.world as PlayState).getPlayer().x == x) hspeed = 0;
			if (collide("block", x, y + 1)) {
				vspeed = 0;
				if (collide("block", x + dir, y)) vspeed = -3;
			} else {
				vspeed += 0.3;
			}
			if (collide("bullet", x, y)) {
				hp -= (collide("bullet", x, y) as Bullet).damage;
				FP.world.remove(collide("bullet", x, y));
			}
			if (hp <= 0) FP.world.remove(this);
			hspeed *= 0.95;
			vspeed *= 0.99;
			(graphic as Image).scaleX = dir;
			adjustXPosition();
			adjustYPosition();
		}

		private function adjustXPosition() : void {
			for (var i : int = 0; i < Math.abs(hspeed); i++) {
				if (!collide("block", x + FP.sign(hspeed), y)) {
					x += FP.sign(hspeed);
				} else {
					hspeed = 0;
					break;
				}
			}
		}

		private function adjustYPosition() : void {
			for (var i : int = 0; i < Math.abs(vspeed); i++) {
				if (!collide("block", x, y + FP.sign(vspeed))) {
					y += FP.sign(vspeed);
				} else {
					vspeed = 0;
					break;
				}
			}
		}
	}
}
