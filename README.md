# Nama  : Lukman Eka Septiawan
# Kelas : TI-3C

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Langkah 1: Buat Project Baru
    Buatlah sebuah project flutter baru dengan nama books di folder src week-12 repository GitHub Anda.

    Kemudian Tambahkan dependensi http dengan mengetik perintah berikut di terminal.

```dart
flutter pub add http
```

### Langkah 2: Cek file pubspec.yaml
    Jika berhasil install plugin, pastikan plugin http telah ada di file pubspec ini seperti berikut.

```dart
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

### Langkah 3: Buka file main.dart
> 1. Task
> - Tambahkan nama panggilan Anda pada **title** app sebagai identitas hasil pekerjaan Anda.

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/OmLeEAAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future (Lukman)'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                setState(() {});
                getData().then((value) {
                  result = value.body.toString().substring(0, 450);
                  setState(() {});
                }).catchError((_) {
                  result = 'An error occurred';
                  setState(() {});
                });
              },
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
```
    Catatan: 
    Tidak ada yang spesial dengan kode di main.dart tersebut. Perlu diperhatikan di kode tersebut terdapat widget CircularProgressIndicator yang akan menampilkan animasi berputar secara terus-menerus, itu pertanda bagus bahwa aplikasi Anda responsif (tidak freeze/lag). Ketika animasi terlihat berhenti, itu berarti UI menunggu proses lain sampai selesai.

### Langkah 4: Tambah method getData()
    Tambahkan method ini ke dalam class _FuturePageState yang berguna untuk mengambil data dari API Google Books.

```dart

```

> 2. Task
> - Carilah judul buku favorit Anda di Google Books, lalu ganti ID buku pada variabel path di kode tersebut. Caranya ambil di URL browser Anda seperti gambar berikut ini.
![example url](lib/assets/images/report/report_p1-3.1.png)
> - Kemudian cobalah akses di browser URI tersebut dengan lengkap seperti ini. Jika menampilkan data JSON, maka Anda telah berhasil. Lakukan capture milik Anda dan tulis di README pada laporan praktikum. Lalu lakukan commit dengan pesan "W12: Soal 2".
![example url](lib/assets/images/report/report_p1-3.2.png)
![example url](lib/assets/images/tasks/task2.png)

### Langkah 5: Tambah kode di ElevatedButton
    Tambahkan kode pada onPressed di ElevatedButton seperti berikut.

```dart
ElevatedButton(
    child: const Text('GO!'),
    onPressed: () {
    setState(() {});
    getData().then((value) {
        result = value.body.toString().substring(0, 450);
        setState(() {});
    }).catchError((_) {
        result = 'An error occurred';
        setState(() {});
    });
    },
),
```

> 3. Task
> - Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!
>
>   substring digunakan untuk menampilkan karakter sesuai dengan parameter yang dikirimkan. pada contoh di atas menggunakan substring(0, 450) dimana nilai string akan ditampilkan mulai dari karakter pertama (0) hingga karakter terakhir (450). Sedangkan untuk catchError digunakan untuk menangani kesalahan yang mungkin terjadi saat program sedang berjalan.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 3".
![Image task 3](lib/assets/images/tasks/task3.jpg)

## Praktikum 2: Menggunakan await/async untuk menghindari callbacks
Ada alternatif penggunaan Future yang lebih clean, mudah dibaca dan dirawat, yaitu pola async/await. Intinya pada dua kata kunci ini:

-  async digunakan untuk menandai suatu method sebagai asynchronous dan itu harus ditambahkan di depan kode function.

-  await digunakan untuk memerintahkan menunggu sampai eksekusi suatu function itu selesai dan mengembalikan sebuah value. Untuk then bisa digunakan pada jenis method apapun, sedangkan await hanya bekerja di dalam method async.
 
### Langkah 1: Buka file main.dart
    Tambahkan tiga method berisi kode seperti berikut di dalam class _FuturePageState.

