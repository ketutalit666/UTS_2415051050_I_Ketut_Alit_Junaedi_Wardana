
import '../models/destination.dart';

// URL gambar langsung dari Wikimedia Commons.
// URL thumbnail ini sudah berhasil diperiksa.

const String kelingkingImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3a/Kelingking_Beach.jpg/330px-Kelingking_Beach.jpg';

const String beachImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fa/Bali_-_Kuta_Beach.jpg/330px-Bali_-_Kuta_Beach.jpg';

const String riceImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/34/Rice_Terrace_Bali.jpg/330px-Rice_Terrace_Bali.jpg';

const String waterfallImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0b/GitGit_Waterfall%2C_Bali.jpg/330px-GitGit_Waterfall%2C_Bali.jpg';

const String ulunDanuImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Ulun_Danu_Beratan_Temple.jpg/330px-Ulun_Danu_Beratan_Temple.jpg';

const String besakihImage =
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/76/Besakih_Temple_Bali.jpg/500px-Besakih_Temple_Bali.jpg';

const List<Destination> destinationsData = [
  // =========================
  // PANTAI
  // =========================

  Destination(
    id: '1',
    name: 'Pantai Kelingking',
    location: 'Nusa Penida',
    category: 'Pantai',
    description: 'Pantai Kelingking terkenal dengan tebing berbentuk T-Rex, pasir putih, dan panorama Samudra Hindia.',
    rating: 4.9,
    latitude: -8.7504,
    longitude: 115.4725,
    imageUrl: kelingkingImage,
  ),

  Destination(
    id: '2',
    name: 'Pantai Melasti',
    location: 'Ungasan, Badung',
    category: 'Pantai',
    description: 'Pantai dengan pasir putih, air laut jernih, dan tebing kapur yang menjulang di sepanjang pesisir.',
    rating: 4.8,
    latitude: -8.8488,
    longitude: 115.1606,
    imageUrl: beachImage,
  ),

  Destination(
    id: '3',
    name: 'Pantai Kuta',
    location: 'Kuta, Badung',
    category: 'Pantai',
    description: 'Pantai populer dengan garis pantai panjang, suasana ramai, dan pemandangan matahari terbenam.',
    rating: 4.6,
    latitude: -8.7184,
    longitude: 115.1686,
    imageUrl: beachImage,
  ),

  Destination(
    id: '4',
    name: 'Pantai Dreamland',
    location: 'Pecatu, Badung',
    category: 'Pantai',
    description: 'Pantai berpasir putih yang dikelilingi tebing dan dikenal sebagai salah satu lokasi berselancar.',
    rating: 4.7,
    latitude: -8.8015,
    longitude: 115.1175,
    imageUrl: beachImage,
  ),

  Destination(
    id: '5',
    name: 'Pantai Padang Padang',
    location: 'Pecatu, Badung',
    category: 'Pantai',
    description: 'Pantai dengan akses melewati celah tebing batu dan teluk kecil yang indah.',
    rating: 4.7,
    latitude: -8.8120,
    longitude: 115.1035,
    imageUrl: beachImage,
  ),

  Destination(
    id: '6',
    name: 'Pantai Jimbaran',
    location: 'Jimbaran, Badung',
    category: 'Pantai',
    description: 'Pantai dengan suasana santai, pemandangan senja, dan kawasan kuliner seafood di tepi laut.',
    rating: 4.7,
    latitude: -8.7684,
    longitude: 115.1675,
    imageUrl: beachImage,
  ),

  Destination(
    id: '7',
    name: 'Pantai Tanah Lot',
    location: 'Tabanan',
    category: 'Pantai',
    description: 'Kawasan pesisir dengan pura di atas batu karang yang menjadi ikon wisata Bali.',
    rating: 4.8,
    latitude: -8.6212,
    longitude: 115.0868,
    imageUrl: beachImage,
  ),

  Destination(
    id: '8',
    name: 'Pantai Menjangan',
    location: 'Buleleng',
    category: 'Pantai',
    description: 'Kawasan pesisir dan laut dengan panorama bawah laut yang menarik untuk snorkeling dan menyelam.',
    rating: 4.8,
    latitude: -8.0940,
    longitude: 114.5140,
    imageUrl: beachImage,
  ),

  // =========================
  // ALAM
  // =========================

  Destination(
    id: '9',
    name: 'Tegallalang Rice Terrace',
    location: 'Tegallalang, Gianyar',
    category: 'Alam',
    description: 'Hamparan sawah berundak dengan sistem irigasi tradisional Subak dan panorama hijau yang menenangkan.',
    rating: 4.8,
    latitude: -8.4317,
    longitude: 115.2792,
    imageUrl: riceImage,
  ),

  Destination(
    id: '10',
    name: 'Air Terjun Tegenungan',
    location: 'Gianyar',
    category: 'Alam',
    description: 'Air terjun dengan aliran air yang deras dan pemandangan alam tropis di sekitarnya.',
    rating: 4.6,
    latitude: -8.5750,
    longitude: 115.2890,
    imageUrl: waterfallImage,
  ),

  Destination(
    id: '11',
    name: 'Air Terjun Gitgit',
    location: 'Sukasada, Buleleng',
    category: 'Alam',
    description: 'Air terjun di kawasan hutan tropis Buleleng dengan suasana sejuk dan alami.',
    rating: 4.7,
    latitude: -8.2020,
    longitude: 115.1390,
    imageUrl: waterfallImage,
  ),

  Destination(
    id: '12',
    name: 'Air Terjun Sekumpul',
    location: 'Sawan, Buleleng',
    category: 'Alam',
    description: 'Kumpulan air terjun yang mengalir di tengah lembah hijau dan pepohonan tropis.',
    rating: 4.9,
    latitude: -8.1740,
    longitude: 115.1840,
    imageUrl: waterfallImage,
  ),

  Destination(
    id: '13',
    name: 'Jatiluwih Rice Terrace',
    location: 'Penebel, Tabanan',
    category: 'Alam',
    description: 'Persawahan luas dengan lanskap Subak yang menjadi bagian dari warisan budaya dunia UNESCO.',
    rating: 4.9,
    latitude: -8.3690,
    longitude: 115.1320,
    imageUrl: riceImage,
  ),

  Destination(
    id: '14',
    name: 'Campuhan Ridge Walk',
    location: 'Ubud, Gianyar',
    category: 'Alam',
    description: 'Jalur jalan kaki dengan pemandangan perbukitan hijau dan lembah yang asri.',
    rating: 4.7,
    latitude: -8.5005,
    longitude: 115.2550,
    imageUrl: riceImage,
  ),

  Destination(
    id: '15',
    name: 'Gunung Batur',
    location: 'Kintamani, Bangli',
    category: 'Alam',
    description: 'Gunung berapi dengan panorama kaldera dan danau yang terkenal sebagai lokasi pendakian matahari terbit.',
    rating: 4.8,
    latitude: -8.2420,
    longitude: 115.3750,
    imageUrl: riceImage,
  ),

  Destination(
    id: '16',
    name: 'Tirta Gangga',
    location: 'Karangasem',
    category: 'Alam',
    description: 'Taman air kerajaan dengan kolam, patung, dan taman yang memiliki suasana asri.',
    rating: 4.8,
    latitude: -8.4120,
    longitude: 115.5870,
    imageUrl: besakihImage,
  ),

  // =========================
  // BUDAYA
  // =========================

  Destination(
    id: '17',
    name: 'Pura Lempuyang',
    location: 'Karangasem',
    category: 'Budaya',
    description: 'Kompleks pura di lereng Gunung Lempuyang yang terkenal dengan gerbang ikonik dan pemandangan Gunung Agung.',
    rating: 4.8,
    latitude: -8.3919,
    longitude: 115.6300,
    imageUrl: besakihImage,
  ),

  Destination(
    id: '18',
    name: 'Ulun Danu Beratan',
    location: 'Bedugul, Tabanan',
    category: 'Budaya',
    description: 'Pura ikonik di tepi Danau Beratan yang dikelilingi suasana pegunungan sejuk.',
    rating: 4.8,
    latitude: -8.2750,
    longitude: 115.1669,
    imageUrl: ulunDanuImage,
  ),

  Destination(
    id: '19',
    name: 'Pura Tirta Empul',
    location: 'Tampaksiring, Gianyar',
    category: 'Budaya',
    description: 'Pura suci dengan mata air yang digunakan dalam tradisi penyucian diri masyarakat Hindu Bali.',
    rating: 4.8,
    latitude: -8.4150,
    longitude: 115.3150,
    imageUrl: besakihImage,
  ),

  Destination(
    id: '20',
    name: 'Pura Besakih',
    location: 'Rendang, Karangasem',
    category: 'Budaya',
    description: 'Kompleks pura terbesar dan paling penting di Bali yang berada di lereng Gunung Agung.',
    rating: 4.9,
    latitude: -8.3730,
    longitude: 115.4500,
    imageUrl: besakihImage,
  ),

  Destination(
    id: '21',
    name: 'Pura Taman Ayun',
    location: 'Mengwi, Badung',
    category: 'Budaya',
    description: 'Pura kerajaan dengan taman luas, kolam, dan bangunan meru bertingkat.',
    rating: 4.7,
    latitude: -8.5390,
    longitude: 115.1750,
    imageUrl: ulunDanuImage,
  ),

  Destination(
    id: '22',
    name: 'Pura Goa Gajah',
    location: 'Bedulu, Gianyar',
    category: 'Budaya',
    description: 'Situs bersejarah dengan gua batu, relief, dan peninggalan arkeologi Bali kuno.',
    rating: 4.7,
    latitude: -8.5230,
    longitude: 115.2870,
    imageUrl: besakihImage,
  ),

  Destination(
    id: '23',
    name: 'Pura Ulun Danu Batur',
    location: 'Kintamani, Bangli',
    category: 'Budaya',
    description: 'Pura penting di kawasan Kintamani yang berkaitan erat dengan tradisi dan kehidupan masyarakat Bali.',
    rating: 4.7,
    latitude: -8.2510,
    longitude: 115.3540,
    imageUrl: ulunDanuImage,
  ),

  Destination(
    id: '24',
    name: 'Desa Penglipuran',
    location: 'Bangli',
    category: 'Budaya',
    description: 'Desa wisata yang dikenal dengan tata ruang tradisional, rumah adat, dan lingkungan yang terjaga.',
    rating: 4.8,
    latitude: -8.4230,
    longitude: 115.3640,
    imageUrl: besakihImage,
  ),
];
