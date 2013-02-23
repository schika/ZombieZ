package com.darkshade.games.zombiez.enities {
	import net.flashpunk.utils.Draw;

	import com.darkshade.games.zombiez.Weapon;

	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	import com.darkshade.games.zombiez.utils.Assets;

	/**
	 * @author DarkShade
	 */
	public class Player extends Entity {
		private var speed : Number = 1.5;
		private var vspeed : Number = 0.0;
		private var hspeed : Number = 0.0;
		private var gravity : Number = 0.3;
		private var dir : Number = 1;
		private var weapon : Weapon = Weapon.pistol;
		private var hp : Number = 10;
		private var maxhp : Number = 10;

		public function Player(x : Number = 0, y : Number = 0) {
			super(x, y);

			graphic = new Image(Assets.playerIMG);
			(graphic as Image).originX = 4;
			setHitbox(8, 8);
		}

		override public function update() : void {
			super.update();
			var pressed : Boolean = false;
			if (Input.check(Key.D)) {
				hspeed = speed;
				pressed = true;
				dir = 1;
			}
			if (Input.check(Key.A)) {
				hspeed = -speed;
				pressed = true;
				dir = -1;
			}
			if (collide("block", x, y + 1)) {
				vspeed = 0;
				if (Input.pressed(Key.W)) vspeed -= 3;
			} else {
				vspeed += gravity;
			}
			if (Math.abs(hspeed) < 1 && !pressed) {
				hspeed = 0;
			}
			if (Input.pressed(Key.SPACE)) {
				FP.world.add(new Bullet(x, y, dir, weapon.getDamage()));
			}
			var e : Enemy = (collide("enemy", x, y) as Enemy);
			if (e) {
				hp -= e.damage;
				e.x += -e.dir * 4;
				x += e.dir * 4;
			}
			
			hspeed *= 0.95;
			vspeed *= 0.99;
			
			if (x < 0) x = 0;
			if (x > 312) x = 312;
			if (y < 0) y = 0;
			if (y > 232) y = 232;
			
			adjustXPosition();
			adjustYPosition();
			
			
			(graphic as Image).scaleX = dir;
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

		override public function render() : void {
			super.render();
			var weaponImg : Image = weapon.getImage();
			weaponImg.scaleX = dir;
			Draw.graphic(weaponImg, x + (dir * 7), y);
			
			Draw.rect(16, 16, 32 / maxhp * hp, 4, 0xf84040);
			Draw.rectPlus(16, 16, 32, 4, 0x000000, 1, false);
		}
	}
}