```dart
class _FuturePageState extends State<FuturePage> {
  String result = '';

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/OmLeEAAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }
  
  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }
  
  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }
```

### Langkah 2: Tambah method count()
    Lalu tambahkan lagi method ini di bawah ketiga method sebelumnya.

```dart
Future count() async {
  int total = 0;
  total = await returnOneAsync();
  total += await returnTwoAsync();
  total += await returnThreeAsync();
  setState(() {
    result = total.toString();
  });
}
```

### Langkah 3: 
    Lakukan comment kode sebelumnya, ubah isi kode onPressed() menjadi seperti berikut.

```dart
ElevatedButton(
    child: const Text('GO!'),
    onPressed: () {
    // setState(() {});
    // getData().then((value) {
    //   result = value.body.toString().substring(0, 450);
    //   setState(() {});
    // }).catchError((_) {
    //   result = 'An error occurred';
    //   setState(() {});
    // });

    count();
    },
),
```

### Langkah 4: 
    Akhirnya, run atau tekan F5 jika aplikasi belum running. Maka Anda akan melihat seperti gambar berikut, hasil angka 6 akan tampil setelah delay 9 detik.

![image/Gif result practicum 2](lib/assets/images/tasks/task4.gif)

> 4. Task
> - Jelaskan maksud kode langkah 1 dan 2 tersebut!
>
>   Pada langkah 1 kita menambahkan 3 method yang digunakan untuk menambahkan waktu tunggu selama 3 detik per method (total 9 detik) dan ketiga method tersebut mengembalikan nilai mereka masing-masing. Pada langkah 2 kita menambahkan metod count() untuk menjumlahkan nilai yang dikirimkan oleh 3 method sebelumnya.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 4".
![image/Gif result practicum 2](lib/assets/images/tasks/task4.gif)

## Praktikum 3: Menggunakan Completer di Future
Menggunakan Future dengan then, catchError, async, dan await mungkin sudah cukup untuk banyak kasus, tetapi ada alternatif melakukan operasi async di Dart dan Flutter yaitu dengan class Completer.

Completer membuat object Future yang mana Anda dapat menyelesaikannya nanti (late) dengan return sebuah value atau error.

### Langkah 1: Buka main.dart
    Pastikan telah impor package async berikut.

```dart
import 'package:async/async.dart';
```

### Langkah 2: Tambahkan variabel dan method
    Tambahkan variabel late dan method di class _FuturePageState seperti ini.

```dart
class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }
```

### Langkah 3: Ganti isi kode onPressed()
    Tambahkan kode berikut pada fungsi onPressed(). Kode sebelumnya bisa Anda comment.

```dart
ElevatedButton(
    child: const Text('GO!'),
    onPressed: () {
    // setState(() {});
    // getData().then((value) {
    //   result = value.body.toString().substring(0, 450);
    //   setState(() {});
    // }).catchError((_) {
    //   result = 'An error occurred';
    //   setState(() {});
    // });

    // count();

    getNumber().then((value) {
        setState(() {
        result = value.toString();
        });
    });
    },
),
```

### Langkah 4: Run Project
    Terakhir, run atau tekan F5 untuk melihat hasilnya jika memang belum running. Bisa juga lakukan hot restart jika aplikasi sudah running. Maka hasilnya akan seperti gambar berikut ini. Setelah 5 detik, maka angka 42 akan tampil.

![Image Result Practicum 3](lib/assets/images/tasks/task5.gif)

> 5. Task
> - Jelaskan maksud kode langkah 2 tersebut!
>
>   Pada langkah 2 kita menambahkan 2 method baru pada main.dart. method pertama digunakan untuk mendapatkan angka, sedangkan completer digunakan untuk menyelesaikan method dengan waktu yang sudah ditentukan. Sedangkan method kedua digunakan untuk memberikan/mengirimkan angka saat method ini dipanggul/digunakan.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 5".

