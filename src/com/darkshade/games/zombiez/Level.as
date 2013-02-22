package com.darkshade.games.zombiez {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	import com.darkshade.games.zombiez.utils.Assets;

	/**
	 * @author DarkShade
	 */
	public class Level extends Entity {
		private var tilemap : Tilemap = new Tilemap(Assets.tilesIMG, 320, 240, 8, 8);
		private var grid : Grid = new Grid(320, 240, 8, 8);

		public function Level(x : Number = 0, y : Number = 0) {
			super(x, y, tilemap, grid);
			type = "block";
			for (var i : int = 0; i < 40; i++) {
				tilemap.setTile(i, 29);
				grid.setTile(i, 29);
			}
		}
	}
}
