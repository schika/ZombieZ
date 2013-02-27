package com.darkshade.games.zombiez.enities {
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	import com.darkshade.games.zombiez.states.PlayState;
	import com.darkshade.games.zombiez.utils.Assets;
	import com.darkshade.games.zombiez.utils.Effect;

	/**
	 * @author DarkShade
	 */
	public class Zombie extends Enemy {
		private var hp : Number = 10;
		private var takenDamage : Boolean = false;

		public function Zombie(x : Number = 0, y : Number = 0) {
			super(x, y, 1, 10, 10);
			var image : Image = new Image(Assets.zombieIMG);
			image.originX = 4;
			graphic = image;
			setHitbox(8, 8, 4);
			type = "enemy";
		}

		override public function update() : void {
			super.update();
			if (takenDamage) takenDamage = false;
			dir = (FP.world as PlayState).getPlayer().x >= x ? 1 : -1;
			hspeed = dir * 1;
			if ((FP.world as PlayState).getPlayer().x == x) hspeed = 0;
			if (collide("block", x, y + 1)) {
				vspeed = 0;
				if (collide("block", x + dir, y)) vspeed = -3;
			} else {
				vspeed += 0.3;
			}
			var b : Bullet = collide("bullet", x, y) as Bullet;
			if (b) {
				hp -= b.damage;
				FP.world.remove(b);
				if (!collide("block", x - dir * 4, y)) x -= dir * 4;
				takenDamage = true;
				FP.world.add(new Effect(x + (dir * 8), y + 4, 0xff0000, 25));
			}
			if (hp <= 0) FP.world.remove(this);
			hspeed *= 0.95;
			vspeed *= 0.99;
			(graphic as Image).scaleX = dir;
			adjustXPosition();
			adjustYPosition();
		}
		
		
		override public function render() : void {
			super.render();
			if (takenDamage) {
				(graphic as Image).color = 0xff0000;
			} else {
				(graphic as Image).color = 0xffffff;				
			}
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
