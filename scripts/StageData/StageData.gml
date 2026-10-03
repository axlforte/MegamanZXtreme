function StageData(_tileset, _tiles, _collision) constructor{
  music = "strikeman"
  graphics = [
    {
      tileset: _tileset,
      tiles: _tiles
    }
  ]
  collision = _collision;
  stage_x = 64.0
  stage_y = 64.0
}