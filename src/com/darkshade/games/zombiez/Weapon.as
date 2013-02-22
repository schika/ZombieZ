package com.darkshade.games.zombiez {
	import com.darkshade.games.zombiez.utils.Assets;
	import net.flashpunk.graphics.Image;
	/**
	 * @author DarkShade
	 */
	public class Weapon {
		
		public static var pistol : Weapon = new Weapon("Pistol", Assets.pistolIMG, 3);
		
		private var damage : Number = 0;
		private var image : Image = null;
		private var name : String = "";
		
		public function Weapon(name:String, img:*, damage:Number) {
			this.name = name;
			this.image = new Image(img);
			this.image.originX = 4;
			this.damage = damage;
		}
		
		public function getDamage() : Number {
			return damage;
		}
		
		public function getImage() : Image {
			return image;
		}
		
	}
}
