{if !empty($thumbnails)}
{assign var=mq_cols value=($MASONRY_ORDER == 'column')}
<style>
{if $mq_cols}
/* Column order: top-to-bottom then left-to-right (CSS multi-column) */
.masonry-gallery { column-width: {$MASONRY_WIDTH|escape:'html'}px; column-gap: {$MASONRY_GAP|escape:'html'}px; }
.masonry-thumb { break-inside: avoid; margin-bottom: {$MASONRY_GAP|escape:'html'}px; }
{else}
/* Row order: left-to-right then top-to-bottom. Items are distributed into balanced
   flex columns by JS below (round-robin), which keeps reading order and avoids gaps. */
.masonry-gallery { display: flex; gap: {$MASONRY_GAP|escape:'html'}px; align-items: flex-start; }
.masonry-col { display: flex; flex-direction: column; gap: {$MASONRY_GAP|escape:'html'}px; flex: 1 1 0; min-width: 0; }
{/if}
.masonry-thumb { border-radius: {$MASONRY_RADIUS|escape:'html'}px; }
</style>
    <div class="masonry-gallery" data-colwidth="{$MASONRY_WIDTH|escape:'html'}" data-gap="{$MASONRY_GAP|escape:'html'}">
            {foreach from=$thumbnails item=thumbnail}
                <div class="masonry-thumb">
                    <a href="{$thumbnail.URL}">
                        {assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
                        <img draggable="false" src="{$derivative->get_url()}" alt="{$thumbnail.TN_ALT}" title="{$thumbnail.TN_TITLE}">
                    </a>
                </div>
            {/foreach}
    </div>
{if !$mq_cols}
<script>
// Row-order masonry: split the flat thumbnails into N flex columns (N from the container
// width and the configured thumbnail width). Item i goes to column i % N, so reading the
// columns left-to-right yields the original order. No height measurement, no dependency.
(function () {
  function build(grid) {
    var colW = parseInt(grid.getAttribute('data-colwidth'), 10) || 250;
    var gap = parseInt(grid.getAttribute('data-gap'), 10) || 10;
    if (!grid._items) grid._items = Array.prototype.slice.call(grid.children);
    var items = grid._items;
    var n = Math.max(1, Math.floor((grid.clientWidth + gap) / (colW + gap)));
    if (grid._cols === n) return;
    grid._cols = n;
    grid.textContent = '';
    var cols = [];
    for (var c = 0; c < n; c++) {
      var col = document.createElement('div');
      col.className = 'masonry-col';
      grid.appendChild(col);
      cols.push(col);
    }
    for (var i = 0; i < items.length; i++) cols[i % n].appendChild(items[i]);
  }
  function run() {
    var grids = document.getElementsByClassName('masonry-gallery');
    for (var i = 0; i < grids.length; i++) build(grids[i]);
  }
  var t;
  window.addEventListener('resize', function () { clearTimeout(t); t = setTimeout(run, 150); });
  run();
})();
</script>
{/if}
{/if}
{combine_css path="plugins/piwigo_masonry_grid/template/masonry.css"}
