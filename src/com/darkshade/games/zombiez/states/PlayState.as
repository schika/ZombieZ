package com.darkshade.games.zombiez.states {
	import net.flashpunk.FP;
	import com.darkshade.games.zombiez.enities.Zombie;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.World;

	import com.darkshade.games.zombiez.Level;
	import com.darkshade.games.zombiez.enities.Player;

	/**
	 * @author DarkShade
	 */
	public class PlayState extends World {
		private var player : Player;
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
			
			spawnTimer = new Timer(3600, 0);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawn);
			spawnTimer.start();
		}
		
		public function spawn(e:TimerEvent) : void {
			add(new Zombie(8 + FP.rand(304), 0));
		}

		public function getPlayer() : Player {
			return player;
		}
	}
}
