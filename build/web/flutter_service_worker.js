'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "474e8d904026efcf3094edc0b86e99b9",
"version.json": "96b99dddc0b0e28d1da8e2895bcc280b",
"splash/img/light-2x.png": "a413cd00d4ed7844790b04a5ec935379",
"splash/img/dark-4x.png": "606fef7b44b619c841357fae297ad901",
"splash/img/light-3x.png": "3f004849fb97e5f291e6f1ad136778b5",
"splash/img/dark-3x.png": "3f004849fb97e5f291e6f1ad136778b5",
"splash/img/light-4x.png": "606fef7b44b619c841357fae297ad901",
"splash/img/dark-2x.png": "a413cd00d4ed7844790b04a5ec935379",
"splash/img/dark-1x.png": "516c9ea1bf0567cad3322eb1b641a8eb",
"splash/img/light-1x.png": "516c9ea1bf0567cad3322eb1b641a8eb",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"splash/style.css": "db6178791b6369b77311c0ae92809585",
"index.html": "4d7fa191efada4d85b105f7151353a40",
"/": "4d7fa191efada4d85b105f7151353a40",
"main.dart.js": "8ff757936497c72b42b11b680c08c1e2",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "275578a739c6b5162ebc5533f1323224",
"icons/Icon-192.png": "ffff039778d4a24199975aa752c70bf1",
"manifest.json": "1acf6b201ea4beb6f299a8a885dcfc65",
"assets/AssetManifest.json": "fa0c92a9766aabb352d4bb46ecde1181",
"assets/NOTICES": "587d8fd75edfcd89e50dbe07ec1f968a",
"assets/FontManifest.json": "afb45805793b827f52fa4ef1ee71a43c",
"assets/AssetManifest.bin.json": "cc73167830841a54635ee03d62b34f4a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "551fbdd0a87debed9a8e444a6cf7e0d9",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"assets/packages/flutter_neumorphic_plus/fonts/NeumorphicIcons.ttf": "32be0c4c86773ba5c9f7791e69964585",
"assets/packages/smooth_compass/assets/images/compass.png": "b3a1762793e87ac0beff6896e1f68a78",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "3b6799883af4251104bccdb7263a0a87",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "d9c50950e26be29102a039847bac0118",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d8a34039274f077621eef943bebecde3",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/flutter_feather_icons/fonts/feather.ttf": "40469726c5ed792185741388e68dd9e8",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "77cedbe11e4c5e667fb6229f654420ec",
"assets/fonts/MaterialIcons-Regular.otf": "0bfeea612c82803bddb52367e87d0bd6",
"assets/assets/email.png": "637eddd830024424d50804475f585f07",
"assets/assets/settings.png": "dd55fdc53362d4b351039dc5fe6d7d90",
"assets/assets/tasbih.png": "d01c0adf01416173a32d30f5be35b4e6",
"assets/assets/qibla.png": "b3a727211d3fdd9610dfbb68d6de756e",
"assets/assets/books.png": "582182a005b9c2d75f6b553b9fd9780c",
"assets/assets/needle.svg": "8899f282d1cf9118c8f4041ccf38d9ab",
"assets/assets/hadith.png": "7655e2f5225a6645a884980d8b61b223",
"assets/assets/sunrise.png": "556e82dae09ed3d12b4436711c3978f5",
"assets/assets/quran.png": "3b2ddd091a6f21f348bbb9e7f3ee6c88",
"assets/assets/salat_back.png": "472330b493b3947cdf765efba65c7005",
"assets/assets/masjid_icon.json": "06d6e4c9db2e05ba23748a3a146a242b",
"assets/assets/mosque_background.jpg": "3a82d76c1505d564e7bbc56713990f59",
"assets/assets/tap.mp3": "0bb3840049183148f22249bcd8c7ef52",
"assets/assets/evening.png": "442c6b9df548690c0994b9d43703f560",
"assets/assets/madina.jpg": "2c8df355c7e0dd3fb53c6a7340c309a1",
"assets/assets/hadith.json": "a6ade50e5950e82b4da06eb42eb65360",
"assets/assets/video_red.png": "d56ba7e1a560781d045d0e24758bd11e",
"assets/assets/asked.png": "d67cbda4cfc3d2abbd9fdd210699998f",
"assets/assets/logo.png": "606fef7b44b619c841357fae297ad901",
"assets/assets/blog.png": "6139bac366cd64f6bcea9c4598dfa13e",
"assets/assets/calendar.png": "a1ab19a5926f656f3c850f16ef91036c",
"assets/assets/loader.json": "7028a20fadc6e3e4b34cabc51884f044",
"assets/assets/video.png": "d6396984a28f4e1abf26773c8f3f4c43",
"assets/assets/bangla_quran.json": "c98bff41852762b02baf4493d5ad776a",
"assets/assets/compass.svg": "5414969787686d65980d43544cc68397",
"assets/assets/language_icon.json": "84f53137990ca6c4aa0e5a2eb8633c42",
"assets/assets/sun.png": "94803ad69cbe5d4816b69b5a7c2b0fc3",
"assets/assets/fonts/Sofia-Pro-Bold.ttf": "83de3419765ec43f868a4bd99bc01ada",
"assets/assets/fonts/sofiapro-light.otf": "6bf30b6ebc3c6b3c75070d42c4b289c1",
"assets/assets/fonts/Ador-SemiBold.ttf": "53b43721854127c319c8ae7beee24861",
"assets/assets/fonts/al_qalam.ttf": "b4f709b94e4b16d2b847ccb3e35dffed",
"assets/assets/fonts/Ador-Regular.ttf": "a9bab4af564b06c78af32877ddc8d23d",
"assets/assets/fonts/bangla.ttf": "7822c0925879fecd95e4c1d94963a0f2",
"assets/assets/fajr.png": "eaa4333aaec5d869bb9b0f10db2123bc",
"assets/assets/night.png": "23367506ae115b2a7c5fee247f468e71",
"assets/assets/location_icon.json": "6bd40e759be4f303b3527ccdd23ede51",
"assets/assets/notification.png": "30a3a340bba60ca6215fad5b88ffa6e7",
"assets/assets/mecca.png": "eb7ac127b9be1115228239d884554a29",
"assets/assets/zakat.png": "46aef56f981bfd39b8a93c95cd3a8aa2",
"assets/assets/99names.png": "6b6a12efa1817350878c96449343ff57",
"assets/assets/allah_names.json": "60cb8962ba70958bc9062615abfdf4ea",
"assets/assets/arabic_quran.json": "a4549ed11a3ab30d6704fb8ff2db95a4",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
