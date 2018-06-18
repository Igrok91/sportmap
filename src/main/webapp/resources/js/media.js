function getMedia() {
    setTimeout(function() {
        var adsParams = {"ad_unit_id":105219,"ad_unit_hash":"09c7737e7ad2c24e9d6352a2fe7476dd"};
        function vkAdsInit() {
            VK.Widgets.Ads('vk_ads_105219', {}, adsParams);
        }
        if (window.VK && VK.Widgets) {
            vkAdsInit();
        } else {
            if (!window.vkAsyncInitCallbacks) window.vkAsyncInitCallbacks = [];
            vkAsyncInitCallbacks.push(vkAdsInit);
            var protocol = ((location.protocol === 'https:') ? 'https:' : 'http:');
            var adsElem = document.getElementById('vk_ads_105219');
            var scriptElem = document.createElement('script');
            scriptElem.type = 'text/javascript';
            scriptElem.async = true;
            scriptElem.src = protocol + '//vk.com/js/api/openapi.js?154';
            adsElem.parentNode.insertBefore(scriptElem, adsElem.nextSibling);
        }
    }, 0);


}