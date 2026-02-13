{if !empty($thumbnails)}
    <div class="masonry-gallery">
            {foreach from=$thumbnails item=thumbnail}
                <div class="masonry-thumb">
                    <a href="{$thumbnail.URL}" data-img="{$thumbnail.ORIGINAL_FILE_URL}">
                        {assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
                        <img draggable="false" src="{$derivative->get_url()}" alt="{$thumbnail.TN_ALT}" title="{$thumbnail.TN_TITLE}">
                    </a>
                </div>
            {/foreach}
    </div>
{/if}
{combine_css path="plugins/piwigo_masonry_grid/template/masonry.css"}
