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
		
		public var weapons : Vector.<Weapon> = new Vector.<Weapon>();
		public var currentWeapon : int = 0;
		public var maxhp : Number = 20;
		public var hp : Number = 20;
		public var exp : Number = 0;
		public var maxExp : Number = 100;
		public var level : Number = 1;
		public var money : Number = 100000;

		public function Player(x : Number = 0, y : Number = 0) {
			super(x, y);

			graphic = new Image(Assets.playerIMG);
			(graphic as Image).originX = 4;
			setHitbox(8, 8, 4);
			
			weapons.push(Weapon.pistol);
			weapons[currentWeapon].buyed = true;
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
				if (Input.check(Key.W)) vspeed -= 3;
			} else {
				vspeed += gravity;
			}
			if (Math.abs(hspeed) < 1 && !pressed) {
				hspeed = 0;
			}
			if (Input.pressed(Key.SPACE) && weapons[currentWeapon].ammo > 0) {
				FP.world.add(new Bullet(x, y, dir, weapons[currentWeapon].getDamage()));
				weapons[currentWeapon].ammo--;
			}
			if (Input.pressed(Key.NUMPAD_8)) currentWeapon--;
			if (Input.pressed(Key.NUMPAD_2)) currentWeapon++;
			if (currentWeapon < 0) currentWeapon = weapons.length - 1;
			if (currentWeapon >= weapons.length) currentWeapon = 0;
			var e : Enemy = (collide("enemy", x, y) as Enemy);
			if (e) {
				hp -= e.damage;
				if (!e.collide("block", e.x + (-e.dir * 4), e.y)) e.x += -e.dir * 4;
				if (!collide("block", x + (e.dir * 4), y)) x += e.dir * 4;
			}
			var i : Item = (collide("item", x, y) as Item);
			if (i) {
				i.effect(this);
				FP.world.remove(i);
			}
			if (hp < 0) hp = 0;
			if (exp >= maxExp) {
				level++;
				maxExp = (int(maxExp * 1.4) + 10);
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
			var weaponImg : Image = weapons[currentWeapon].getImage();
			weaponImg.scaleX = dir;
			Draw.graphic(weaponImg, x + (dir * 7), y);
			//Healthbar
			drawHealthbar(16, 16, hp, maxhp);
			//Level status
			Draw.text("Level: " + level, 120, 16, {size: 8});
			//Exp status
			Draw.text("Exp: " + exp + "/" + maxExp, 120, 24, {size: 8});
			//Money Status
			Draw.text("Money: " + money + "$", 200, 16, {size: 8});
			//Ammo status
			Draw.text("Ammo: " + weapons[currentWeapon].ammo, 200, 24, {size: 8});
		}
		
		private function drawHealthbar(dx : Number, dy : Number, value : Number, maxvalue : Number) : void {
			for (var i : int = 0; i < maxvalue / 2; i++) {
				if (value / 2 > i) Draw.graphic(new Image(Assets.heartIMG), dx + i * 8, dy + 2);
				if (value / 2 <= i) Draw.graphic(new Image(Assets.heartdisIMG), dx + i * 8, dy + 2);
				if (value == i * 2 + 1) Draw.graphic(new Image(Assets.heartmidIMG), dx + i * 8, dy + 2);
			}
		}
	}
}
