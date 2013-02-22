package com.darkshade.games.zombiez {
	import com.darkshade.games.zombiez.states.PlayState;
	import net.flashpunk.FP;
	import net.flashpunk.Engine;

	/**
	 * @author DarkShade
	 */
	public class Main extends Engine {
		public function Main() {
			super(320, 240, 60);
			
			FP.screen.scale = 2;
//			FP.console.enable();
			FP.world = new PlayState();
		}
	}
}
