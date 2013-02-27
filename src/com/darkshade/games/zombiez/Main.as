package com.darkshade.games.zombiez {
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
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
			FP.console.enable();
			FP.world = new PlayState();
		}

		override public function update() : void {
			super.update();
			if (Shop.shopOpen) Shop.update();
			if (Input.pressed(Key.F)) Shop.shopOpen = !Shop.shopOpen;
			if (Shop.shopOpen) FP.world.active = false;
			else FP.world.active = true;
		}

		override public function render() : void {
			super.render();
			if (Shop.shopOpen){
				Shop.draw();
			}
		}

	}
}
