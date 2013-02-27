package com.darkshade.games.zombiez.states {
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;

	import com.darkshade.games.zombiez.Level;
	import com.darkshade.games.zombiez.Shop;
	import com.darkshade.games.zombiez.ShopLot;
	import com.darkshade.games.zombiez.enities.Player;
	import com.darkshade.games.zombiez.enities.Zombie;
	import com.darkshade.games.zombiez.utils.Assets;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author DarkShade
	 */
	public class PlayState extends World {
		public static var player : Player;
		private var level : Level;
		private var spawnTimer : Timer;

		public function PlayState() {
			super();
		}

		override public function begin() : void {
			super.begin();

			player = new Player(16, 0);
			add(player);
			level = new Level(0, 0);
			add(level);

			Shop.addLot(ShopLot.pistol);
			Shop.addLot(ShopLot.shotgun);
			Shop.addLot(ShopLot.plasma);

			spawnTimer = new Timer(3600, 0);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawn);
//			spawnTimer.start();
		}

		public function spawn(e : TimerEvent) : void {
			if (active) add(new Zombie(4 + FP.rand(304), 0));
		}

		override public function update() : void {
			super.update();
		}

		public function getPlayer() : Player {
			return player;
		}

		override public function render() : void {
			for (var i : int = 0; i < 20; i++) Draw.graphic(new Image(Assets.bgIMG), i * 16, 0);
			super.render();
		}
	}
}
