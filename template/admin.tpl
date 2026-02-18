<div class="titrePage">
  <h2>Masonry Grid</h2>
  <p>Configure thumbnail width, gap and images per page.</p>
</div>

<form method="post" action="">
  <fieldset>
    <legend>Thumbnails</legend>
    <p>
      <label for="width">Thumbnail width (px)</label>
      <input type="number" min="1" id="width" name="width" value="{$MASONRY_WIDTH|escape:'html'}">
    </p>
    <p>
      <label for="gap">Gap between thumbnails (px)</label>
      <input type="number" min="0" id="gap" name="gap" value="{$MASONRY_GAP|escape:'html'}">
    </p>
    <p>
      <label for="corner_radius">Thumbnail corner radius (px)</label>
      <input type="number" min="0" id="corner_radius" name="corner_radius" value="{$MASONRY_RADIUS|escape:'html'}">
    </p>
    <p>
      <label for="nb_image_page">Photos per page</label>
      <input type="number" min="1" id="nb_image_page" name="nb_image_page" value="{$MASONRY_NB_IMAGE|escape:'html'}">
    </p>
  </fieldset>
  <p class="formButtons">
    <input type="hidden" name="pwg_token" value="{$PWG_TOKEN}">
    <input class="submit" type="submit" name="submit" value="Save settings">
  </p>
</form>