![Image Result Practicum 3](lib/assets/images/tasks/task5.gif)

### Langkah 5: Ganti method calculate()
    Gantilah isi code method calculate() seperti kode berikut, atau Anda dapat membuat calculate2()

```dart
Future calculate() async {
  try {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  } catch (_) {
    completer.completeError({}); 
  }
}
```

### Langkah 6: Pindah ke onPressed()
    Ganti menjadi kode seperti berikut.

```dart
ElevatedButton(
    child: const Text('GO!'),
    onPressed: () {
    // setState(() {});
    // getData().then((value) {
    //   result = value.body.toString().substring(0, 450);
    //   setState(() {});
    // }).catchError((_) {
    //   result = 'An error occurred';
    //   setState(() {});
    // });

    // count();

    getNumber().then((value) {
        setState(() {
        result = value.toString();
        });
    }).catchError((e) {
        result = 'An error occurred';
    });
    },
),
```

> 6. Task
> - Jelaskan maksud perbedaan kode langkah 2 dengan langkah 5-6 tersebut!
>
>   Pada langkah 5 kita membungkus kode yang sudah kita buat sebelumnya pada langkah 2 menggunakan try-catch. Penggunaan try-catch ini berfungsi untuk menghandle error yang muncul saat program sedang berjalan. Sedangkan langkah 6 memiliki fungsi yang hampir sama dengan langkah 5, tetapi pada langkah ini berguna untuk menghandle error saat button ditekan.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 6"
<!-- task 5 and 6 have the same view -->
![Image Result Practicum 3](lib/assets/images/tasks/task5.gif)


## Praktikum 4: Memanggil Future secara paralel
Ketika Anda membutuhkan untuk menjalankan banyak Future secara bersamaan, ada sebuah class yang dapat Anda gunakan yaitu: FutureGroup.

FutureGroup tersedia di package async, yang mana itu harus diimpor ke file dart Anda, seperti berikut.

```dart
import 'package:async/async.dart';
```

> **Catatan**:  Package dart:async dan async/async.dart merupakan library yang berbeda. Pada beberapa kasus, Anda membutuhkan kedua lib tersebut untuk me-run code async.

FutureGroup adalah sekumpulan dari Future yang dapat run secara paralel. Ketika run secara paralel, maka konsumsi waktu menjadi lebih hemat (cepat) dibanding run method async secara single setelah itu method async lainnya.

Ketika semua code async paralel selesai dieksekusi, maka FutureGroup akan return value sebagai sebuah List, sama juga ketika ingin menambahkan operasi paralel dalam bentuk List.

### Langkah 1: Buka file main.dart
    Tambahkan method ini ke dalam class _FuturePageState

```dart
class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  void returnFG() {
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    futureGroup.future.then((List <int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = value.toString();
      });
    });
  }
```

### Langkah 2: Edit onPressed()
    Anda bisa hapus atau comment kode sebelumnya, kemudian panggil method dari langkah 1 tersebut.

```dart
ElevatedButton(
    child: const Text('GO!'),
    onPressed: () {
    // setState(() {});
    // getData().then((value) {
    //   result = value.body.toString().substring(0, 450);
    //   setState(() {});
    // }).catchError((_) {
    //   result = 'An error occurred';
    //   setState(() {});
    // });

    // count();

    // getNumber().then((value) {
    //   setState(() {
    //     result = value.toString();
    //   });
    // }).catchError((e) {
    //   result = 'An error occurred';
    // });

    returnFG();
    },
),
```

### Langkah 3: Run Project
    Anda akan melihat hasilnya dalam 3 detik berupa angka 6 lebih cepat dibandingkan praktikum sebelumnya menunggu sampai 9 detik.
![Image/gif Result Practicum 4](lib/assets/images/tasks/task7.gif)

> 7. Task
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 7".

