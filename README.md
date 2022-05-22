
### IOS Deployment Info:
IOS 15.0 ve üzeri

### Kullanılan Teknolojiler ve Yapılar
- [x] [Kingfisher](https://github.com/onevcat/Kingfisher)
- [x] AVFoundation
- [x] URLSession
- [x] Generics
- [x] CollectionView
- [x] VIPER
- [X] Swipe Gesture Recognizer
- [x] Codable

Uygulamanın yapımında VIPER patterni kullandım. VIPER ile uygulamanın yapım aşamasında belirli roller belirlenir ve kodlar ayrıştırılır. Bu durum kodların birbirinden bağımsız olabilmesini sağlar ve yeni bir özellik eklerken daha rahat eklenir.

İstek atma fonksiyonunu generic type olarak ayarladım. Böylece türden bağımsız işlem yapmamı sağlayacak. Her türlü url tipi için istek atabileceğim.

Uygulamada API'den veri çekme için URLSession kullandım. Uygulamanın çok fazla üçüncü parti kütüphanelere bağlı olmasını istemediğimden URLSession tercih ediyorum. 

API'den resimleri alabilmek için Kingfisher kütüphanesinden yararlandım. Kingfisher sayesinde internet üzerinden resimleri oldukça kolay bir şekilde indirebiliyorum.

Uygulamada kategori adını ve o kategorideki filmleri CollectionView sayesinde gösterdim. Swipe ile sayfalar arası geçişler sağlanıyor. Swipe işlemini yapabilmek için Swipe Gesture Recognizer kullandım. Her geçişte sayfa içerindeki içerikler değişiyor. Swipe animasyonu için Transitions animasyonundan yararlandım.

CollectionView içerisindeki herhangi bir içeriğe tıkladığımızda ayrı bir sayfaya yönlendirilir. O sayfa içerisinde verilen videoyu AVPlayer sayesinde oynattım. Video üzerinde tıklanılan içerisin adı mevcut. Video pause/resume, forward/run back( 5 saniye) fonksiyonlarını içermektedir.


### Uygulama Ekran Kaydı:

https://user-images.githubusercontent.com/36795459/169716913-8be514b3-e234-4899-a0de-53a86de320d7.mp4













