'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "2d2856f466bd9010a8a392033ecc853c",
"version.json": "1d4be4e0d0e1aad5d1b2054c5d04f9d2",
"index.html": "789db43390bdd2a40d0e4d793d4c387e",
"/": "789db43390bdd2a40d0e4d793d4c387e",
"main.dart.js": "959c03177b4968998be978d8b71c83d0",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "f2322acdce9aa22a6e2469f762f6cae1",
"icons/Icon-192.png": "19b6bf7c93d54f8b6c10197a7eb3fa2a",
"icons/Icon-maskable-192.png": "19b6bf7c93d54f8b6c10197a7eb3fa2a",
"icons/Icon-maskable-512.png": "e2da0a423c43bcaae2f0a16bfe73f56d",
"icons/Icon-512.png": "e2da0a423c43bcaae2f0a16bfe73f56d",
"manifest.json": "cbec44a386543b7583a839658b38c9b3",
"assets/AssetManifest.json": "717493e66b808a49a9762977ef0393c0",
"assets/NOTICES": "9ed3fc2d177cbc42b56b7db7f82f4ace",
"assets/FontManifest.json": "f3ab867e14371906d920119618756607",
"assets/AssetManifest.bin.json": "0f2a2317fa34f818401227ddcb1cab51",
"assets/packages/golden_toolkit/fonts/Roboto-Regular.ttf": "ac3f799d5bbaf5196fab15ab8de8431c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2598b6e5ab4bcc940ff3392552499742",
"assets/fonts/MaterialIcons-Regular.otf": "2207eae7eaa401c8fc5568edcca34468",
"assets/assets/images/test.png": "f5dddee546c0fb525a6731915facaeee",
"assets/assets/icons/country_russia.svg": "16160bfd2aa7b7d52f1160fc1644c72d",
"assets/assets/icons/country_kyrgyzstan.svg": "b86278f03a7819140d6b5bfdb9885253",
"assets/assets/icons/country_tajikistan.svg": "33f5c62ab865ba34ee03c02892ce734d",
"assets/assets/icons/card_visa.svg": "29df04ab8014d931b0ec75210f971465",
"assets/assets/icons/country_not_selected.svg": "9e47ddddc6f68bc44e1bdfcd125fdac4",
"assets/assets/icons/country_kazakhstan.svg": "f2ca15921ab8bdee6a04ccddd540cd62",
"assets/assets/icons/card_mir.svg": "a874f2bdc4b4995d203afb6f3f34f437",
"assets/assets/icons/card_unionpay.svg": "4cceb974b4de730eab3880f8692b34aa",
"assets/assets/icons/country_uzbekistan.svg": "74d03efe61708c519e38cc40d3f73d09",
"assets/assets/icons/card_mastercard.svg": "a336566463927544769b1f4cd8470d7c",
"assets/assets/icons/astrasend_loader.svg": "235c433445117005ae10cda9ea4a994c",
"assets/assets/fonts/WixMadeforDisplay-Bold.ttf": "75eecb27970993a23aa215716cc0a62e",
"assets/assets/fonts/astrasend_icons_config.json": "ee8e39f23f551e43622d4bdcb39f1098",
"assets/assets/fonts/WixMadeforDisplay-ExtraBold.ttf": "b733e1dc30c6d6d42a7457e5a1b66bca",
"assets/assets/fonts/WixMadeforDisplay-Medium.ttf": "599a6cc932b4cccbcd748bc827ddbe8a",
"assets/assets/fonts/astrasend_icons.ttf": "6558aa8487da9adcb911266687ba97b6",
"assets/assets/fonts/WixMadeforDisplay-Regular.ttf": "2a85a3a77fe59d0ab9477a5b4b7ba312",
"assets/assets/fonts/WixMadeforDisplay-SemiBold.ttf": "bd1d625ac76df940768e610bc1e96d38",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
