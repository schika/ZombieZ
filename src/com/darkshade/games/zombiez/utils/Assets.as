package com.darkshade.games.zombiez.utils {
	import flash.display.BitmapData;
	/**
	 * @author DarkShade
	 */
	public class Assets {
		[Embed(source="../assets/images/player.png")]
		public static var playerIMG : Class;
		[Embed(source="../assets/images/tiles.png")]
		public static var tilesIMG : Class;
		[Embed(source="../assets/images/zombie.png")]
		public static var zombieIMG : Class;
		[Embed(source="../assets/images/pistol.png")]
		public static var pistolIMG : Class;
		[Embed(source="../assets/images/plasma.png")]
		public static var plasmaIMG : Class;
		[Embed(source="../assets/images/shotgun.png")]
		public static var shotgunIMG : Class;
		[Embed(source="../assets/images/hpkit.png")]
		public static var hpkitIMG : Class;
		[Embed(source="../assets/images/ammo.png")]
		public static var ammoIMG : Class;
		
		[Embed(source="../assets/images/heart.png")]
		public static var heartIMG : Class;
		[Embed(source="../assets/images/heart_dis.png")]
		public static var heartdisIMG : Class;
		[Embed(source="../assets/images/heart_mid.png")]
		public static var heartmidIMG : Class;
		
		[Embed(source="../assets/images/bg.png")]
		public static var bgIMG : Class;
		
		public static var empty : BitmapData = new BitmapData(8, 8, true);
	}
}
