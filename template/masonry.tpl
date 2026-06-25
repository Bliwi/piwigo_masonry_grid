{if !empty($thumbnails)}
{assign var=mq_cols value=($MASONRY_ORDER == 'column')}
<style>
{if $mq_cols}
/* Column order: top-to-bottom then left-to-right (CSS multi-column) */
.masonry-gallery { column-width: {$MASONRY_WIDTH|escape:'html'}px; column-gap: {$MASONRY_GAP|escape:'html'}px; }
.masonry-thumb { break-inside: avoid; margin-bottom: {$MASONRY_GAP|escape:'html'}px; }
{else}
/* Row order: photos read left-to-right then top-to-bottom. JS below distributes them into
   balanced flex columns (each photo to the shortest column), which keeps reading order on
   the first row and balances column heights so mixed portrait/landscape stays tidy. */
.masonry-gallery { display: flex; gap: {$MASONRY_GAP|escape:'html'}px; align-items: flex-start; }
.masonry-col { display: flex; flex-direction: column; gap: {$MASONRY_GAP|escape:'html'}px; flex: 1 1 0; min-width: 0; }
{/if}
.masonry-thumb { border-radius: {$MASONRY_RADIUS|escape:'html'}px; }
</style>
    <div class="masonry-gallery" data-colwidth="{$MASONRY_WIDTH|escape:'html'}" data-gap="{$MASONRY_GAP|escape:'html'}">
            {assign var=mq_idx value=0+$START_ID}
            {foreach from=$thumbnails item=thumbnail}
                {assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
                {assign var=dsz value=$derivative->get_size()}
                <div class="masonry-thumb" data-ar="{if $dsz[0] > 0}{$dsz[1]/$dsz[0]}{else}1{/if}">
                    <a href="{$thumbnail.URL}">
                        {assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
                        <img draggable="false" src="{$derivative->get_url()}" alt="{$thumbnail.TN_ALT}" title="{$thumbnail.TN_TITLE}">
                    </a>
                </div>
            {assign var=mq_idx value=$mq_idx+1}
            {/foreach}
    </div>
{if !$mq_cols}
<script>
// Row-order masonry: split the flat thumbnails into N flex columns (N from the container
// width and the configured thumbnail width), placing each photo into the currently shortest
// column. The first row keeps the original left-to-right order and columns stay balanced for
// mixed portrait/landscape sets. Heights come from data-ar (server-side), so no measuring.
(function () {
  function build(grid) {
    var colW = parseInt(grid.getAttribute('data-colwidth'), 10) || 250;
    var gap = parseInt(grid.getAttribute('data-gap'), 10) || 10;
    if (!grid._items) grid._items = Array.prototype.slice.call(grid.children);
    var items = grid._items;
    var n = Math.max(1, Math.floor((grid.clientWidth + gap) / (colW + gap)));
    grid.textContent = '';
    var realColW = (grid.clientWidth - (n - 1) * gap) / n;
    var gapU = realColW > 0 ? gap / realColW : 0;   // gap expressed in column-width units
    var cols = [], h = [];
    for (var c = 0; c < n; c++) {
      var col = document.createElement('div');
      col.className = 'masonry-col';
      grid.appendChild(col);
      cols.push(col);
      h.push(0);
    }
    for (var i = 0; i < items.length; i++) {
      var min = 0;
      for (var c = 1; c < n; c++) if (h[c] < h[min]) min = c;   // shortest column, ties -> leftmost
      cols[min].appendChild(items[i]);
      var ar = parseFloat(items[i].getAttribute('data-ar')) || 1;
      h[min] += ar + (h[min] > 0 ? gapU : 0);
    }
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
