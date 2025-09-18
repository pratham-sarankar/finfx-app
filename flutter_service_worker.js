'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"CNAME": "d493ec38cf48b25f01acc1aac6c01832",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.wasm": "169ed420dd738c7009f23897582371ff",
"manifest.json": "5dfd96dbe5df30d8c660d96c89e961e6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "8523df54e57029f7fae33ec0b744cfb7",
"version.json": "d257e5d547591f5247bef6c723a9ed2e",
"assets/NOTICES": "ee9db2f7ce3bfc7ce5345015ac4f02bb",
"assets/fonts/MaterialIcons-Regular.otf": "15260f218947d50f141a3db8b39767f0",
"assets/AssetManifest.json": "e18fe7cc044b54bfb47bf084b8d957e2",
"assets/assets/images/Coinbase.png": "6c2725f2e3812c7327f8acfd52f6c8d3",
"assets/assets/images/Google_1.png": "63af1dfcee35c282b6b0b429637554bd",
"assets/assets/images/india.png": "d8f55a9100d2fb2099bb3e0febb5fdc2",
"assets/assets/images/Genesis2.png": "46da214a5a29f2f57c07fc0d09f7b3a6",
"assets/assets/images/Whatsapp.png": "5613ac6849d010279cd752531abee8c6",
"assets/assets/images/cashback.png": "99468c37ed9e9014840ab19d3795db8d",
"assets/assets/images/Consumer.png": "f866599ea4c39d9659a2e32a9d946b2c",
"assets/assets/images/Card%25203.png": "b1f152a6d2bd3601296d6f37f4d247b5",
"assets/assets/images/Genesis_art.png": "e6788b0daa9f9708126ebd2dc9ea9eed",
"assets/assets/images/Get2.png": "246e1e8cdebb376cc6737378ff6ec6c5",
"assets/assets/images/Chypher.png": "75626250daa8041fb17575daf7791b0d",
"assets/assets/images/Citi%2520outlined.png": "10b946db09f542035148177d0a4a4e39",
"assets/assets/images/china.png": "b4a241ab7581cec5290118ceddb37bd1",
"assets/assets/images/Genesis_artiku2.png": "b2c1bf5a7c4142bc03b08c8d70ba4595",
"assets/assets/images/Portfolio.png": "d2ece877b4202607a47ea6e71d5792a6",
"assets/assets/images/Ostored.png": "5377858ae79d6991acb3d98f40704aa2",
"assets/assets/images/home.png": "bb107dffa829c47c3db9841e7ad5da47",
"assets/assets/images/Offer.png": "cac66ce05fa0c6c0aed6a0d6c46cf2be",
"assets/assets/images/Bitcoin.png": "32dd844f1158373209846dd122a79d13",
"assets/assets/images/Background%2520(2).png": "bfcbb6f84c58df56686f33446d88945d",
"assets/assets/images/Genesis.png": "979cc38cb757ca4514cb4d524573cd36",
"assets/assets/images/SOL.png": "f2f35ec32065127c34726bfd298fb4bd",
"assets/assets/images/gold_usa.png": "75fe0fb8d79ed97dba60e20566e1c012",
"assets/assets/images/Market_fill.png": "2057812c72791764d55beb79307d967c",
"assets/assets/images/Communication.png": "66001daccb9199da1031e7cad99e9a7f",
"assets/assets/images/Genesis1_icon.png": "9901639e188a06481d89472bcfb825ab",
"assets/assets/images/gold_icon.png": "b41464fe22cc5704da8a2d4216c21511",
"assets/assets/images/ukraine.png": "95722e6bdc17a6fd835d210de3b5952d",
"assets/assets/images/women1.png": "18b7fe527bc5d1f5ca1c692f972062b3",
"assets/assets/images/join%2520team.png": "68441d262e9434f95005dfc6a330c8b4",
"assets/assets/images/ruppes_green.png": "8f552d3b28757d4b9a30e871897fdef3",
"assets/assets/images/Energy.png": "b4935859b33d5a656f257894ba666a92",
"assets/assets/images/app-icon.png": "74025b3b0ca18638bd70c2c4b156697c",
"assets/assets/images/Expressions.png": "1d8558fb34d9efc678a40ef0cfd676d4",
"assets/assets/images/question-circle-outlined.png": "ae92eb723eacde7f3683a80879b4b672",
"assets/assets/images/Liquid.png": "5d93911effd34cca01666af56529dfe5",
"assets/assets/images/Instagram%2520outlined.png": "7b49d90c70c99c5836f48a663ec9d743",
"assets/assets/images/Search.png": "52a7dffdb42a8360e55d83106784b9b3",
"assets/assets/images/arrow-bar-up.png": "ff6abb0498345170f6b3417e095864be",
"assets/assets/images/Moonbirds.png": "fab565ead6a120f38990a603e14c04b4",
"assets/assets/images/angle-down.png": "aa89ee49f3f0de484ed846d09408c2ac",
"assets/assets/images/Nemus.png": "7740a2b9aa3d254890485e19e53c36e3",
"assets/assets/images/face%2520id.png": "89849b82804162ad2aa84785989f3f6e",
"assets/assets/images/italy.png": "ab05a524b299fafe60244b910765c097",
"assets/assets/images/Card%25204.png": "d3510c2e4dec7756ae6432461de256d6",
"assets/assets/images/Question%2520asked.png": "def40f8c1d238a77fe42e98c2398e72d",
"assets/assets/images/Gift1.png": "8318deaa6a33f6884419da7cd5a3bff9",
"assets/assets/images/ABNB%2520Chart.png": "74aaa388025ef5771ecc10a1a3dd7f6b",
"assets/assets/images/Succesfully.png": "b9f2c361640bc97462fcdbaf7483d7b7",
"assets/assets/images/polygon.png": "ddb298c94c1420bb609bea04dc62971f",
"assets/assets/images/UBS.png": "0f1a4038b2402808db7735b2171eb9f2",
"assets/assets/images/bnb.png": "683b623be1b4d83aac51d84fd500c7ee",
"assets/assets/images/Genesis_icon.png": "3ea1f71d9ca26cd96ad984a633020e72",
"assets/assets/images/Wells.png": "361867740c3309596a5d61e3b18d4be5",
"assets/assets/images/message.png": "dcf03fbe1938fe6ab8c3d27c3267bd04",
"assets/assets/images/Bank%2520of%2520america.png": "141db479c64fc5bd5e50316c01083f20",
"assets/assets/images/Crystal.png": "98483be32d20b3cc09e9b6a31f58c682",
"assets/assets/images/Genesis_artiku.png": "8eb769a24ac53a00a4a6d05534ea64ad",
"assets/assets/images/Industry.png": "05fb85c60ff5b4cf4a99925b8a1983ac",
"assets/assets/images/passport.png": "a79a8bdaef3f665adfd58872d76859b3",
"assets/assets/images/exchange.png": "2c7f5af901c8370c9fafef52fdd020f7",
"assets/assets/images/Sim%2520card.png": "9962315313bfae346f196e649b9c9a15",
"assets/assets/images/Airbnb.png": "68a044c29b9bb9bfdebc460fa359a515",
"assets/assets/images/Spacy.png": "115ac4bf55cd07a7161f2d06ff6ed55a",
"assets/assets/images/mail_.png": "92d461d6dc747740288e5dec6a003313",
"assets/assets/images/Genesis13.png": "3c999a7c395418c0234e250c04f30dc5",
"assets/assets/images/spain.png": "69bf7c3df4b222c445bf6ebffec278e6",
"assets/assets/images/Genesis12_icon.png": "59d38d302b0f0f7706ad6c8f12a34fa8",
"assets/assets/images/mt5.png": "c2c4fea7aec206aab237c39deda777ac",
"assets/assets/images/refresh-circle.png": "14abe37e5fa7a46e864123346fb8a8ce",
"assets/assets/images/Lock.png": "ae6e4ed10d4bf40278a68e96d7653b6c",
"assets/assets/images/Alert_circle.png": "f4eac8faf4b108d089f3d8147a29b35d",
"assets/assets/images/united-states.png": "c7ef7aeea67ae3612237fefcaa3b8db3",
"assets/assets/images/notification.png": "7a87146ae77ecad2268dcc50f873645a",
"assets/assets/images/Ethereum%2520(ETH)icon.png": "204fc562dfcd107d3b037db7595fbba0",
"assets/assets/images/Real%2520Estate.png": "36c944c87d554549832256682c63fcb6",
"assets/assets/images/profile.png": "cf9d03a847acea311c29e8c05b5f38c3",
"assets/assets/images/apple-logo.png": "4f658b9a7d067de5238644b78d8d09cc",
"assets/assets/images/Sky_high.png": "686476830299a415cd870e0a41d3ea19",
"assets/assets/images/Krishna.jpg": "e31b9531d5df8c1864bf1dfe9e8d274d",
"assets/assets/images/Twitter.png": "c44ff1e8b2b94310ae5138110bdb1dce",
"assets/assets/images/BTC_USDT.png": "c070729f76632541b9d36de11b32a0f6",
"assets/assets/images/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/images/Card%25201.png": "668c6d43db6867b01c9ade933ba39d85",
"assets/assets/images/Down_red_arrow.png": "2864aad0e34a04c74db7f5ad43de38a2",
"assets/assets/images/gold_japan.png": "07f01a2c7d78c2f3c2581bfecb2060b8",
"assets/assets/images/DAI.png": "b2bce8f91cea4575ca753c6ac4feaf67",
"assets/assets/images/Crystal%25203.png": "7b45949660afe52e48bbe2005f576be6",
"assets/assets/images/Paypal.png": "3710b4ec36534e28e38cfdd284a15c94",
"assets/assets/images/buy_sell.png": "b6042a85b594fbe83a2d0eaa3d96245b",
"assets/assets/images/Mango%2520hack.png": "2308825321cd349ec5f4dc51d351422c",
"assets/assets/images/Utilities.png": "0642f679a1c06ea6e58767e93032b627",
"assets/assets/images/germany.png": "85ca59c60c9179d7b3e9b6ab03b407c7",
"assets/assets/images/SHIB.png": "ac441f57820bf7ab92c297d5c08e5924",
"assets/assets/images/Discord.png": "482fd81db657572fa7ab0f38c7810de3",
"assets/assets/images/robot.png": "f2636320661fc18273b35531f2e36780",
"assets/assets/images/home_fill.png": "c227c479ca778352029bf6c94b2bffa7",
"assets/assets/images/UBS%2520outlined.png": "d20075cb2b67273be8fda8bc8a17b3be",
"assets/assets/images/Nas.png": "c28522248d08da3cae741f9d7f8456a3",
"assets/assets/images/49.png": "1e1d7412af59f4080f6ef97f9ee94047",
"assets/assets/images/Information.png": "b39e911cdcfaf6732bc8e22e460f9559",
"assets/assets/images/Privacy.png": "599edc245228cc44cedb042ae211e56f",
"assets/assets/images/Genesis12.png": "1aa27f6651bc5ba04dc7eca86ce6f2d2",
"assets/assets/images/S_P.png": "d323561c1b8ef709c115c0d731c49199",
"assets/assets/images/citi%2520bank.png": "8ec2f17e5501e34edd4f01ac316d4773",
"assets/assets/images/Twitter%2520Outline.png": "cc4ef8913eb1e8c5807b713ae6cef4fb",
"assets/assets/images/Stories%25202.png": "fa3b7a711c2ad44f0b37aaea608850a9",
"assets/assets/images/WellsFargo%2520outlined%2520-%2520png.png": "942298da5c72463f15d1e33de47ad423",
"assets/assets/images/gold_dark.png": "2cae01d909bef92da2a7d53aae34d231",
"assets/assets/images/Finance.png": "8ae7e9b10c2498d2702098d1d4efc35d",
"assets/assets/images/Recieve.png": "4aa7b637fa3ef6a6ae2809a97006fba4",
"assets/assets/images/nft_dark.png": "09c765c9cff48010bb1bedd42c9133e1",
"assets/assets/images/Mastercard%2520Outlined.png": "650f9096b0a33e7bf00a0a4abf3aa895",
"assets/assets/images/Person_fill.png": "446495308c687ac04eee139a272e5ee3",
"assets/assets/images/Barclays.png": "bb4a62d256447257913b63690356ee13",
"assets/assets/images/mail.png": "ede1cee0b2ce7d15d9c28a2982da53b0",
"assets/assets/images/finger%2520print.png": "54dc45fb8bfbdb0b8d49fc555d37a0ad",
"assets/assets/images/Genesis_full.png": "b9898c2abb9506357ca73a4c14e873ac",
"assets/assets/images/amazon.png": "07d0cf7d4b703b457a247b80ccdbab7b",
"assets/assets/images/News.png": "6be3b26663c5cdda3e8e619c65a36be5",
"assets/assets/images/Master%2520card.png": "5b582ebc234ea990eccd2c182b3f7c6b",
"assets/assets/images/Manuelaveux.png": "bdeff29c5af7c195334d3b40597242b1",
"assets/assets/images/Facebook%2520Outline.png": "138b8fc428a8483da8e8155ae30f095d",
"assets/assets/images/Ethereum%2520blue.png": "d49ca785a1df7d9393436b5c3bf06c14",
"assets/assets/images/password%2520update.png": "e90ea261dcb40fccff3b6077759ff16d",
"assets/assets/images/Floating%2520action.png": "a3f6ff924d8e63697566587937432e97",
"assets/assets/images/gift.png": "7916e5b1fa4b53fea7a3d24e48f54108",
"assets/assets/images/Card%25202.png": "fa2b940163237649c6746dcfed83cece",
"assets/assets/images/up-arrow.png": "8814242834904ab14d23b70ae9d41f40",
"assets/assets/images/Spotify.png": "de4fa5ea571cae463fdfc9549782a4a8",
"assets/assets/images/heart.png": "fb8cdf25242c75f967b0a529c4c3b0c0",
"assets/assets/images/Apple_1.png": "fe86ede6919c93e8d7b26826f1fba2ed",
"assets/assets/images/crypto_dark.png": "10ae67bda551bb62d49b9b91b9547ab1",
"assets/assets/images/Filter.png": "17800a95f7377f30a2163b3a35c4a5a9",
"assets/assets/images/Telegram.png": "30c325d72b457d955b128ab9e9aca432",
"assets/assets/images/chart-line.png": "ad69b0fdf31deddd0444fc975858000d",
"assets/assets/images/dollar_Icon.png": "e75a69d50be28c2ab969f09c105e4523",
"assets/assets/images/heart%2520outlined.png": "5d4c5e3f31ca633961084d87d3aae5e0",
"assets/assets/images/mt4.webp": "112862800b239f09ecaa97edaeaf4ee2",
"assets/assets/images/Facebook.png": "84867ab6f92fbc385c224720cf04d981",
"assets/assets/images/Stories.png": "df7d28cbcaaadd9f7851f11e93ac06b5",
"assets/assets/images/HealthCare.png": "c5a389882f22ad7b2303cdce356e3c87",
"assets/assets/images/Piggy%2520bank.png": "60986e4c84897f3d2a74c79aafa67e8a",
"assets/assets/images/Gift_1.png": "9b36f5d99549a4ca202b8830c50174ab",
"assets/assets/images/Filter_.png": "ca915d213d6924ca4ebfd1456dc8e32d",
"assets/assets/images/Liquid_rumi.png": "b919a1213d7ccca414ee6d42755c58f6",
"assets/assets/images/receipt.png": "b01beb8105b0e054031747b93256f8a0",
"assets/assets/images/ticket-discount.png": "4ebfbfbe795b0c29de1e95e66c577c19",
"assets/assets/images/verify%2520success.png": "f698be732f082c21d3037d06a562ae84",
"assets/assets/images/Visionxxx.png": "636cc08dd96ccfabd0cf2d68fbf9d54e",
"assets/assets/images/verify.png": "68cdf538cda069f8382686c366f294bf",
"assets/assets/images/Nemus%25201.png": "9f7c755ff9d21d8ef5f3941d36004921",
"assets/assets/images/download.png": "848c767d76eca4ff5b4a7c31191c7de3",
"assets/assets/images/Background%2520(1).png": "0e3364d6768c5d5c38d1ee3043260d54",
"assets/assets/images/cardano.png": "78aa0480cbb03e45e498fbb4abbac6ee",
"assets/assets/images/light%2520dark%2520mode.png": "b30c905a4f6d7ce54d46dfc514fc3fd9",
"assets/assets/images/Chart.png": "687cb00cab460d2dfb66e310530732c5",
"assets/assets/images/Instagram.png": "d6764baad7588e42eba74c4c34937211",
"assets/assets/images/indonesia.png": "c50fefc172029e321f39612fc834caf7",
"assets/assets/images/card.png": "9da6624f504aaced80bae36b0eac4ba1",
"assets/assets/images/gold_uk.png": "01b8b6ecf979ad02d348b6c9704c515f",
"assets/assets/images/Send.png": "37ebaf2eea5221f69bc8f42eaca2451f",
"assets/assets/images/Business.png": "d9eb13b5d1d65ac41c6f29e807f8e898",
"assets/assets/images/verification.png": "95972cd70c40ad566ad057eac3e5666b",
"assets/assets/images/coin%2520white.png": "8c3140559289bf2741ca0f87353eb932",
"assets/assets/images/Market.png": "a6890f35f5ad13f2482358c54083029f",
"assets/assets/images/Materials.png": "bbaf583dae7f2e7ee75dffca29e3c340",
"assets/assets/images/Crypto.png": "ae2c6e37056e4d8215947fb6ea1b6c2a",
"assets/assets/images/gold_canada.png": "808a12db426bd1666ba30bd8048d9d6f",
"assets/assets/images/Krishna1.png": "b907dc756c5ac066437b40a2dd900187",
"assets/assets/images/Translate.png": "7030fa6479a149cd22257fd475770eed",
"assets/assets/images/NFTs.png": "b5795c0ab4d6c5da2bbab1701b3de0e8",
"assets/assets/images/Chase%2520outlined.png": "da3ccef7a6db20bcb2dc45925bea219e",
"assets/assets/images/chase.png": "91d6ce3faf1c97d30cd6ddfca3695eac",
"assets/assets/images/stocks_dark.png": "db1ddb5505b99ef768c71a12e7bd5037",
"assets/assets/images/united-kingdom.png": "aac0dfefc080856931658ea9c760534e",
"assets/assets/images/Visa%2520Outlined.png": "ccaf056eb29aa6899515c74c428a2c28",
"assets/assets/images/digital_document.png": "879d33a9ce691c2e75b87db6481d78b8",
"assets/assets/images/Person.png": "93fe2aca5a005b355843b6614782dc3e",
"assets/assets/images/Bank%2520America%2520icon.png": "34f92be946bbcde14eea835313a70b16",
"assets/assets/images/arrows-sort.png": "5a41d04489f9d33dd6380f2a9be59c72",
"assets/assets/images/calendar.png": "2293845624b9d9a94d502fabb6503f6d",
"assets/assets/images/Identycard_.png": "ea65f8761c167ff52c0d37cf4f17366d",
"assets/assets/images/Pinned.png": "d177d36ef52de8758a90ce65c07cbf5f",
"assets/assets/images/Mic.png": "fd6d50eb220dae746e08db9be1d7f751",
"assets/assets/images/Portfolio_fill.png": "dc5c8530feb5b200ce4089525b69a3ee",
"assets/assets/images/Visa.png": "95076513b8196d18ada2f15f68e72702",
"assets/assets/images/france.png": "5b7c5a257ef653a486376ade57f04d10",
"assets/assets/images/Women.png": "e5b42afec3e95aaa2e205d2d2c9edf15",
"assets/assets/images/coin.png": "09cd6ce5767f61cb995c6506cfeb4bfe",
"assets/assets/images/Get1.png": "ec03912ce3f917f98dc829085935f247",
"assets/assets/images/Gold.png": "bd540180c90d4853c12d81ed4e5bbf00",
"assets/assets/images/logout.png": "25bfc38292756a72f9f1c76fc3e753a2",
"assets/assets/images/Barclays%2520outlined.png": "34365888b9b1996a805a070dc6538686",
"assets/assets/images/arrow-narrow-left%2520(1).png": "ffc025273cf2c08c5a9d376fe660e866",
"assets/assets/images/Ethereum%2520(ETH).png": "ea7df21cd3efbdef55c9e7c568317abe",
"assets/assets/images/Instagram%2520Outline.png": "cc846efad574231f24d5fd0f1321f8de",
"assets/assets/images/bell-plus.png": "a5e2e568e96b4df16154aba5fe012e1a",
"assets/assets/images/Terms&condition.png": "b271135a82910316253abbaeef9e5653",
"assets/assets/images/Technology.png": "6c4d53a90969e53159b80b5d6a1e5854",
"assets/assets/images/cloud-connection.png": "7af9c91cab1c9aa3bea7d91e9c71ee40",
"assets/assets/images/Stocks.png": "4605ff194c7a3133d0414032ce383986",
"assets/assets/images/Whatsapp%2520outlined.png": "c64bf0997dcb539e47bea9125d11096a",
"assets/assets/images/edit.png": "586728b96da27e1dd39826eab5b66e88",
"assets/assets/images/chart-bar.png": "ab1ffee20a41e3b6dd144c8342b1d054",
"assets/assets/images/uruguay.png": "70f14bcd294db78cb119d57cfe8a8424",
"assets/assets/images/identycard.png": "e5c8ea596d5f7dbf1337f0570dc83f71",
"assets/assets/images/Spacy1.png": "bc0da30fcea850f1c01ee56122024b58",
"assets/assets/images/Crowwn.png": "a121b54dd6c77c8ea8af4c11630632b2",
"assets/assets/images/amd.png": "fad00bc757f122fb2ccd02a6d444f7b6",
"assets/FontManifest.json": "cb3b087ffae000bec855c35d16363314",
"assets/AssetManifest.bin.json": "6f1ed3a8a376649fb7a62867fe57d2e9",
"assets/AssetManifest.bin": "3ee134e18e549140741a5c095f4d6882",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/all%2520fonts/Manrope-Regular.ttf": "f8105661cf5923464f0db8290746d2f9",
"assets/all%2520fonts/Manrope-Medium.ttf": "aa9897f9fa37c84d7b9d3d05a8a6bc07",
"assets/all%2520fonts/Manrope-Light.ttf": "9e353f65739cc41a37bed272850cf92e",
"assets/all%2520fonts/Manrope-Bold.ttf": "69258532ce99ef9abf8220e0276fff04",
"assets/all%2520fonts/Manrope-SemiBold.ttf": "4410f0d144bea752f9bfb5f33909e0c5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "94c735ed7c921bc7f22cb0b05c6aa142",
"assets/packages/iconly/fonts/IconlyLight.ttf": "baf08d3e753c86f1bdacb3535d66e2aa",
"assets/packages/iconly/fonts/IconlyBroken.ttf": "ae60c99d5cf25644beb25a87577bf6ca",
"assets/packages/iconly/fonts/IconlyBold.ttf": "6c73fc0a864250644f562a679591e0a4",
"main.dart.mjs": "161a134c0fcbc680b662cbd40d694b61",
"flutter_bootstrap.js": "3fd820f8cdeddb0cbb55918953c8055c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "b97387d1857f2759585d19364c691689",
"/": "b97387d1857f2759585d19364c691689"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