![Image/gif Result Practicum 4](lib/assets/images/tasks/task7.gif)

### Langkah 4: Ganti variabel futureGroup
    Anda dapat menggunakan FutureGroup dengan Future.wait seperti kode berikut.

```dart
void returnFG() {
    // FutureGroup<int> futureGroup = FutureGroup<int>();
    // futureGroup.add(returnOneAsync());
    // futureGroup.add(returnTwoAsync());
    // futureGroup.add(returnThreeAsync());
    // futureGroup.close();
    // futureGroup.future.then((List<int> value) {
    //   int total = 0;
    //   for (var element in value) {
    //     total += element;
    //   }
    //   setState(() {
    //     result = total.toString();
    //   });
    // });
    
    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);
    futures.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
}
```

> 8. Task
> - Jelaskan maksud perbedaan kode langkah 1 dan 4!
>
>   Perbedaan dalam penggunaan FutureGroup dan Future.wait terletak pada tingkat fleksibilitas kedua metode tersebut. Pada FutureGroup kita dapat menambahkan Future/method secara dinamis, berbeda dengan Future.wait, kita tidak dapat melakukan hal yang sama seperti pada FutureGroup karena metode ini akan menambahkan Future/method saat Future.wait dijalankan. Oleh karena itu, FutureGroup dinilai lebih fleksibel dalam penambahan Future/method baru

## Praktikum 5: Menangani Respon Error pada Async Code
Ada beberapa teknik untuk melakukan handle error pada code async. Pada praktikum ini Anda akan menggunakan 2 cara, yaitu then() callback dan pola async/await.

### Langkah 1: Buka file main.dart
    Tambahkan method ini ke dalam class _FuturePageState

```dart
class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }
```

### Langkah 2: ElevatedButton
    Ganti dengan kode berikut

```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    returnError().then((value) {
      setState(() {
        result = "Success";
      });
    }).catchError((onError) {
      setState(() {
        result = onError.toString();
      });
    }).whenComplete(() => print('Complete'));
  },
),
```

### Langkah 3: Run Project
    Lakukan run dan klik tombol GO! maka akan menghasilkan seperti gambar berikut.

![Image Result Practicum 5](lib/assets/images/tasks/task9.gif)

    Pada bagian debug console akan melihat teks Complete seperti berikut.

![Image Debug Console](lib/assets/images/tasks/task9-2.png)

> 9. Task
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 9".

![Image Result Practicum 5](lib/assets/images/tasks/task9.gif)

### Langkah 4: Tambah method handleError()
    Tambahkan kode ini di dalam class _FutureStatePage

```dart
class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }
```

> 10. Task
> - Panggil method handleError() tersebut di ElevatedButton, lalu run. Apa hasilnya? Jelaskan perbedaan kode langkah 1 dan 4!
>
>   Pada langkah 1 kode tersebut hanya menampilkan pesan error ketika fungsi tersebut dipanggil, sedangkan pada langkah 4 memanfaatkan try-catch untuk memastikan proses pemanggiran fungsi returnError() berjalan dengan benar dan jika terdapat error, kode pada bagian catch akan dijalankan untuk menampilkan pesan error,

```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    handleError();
  },
),
```

## Praktikum 6: Menggunakan Future dengan StatefulWidget
Seperti yang Anda telah pelajari, Stateless widget tidak dapat menyimpan informasi (state), StatefulWidget dapat mengelola variabel dan properti dengan method setState(), yang kemudian dapat ditampilkan pada UI. State adalah informasi yang dapat berubah selama life cycle widget itu berlangsung.

Ada **4 method utama** dalam life cycle StatefullWidget:

- initState(): dipanggil sekali ketika state dibangun. Bisa dikatakan ini juga sebagai konstruktor class.
- build(): dipanggil setiap kali ada perubahan state atau UI. Method ini melakukan destroy UI dan membangun ulang dari nol.
- deactive() dan dispose(): digunakan untuk menghapus widget dari tree, pada beberapa kasus dimanfaatkan untuk menutup koneksi ke database atau menyimpan data sebelum berpindah screen.

