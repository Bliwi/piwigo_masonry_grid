{if !empty($thumbnails)}
<style>
.masonry-gallery { gap: {$MASONRY_GAP|escape:'html'}px; }
@supports (grid-template-rows: masonry) {
  .masonry-gallery { grid-template-columns: repeat(auto-fit, minmax({$MASONRY_WIDTH|escape:'html'}px, 1fr)); }
}
@supports not (grid-template-rows: masonry) {
  .masonry-gallery { column-width: {$MASONRY_WIDTH|escape:'html'}px; column-gap: {$MASONRY_GAP|escape:'html'}px; }
  .masonry-thumb { margin-bottom: {$MASONRY_GAP|escape:'html'}px; }
}
.masonry-thumb { border-radius: {$MASONRY_RADIUS|escape:'html'}px; }
</style>
    <div class="masonry-gallery">
            {foreach from=$thumbnails item=thumbnail}
                <div class="masonry-thumb">
                    <a href="{$thumbnail.URL}">
                        {assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
                        <img draggable="false" src="{$derivative->get_url()}" alt="{$thumbnail.TN_ALT}" title="{$thumbnail.TN_TITLE}">
                    </a>
                </div>
            {/foreach}
    </div>
{/if}
{combine_css path="plugins/piwigo_masonry_grid/template/masonry.css"}