### Langkah 1: Install plugin geolocator
    Tambahkan plugin geolocator dengan mengetik perintah berikut di terminal.

```dart
flutter pub add geolocator
```

### Langkah 2: Tambah permission GPS
    Jika Anda menargetkan untuk platform Android, maka tambahkan baris kode berikut di file android/app/src/main/androidmanifest.xml

```dart
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

    Jika Anda menargetkan untuk platform iOS, maka tambahkan kode ini ke file Info.plist

```dart
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs to access your location</string>
```

### Langkah 3: Buat file geolocation.dart
    Tambahkan file baru ini di folder lib project Anda.

![Screenshot file](lib/assets/images/report/report_p6-3.png)

### Langkah 4: Buat StatefulWidget
    Buat class LocationScreen di dalam file geolocation.dart

```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  
}
```

### Langkah 5: Isi kode geolocation.dart
```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  @override
  void initState() {
    super.initState();
    getPosition().then((Position myPos) {
      myPosition =
          'Latitude: ${myPos.latitude.toString()} - Longitude: ${myPos.longitude.toString()}';
      setState(() {
        myPosition = myPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location Lukman'),
      ),
      body: Center(
        child: Center(child: Text(myPosition)),
      ),
    );
  }

  Future<Position> getPosition() async {
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }
}

```

> 11. Task
> - Tambahkan nama panggilan Anda pada tiap properti title sebagai identitas pekerjaan Anda.

```dart
appBar: AppBar(
  title: const Text('Current Location Lukman'),
),
```

### Langkah 6: Edit main.dart
    Panggil screen baru tersebut di file main Anda seperti berikut.

```dart
home: LocationScreen(),
```

### Langkah 7: Run Project
    Run project Anda di device atau emulator (bukan browser), maka akan tampil seperti berikut ini.

![Image Running Project Practicum 6](lib/assets/images/report/report_p6-7.png)

### Langkah 8: Tambahkan animasi loading
    Tambahkan widget loading seperti kode berikut. Lalu hot restart, perhatikan perubahannya.

```dart

```

> 12. Task
> - Jika Anda tidak melihat animasi loading tampil, kemungkinan itu berjalan sangat cepat. Tambahkan delay pada method getPosition() dengan kode await Future.delayed(const Duration(seconds: 3));
> - Apakah Anda mendapatkan koordinat GPS ketika run di browser? Mengapa demikian?
>
>   Pada browser edge saya mendapatkan koordinat, karena browser meminta izin akses lokasi yang digunakan tetapi koordinat lokasi dapat berubah-rubah ketika browser direfresh. Hal tersebut bisa terjadi karena akurasi browser menggunakan Wi-Fi dan IP Address untuk mendapatkan lokasi dan akurasi lebih rendah dari pada menggunakan GPS.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 12".

![image for task 12](lib/assets/images/tasks/task12.gif)

## Praktikum 7: Manajemen Future dengan FutureBuilder
Pola ketika menerima beberapa data secara async dan melakukan update pada UI sebenarnya itu tergantung pada ketersediaan data. Secara umum fakta di Flutter, ada sebuah widget yang membantu Anda untuk memudahkan manajemen future yaitu widget FutureBuilder.

Anda dapat menggunakan FutureBuilder untuk manajemen future bersamaan dengan update UI ketika ada update Future. FutureBuilder memiliki status future sendiri, sehingga Anda dapat mengabaikan penggunaan setState, Flutter akan membangun ulang bagian UI ketika update itu dibutuhkan.

### Langkah 1: Modifikasi method getPosition()
    Buka file geolocation.dart kemudian ganti isi method dengan kode ini.

```dart
Future<Position> getPosition() async {
  await Geolocator.isLocationServiceEnabled();
  await Future.delayed(const Duration(seconds: 3));
  Position position = await Geolocator.getCurrentPosition();
  return position;
}
```

### Langkah 2: Tambah variabel
    Tambah variabel ini di class _LocationScreenState

```dart
class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  Future<Position>? position;
```

### Langkah 3: Tambah initState()
    Tambah method ini dan set variabel position

```dart
@override
void initState() {
  super.initState();
  position = getPosition();
}
```

### Langkah 4: Edit method build()
    Ketik kode berikut dan sesuaikan. Kode lama bisa Anda comment atau hapus.

```dart

```

> 13. Task 
> - Apakah ada perbedaan UI dengan praktikum sebelumnya? Mengapa demikian?
>
>   Tidak ada, karena kita menggunakan FutureBuilder() dan pada praktikum sebelumnya kita juga menggunakan Future. Dengan menggunakan FutureBuilder kita dapat membuat kode lebih rapi.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 13".
> - Seperti yang Anda lihat, menggunakan FutureBuilder lebih efisien, clean, dan reactive dengan Future bersama UI.

![image for task 13](lib/assets/images/tasks/task13.gif)

### Langkah 5: Tambah handling error
    Tambahkan kode berikut untuk menangani ketika terjadi error. Kemudian hot restart.

```dart
 builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Something terrible happened!');
      } else {
        return Text(snapshot.data.toString());
      }
    } else {
      return const Text('');
    }
  },
),
```

> 14. Task
> - Apakah ada perbedaan UI dengan langkah sebelumnya? Mengapa demikian?
>
>   Pada UI tidak menampilkan perbedaan karena hanya menambahkan kode untuk menangani error dengan menampilkan text.
>
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 14".

![image for task 14](lib/assets/images/tasks/task14.gif)

## Praktikum 8: Navigation route dengan Future Function
Praktikum kali ini Anda akan melihat manfaat Future untuk Navigator dalam transformasi Route menjadi sebuah function async. Anda akan melakukan push screen baru dan fungsi await menunggu data untuk melakukan update warna background pada screen.

### Langkah 1: Buat file baru navigation_first.dart
    Buatlah file baru ini di project lib Anda.

![image for practicum 8 step 1](lib/assets/images/report/report_p7-1.png)

### Langkah 2: Isi kode navigation_first.dart
```dart
import 'package:flutter/material.dart';

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            Navigator.push(
              context,
              _navigateAndGetColor(context),
            );
          },
        ),
      ),
    );
  }
}
```

> 15. Task
> - Tambahkan nama panggilan Anda pada tiap properti title sebagai identitas pekerjaan Anda.
> - Silakan ganti dengan warna tema favorit Anda.

```dart
olor color = const Color.fromARGB(255, 2, 175, 255);

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: color,
    appBar: AppBar(
      title: const Text('Navigation First Screen Lukman'),
    ),
    body: Center(
      child: ElevatedButton(
        child: const Text('Change Color'),
        onPressed: () {
          Navigator.push(
            context,
            _navigateAndGetColor(context),
          );
        },
      ),
    ),
  );
}
```

### Langkah 3: Tambah method di class _NavigationFirstState
    Tambahkan method ini.

```dart
Future _navigateAndGetColor(BuildContext context) async {
  color = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const NavigationSecond()),
  ) ?? Colors.blue;
}
```

### Langkah 4: Buat file baru navigation_second.dart
    Buat file baru ini di project lib Anda. Silakan jika ingin mengelompokkan view menjadi satu folder dan sesuaikan impor yang dibutuhkan.

![image for practicum 8 step 4](lib/assets/images/report/report_p7-4.png)

### Langkah 5: Buat class NavigationSecond dengan StatefulWidget
```dart
import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen Lukman'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Red'),
              onPressed: () {
                color = Colors.red.shade700;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Green'),
              onPressed: () {
                color = Colors.green.shade700;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Blue'),
              onPressed: () {
                color = Colors.blue.shade700;
                Navigator.pop(context, color);
              },
            ),
          ],
        )
      ),
    );
  }
}
```

### Langkah 6: Edit main.dart
    Lakukan edit properti home.

```dart
home: const NavigationFirst(),
```

### Langkah 7: Run Project
    Lakukan run, jika terjadi error silakan diperbaiki.

![Image1 Running Practicum 8]()
![Image2 Running Practicum 8]()

> 16. Task
> - Cobalah klik setiap button, apa yang terjadi ? Mengapa demikian ?
>
>   Hal tersebut bisa terjadi karena pada page pertama memanggil page kedua dimana page kedua digunakan untuk mengirimkan warna sesuai tombol yang dipilih, lalu page pertama akan mengganti value dari variabel color menjadi warna yang dipilih pada page kedua.
>
> - Gantilah 3 warna pada langkah 5 dengan warna favorit Anda!
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 16".

```dart
children: [
  ElevatedButton(
    child: const Text('Pink'),
    onPressed: () {
      color = const Color.fromARGB(255, 255, 0, 191);
      Navigator.pop(context, color);
    },
  ),
  ElevatedButton(
    child: const Text('Cyan'),
    onPressed: () {
      color = const Color.fromARGB(255, 0, 225, 255);
      Navigator.pop(context, color);
    },
  ),
  ElevatedButton(
    child: const Text('Purple'),
    onPressed: () {
      color = const Color.fromARGB(255, 255, 0, 255);
      Navigator.pop(context, color);
    },
  ),
],
```

![image for task 16](lib/assets/images/tasks/task16.gif)

## Praktikum 9: Memanfaatkan async/await dengan Widget Dialog
Pada praktikum ini, Anda akan memanfaatkan widget AlertDialog. Anda bisa manfaatkan widget ini misal untuk memilih operasi Save, Delete, Accept, dan sebagainya.

### Langkah 1: Buat file baru navigation_dialog.dart
    Buat file dart baru di folder lib project Anda.

![image for practicum 9 step 1](lib/assets/images/report/report_p9-1.png)

### Langkah 2: Isi kode navigation_dialog.dart
```dart
import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({Key? key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen Lukman'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {},
        ),
      ),
    );
  }
}
```

### Langkah 3: Tambah method async
```dart
_showColorDialog(BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: <Widget>[
            TextButton(
              child: const Text('Red'),
              onPressed: () {
                Navigator.pop(context, Colors.red.shade700);
              },
            ),
            TextButton(
              child: const Text('Green'),
              onPressed: () {
                Navigator.pop(context, Colors.green.shade700);
              },
            ),
            TextButton(
              child: const Text('Blue'),
              onPressed: () {
                Navigator.pop(context, Colors.blue.shade700);
              },
            ),
          ],
        );
      });
  setState(() {});
}
```

### Langkah 4: Panggil method di ElevatedButton
```dart
onPressed: () {
  _showColorDialog(context);
},
```

### Langkah 5: Edit main.dart
    Ubah properti home

```dart
home: const NavigationDialogScreen(),
```

### Langkah 6: Run Project
    Coba ganti warna background dengan widget dialog tersebut. Jika terjadi error, silakan diperbaiki. Jika berhasil, akan tampil seperti gambar berikut.

![Image Result Practicum 9](lib/assets/images/report/report_p9-6.png)

> 17. Task
> - Cobalah klik setiap button, apa yang terjadi ? Mengapa demikian ?
>
>   Ketika klik button maka warna backgroun akan berubah, dimana hal tersebut terjadi karena method _showColorDialog() mengirimkan value untuk mengisi/mengubah value variabel color.
>
> - Gantilah 3 warna pada langkah 3 dengan warna favorit Anda!
> - Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W12: Soal 17".

![image for task 17](lib/assets/images/tasks/task17.gif)