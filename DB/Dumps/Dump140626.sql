CREATE DATABASE  IF NOT EXISTS `il_cozzaro_nero` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `il_cozzaro_nero`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: il_cozzaro_nero
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Infuocato del Mare dei Ladri','infuocato-del-mare-dei-ladri'),(2,'Affumicato dei Relitti','affumicato-dei-relitti'),(3,'Abisso del Kraken','abisso-del-kraken'),(4,'Taverna dell\'Ancora Spezzata','taverna-dell-ancora-spezzata'),(5,'Maledizione dell\'Ordine delle Anime','maledizione-dell-ordine-delle-anime');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id_product` bigint unsigned NOT NULL,
  `id_category` bigint unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_category`),
  KEY `product_category_id_category_foreign` (`id_category`),
  CONSTRAINT `product_category_id_category_foreign` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_category_id_product_foreign` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,1),(4,1),(7,1),(11,1),(14,1),(3,2),(5,2),(6,2),(10,2),(17,2),(2,3),(9,3),(12,3),(20,3),(22,3),(8,4),(13,4),(18,4),(21,4),(24,4),(15,5),(16,5),(19,5),(23,5),(25,5);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `country` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `availability` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Cozze del Tesoro Insanguinato','Cozze in salsa di pomodoro piccante con un goccio di rum. Un piatto che sa di vendetta e bottino caldo.',16.50,'Italia','img1.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(2,'Sgradita Sorpresa del Kraken','Cozze in umido nero al calamaro, accompagnate da tentacoli di polpo affumicato. Attenzione al sapore abissale!',19.90,'Spagna','img2.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(3,'Zuppa del Brigantino Maledetto','Brodo denso di pesce con cozze e croste di pane bruciato. Per marinai dal palato coraggioso.',14.50,'Francia','img3.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(4,'Cozze alla Grog dell\'Ammutinamento','Saltate in padella con birra scura, lime, pepe di Cayenna e scorza d\'arancia. Un sapore ribelle.',15.00,'Inghilterra','img4.png',0,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(5,'Sfida del Capitano Barbabianca','Cozze giganti gratinate con formaggio affumicato e pangrattato al pepe nero. Solo per veri capitani.',22.00,'Portogallo','img5.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(6,'Cozze del Cimitero dei Galeoni','Al vapore con alghe, vino bianco secco e aglio selvatico, servite in una ciotola a forma di teschio.',17.50,'Grecia','img6.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(7,'L\'Ultimo Respiro del Marinaio','Cozze in crema di coconut e curry rosso, con un tocco di pepe fantasma. Piccante come una maledizione.',18.00,'Thailandia','img7.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(8,'Vendetta dello Scheletro d\'Argento','Cozze fritte in pastella nera al carbone vegetale con salsa allo yogurt e lime.',15.50,'Messico','img8.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(9,'Occhio di Scopario','Cozze al limone e prezzemolo, flambate al rhum speziato. Un lampo di sapore nel buio.',16.00,'Italia','img9.png',0,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(10,'Scompiglio del Maelstrom','Cozze in salsa agrodolce con peperoni arrosto e un\'insalata di finocchi e arancia rossa.',20.00,'Croazia','img10.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(11,'Furia del Vulcano Sottomarino','Cozze saltate in olio di peperoncino lavico e aglio nero, con scaglie di sale affumicato. Ardenti come la furia del mare.',18.50,'Islanda','img11.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(12,'Segreto della Sirena Corallina','Cozze in salsa rosa di corallo (pomodoro e panna) con petali di fiori edibili. Un incanto per gli occhi e il palato.',21.00,'Italia','img12.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(13,'Lacrime del Fantasma di Flotta','Cozze in brodo di pesce azzurro al limone e capperi, servite con crostini neri al carbone. Per chi piange il bottino perduto.',17.00,'Irlanda','img13.png',0,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(14,'Braciere del Pirata Re','Cozze gratinate con tre formaggi (cheddar affumicato, gouda, parmigiano) e scaglie di tartufo nero. Lusso da capitano.',24.50,'Francia','img14.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(15,'Vento dell\'Olandese Volante','Cozze al vapore con zenzero, lemongrass e latte di cocco, servite in una zucca scavata. Leggere come la brezza maledetta.',19.00,'Olanda','img15.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(16,'Morso dello Squalo Bianco','Cozze piccantissime con salsa harissa, yogurt greco e menta fresca. Un morso che non dimenticherai.',16.00,'Marocco','img16.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(17,'Oro Liquido del Galeone Sommerso','Cozze in zafferano e vino bianco, con patate novelle e prezzemolo. Un tesoro liquido da gustare.',22.50,'Spagna','img17.png',0,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(18,'Polvere da Sparo della Ciurma','Cozze impanate con pangrattato al pepe nero e paprika affumicata, fritte e servite con salsa barbecue piccante.',14.50,'Stati Uniti','img18.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(19,'Cantico del Nostromo Ubriaco','Cozze stufate nel rum scuro, miele di canna e chiodi di garofano, con scorza di lime.',18.00,'Giamaica','img19.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(20,'Scheletro di Corallo','Cozze bianche al vino bianco secco, aglio e prezzemolo, servite con ossa di pane (grissini di segale).',15.00,'Grecia','img20.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(21,'Soffio del Drago Marino','Cozze in salsa al curry verde tailandese extra piccante, con bambù e peperone rosso. Fuoco liquido.',19.50,'Thailandia','img21.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(22,'Teschio e Ossa della Confraternita','Cozze nere (inchiostro di seppia) con riduzione di Porto e scalogno, servite in una casseruola a forma di teschio.',20.00,'Portogallo','img22.png',0,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(23,'Anello della Sfinge Marina','Cozze in umido con pomodorini ciliegia, olive taggiasche e origano, servite con anelli di calamaro fritti.',17.50,'Italia','img23.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(24,'Pergamena Stregata del Cuoco','Cozze involtine in foglie di cavolo nero, ripiene di ricotta e noci, cotte al forno con besciamella al formaggio.',21.00,'Italia','img24.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40'),(25,'Ultima Sfida del Corsaro','Cozze giganti alla diavola (peperoncino, aglio, prezzemolo e vino rosso), servite con pane abbrustolito. Per morire o vincere.',23.00,'Italia','img25.png',1,'2026-06-12 09:01:23','2026-06-12 09:01:40');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `valutation` decimal(2,1) NOT NULL,
  `text` text NOT NULL,
  `id_product` bigint unsigned DEFAULT NULL,
  `author` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_id_product_foreign` (`id_product`),
  CONSTRAINT `reviews_id_product_foreign` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,4.5,'Un tesoro per il palato! Il rum si sente giusto, perfetto dopo una giornata di navigazione.',1,'Capitan Barbascura','Un vero affare da pirata'),(2,5.0,'Salsa piccante e avvolgente. Le cozze freschissime. Lo ricomprerei subito.',1,'Luciano il Rosso','Sangue e gloria'),(3,3.8,'Buono ma il rum era un po\' troppo forte per me. Forse un goccio di meno.',1,'Marina la Timida','Un po’ troppo alcolico'),(4,4.7,'Ideale come antipasto per una ciurma affamata. Porzione generosa.',1,'Cannoniere Salty','Tesoro approvato'),(5,4.2,'Ben presentato, sapore deciso. Il prezzo è onesto per la qualità.',1,'Fiorenzo il Mercante','Buon rapporto qualità/prezzo'),(6,5.0,'Il nero del kraken mi ha intimidito, ma il sapore è stupefacente. Da riprovare!',2,'Sirena Nera','Sorpresa abissale riuscita'),(7,4.8,'Il polpo affumicato è un plus fantastico. Umido perfetto.',2,'Mastro Polpo','Kraken da urlo'),(8,4.0,'Troppo nero per i miei gusti estetici, ma il sapore c\'è. Coraggioso.',2,'Greta la Scettica','Non mi aspettavo così tanto nero'),(9,5.0,'I tentacoli fanno la differenza. Sembra un piatto da leggenda.',2,'Cacciatore di Kraken','Mito culinario'),(10,4.5,'Saporito e misterioso. Lo riordinerei in occasione di una burrasca.',2,'Timone Nero','Sgradito? No, graditissimo!'),(11,3.8,'Zuppa sostanziosa, ma un po\' troppo affumicata per i miei gusti. Ideale per un equipaggio affamato.',3,'Galeotto Malandrino','Brodo coraggioso'),(12,4.2,'Le croste di pane bruciato danno consistenza. Buona la densità.',3,'Cuoco Maledetto','Pane e mare'),(13,4.5,'Affumicatura decisa ma equilibrata. Mi ha ricordato i relitti del passato.',3,'Ventura la Vecchia','Ricordo di naufragio'),(14,3.5,'Troppo affumicato, copriva il sapore delle cozze. Non per tutti.',3,'Palato Fino','Fumo eccessivo'),(15,4.0,'Zuppa calda e confortante. Perfetta per una notte tempestosa.',3,'Nostromo Greg','Brodo che scalda l’anima'),(16,4.0,'Peccato non fosse disponibile, ma l\'odore dalla cucina prometteva bene. La prossima volta!',4,'Mastro Timone','Fantasma di grog'),(17,4.9,'La birra scura e il lime: esplosione di freschezza. Pepe giusto.',4,'Ribelle Jack','Ammutinamento riuscito'),(18,4.3,'Sapore deciso, ideale per chi ama le birre strong. Un po’ amara.',4,'Brewmaster Flint','Grog potente'),(19,4.6,'L’arancia e il lime insieme sono geniali. Peccato non sia sempre disponibile.',4,'Agrume Pirata','Agrume ribelle'),(20,3.9,'Buona ma la prossima volta chiedo meno pepe. Bruciava un po’ troppo.',4,'Sofia la Piccante','Fuoco amico'),(21,5.0,'Sfida vinta! Le cozze giganti sono una goduria. Il formaggio affumicato è la ciliegina sulla torta.',5,'Barbabianca Jr','Sfida superata con onore'),(22,4.8,'Gratinatura croccante e saporita. Pepe nero ben dosato.',5,'Fornaio Pirata','Cozze da re'),(23,5.0,'Le cozze più grandi che abbia mai mangiato. Valgono ogni doblone.',5,'Gigante Buono','Sfida vinta in scioltezza'),(24,4.5,'Formaggio affumicato eccellente. Forse un po’ pesante come piatto unico.',5,'Dieta del Corsaro','Sostanzioso ma ricco'),(25,4.7,'Lo consiglio a chi vuole stupire l’equipaggio. Presentazione scenica.',5,'Capitano Cerimonia','Sfida da condividere'),(26,4.2,'Servizio da veri pirati: la ciotola a teschio fa la sua figura. Buone ma leggermente salate.',6,'Teschio Parlante','Cimitero di sapori'),(27,4.5,'Alghe e vino bianco: abbinamento azzeccato. L’aglio selvatico dà un tocco speciale.',6,'Erborista Marina','Relitto profumato'),(28,4.0,'Troppo sale per i miei gusti. La ciotola è bellissima ma il contenuto migliorabile.',6,'Salato Salty','Un po’ troppo marinaio'),(29,4.8,'Un piatto che racconta una storia. Sapore autentico dei relitti.',6,'Storico dei Mari','Naufragio delizioso'),(30,4.3,'Le cozze erano cotte alla perfezione. Servizio veloce.',6,'Velocista del Mare','Cimitero saporito'),(31,4.7,'Il piccante del pepe fantasma è subdolo: prima dolce, poi esplode. Per palati forti. Consigliato!',7,'Maria la Rossa','Respiro affogato nel fuoco'),(32,5.0,'Creamy coconut e curry rosso: una bomba. Il pepe fantasma è letale ma piacevole.',7,'Diavolo della Cucina','Maledizione piccante'),(33,4.2,'Ottimo ma davvero troppo piccante per me. Ho bevuto tre bicchieri d’acqua.',7,'Acqua Dolce','Respiro corto'),(34,4.9,'Equilibrio perfetto tra dolcezza del cocco e calore del curry. Un capolavoro.',7,'Chef Stellato','Ultimo respiro indimenticabile'),(35,4.5,'Lo raccomando agli amanti del piccante. Attenzione: non per deboli di cuore.',7,'Mangiafuoco','Sfida infuocata'),(36,3.5,'La pastella nera è scenica, ma un po\' secca. La salsa allo yogurt salva il tutto.',8,'Scheletro d\'Argento','Vendetta ok, ma migliorabile'),(37,4.0,'Fritte croccanti, la pastella al carbone è originale. Salsa rinfrescante.',8,'Fritturista Pazzo','Nero che piace'),(38,4.5,'Le cozze erano tenere. La presentazione nera come la notte è spettacolare.',8,'Notte Oscura','Vendetta riuscita'),(39,3.8,'Un po’ asciutto. Avrei gradito più salsa.',8,'Salsa Lover','Meno vendetta, più yogurt'),(40,4.2,'Sapore particolare, la pastella non copre il gusto delle cozze. Buono.',8,'Assaggiatore Anonimo','Argento e carbone'),(41,4.8,'Flambé spettacolare! Il rhum esalta il sapore delle cozze. Uno dei migliori.',9,'Scopario Lesto','Luce nel buio (peccato esaurito)'),(42,5.0,'Limone e prezzemolo freschissimi. La fiammata al rhum è stata un colpo di teatro.',9,'Fiamma del Mare','Occhio di bue'),(43,4.5,'Il gusto pulito del limone si sposa bene con la dolcezza del rhum. Elegante.',9,'Signora dei Limoni','Agrume flambato'),(44,4.7,'Peccato non sia più disponibile. Era il mio piatto preferito.',9,'Cliente Fedele','Ritorno desiderato'),(45,4.3,'Buono ma il rhum poteva essere più leggero. Comunque spettacolo assicurato.',9,'Spettatore Incantato','Fumo e luci'),(46,4.3,'Agrodolce equilibrato, l\'insalata di finocchi è un contorno rinfrescante. Ideale per l\'estate.',10,'Maelstrom Jones','Scompiglio piacevole'),(47,4.8,'Mai provato cozze con peperoni arrosto e arancia rossa: sorprendente.',10,'Fruttato Pirata','Maelstrom dolce e aspro'),(48,4.0,'Un po’ troppo dolce per me. Preferirei più acido.',10,'Acido Jack','Agrodolce da rivedere'),(49,4.6,'Insalata di finocchi freschissima, un contorno che merita da solo.',10,'Finocchio Selvatico','Scompiglio rinfrescante'),(50,4.5,'Piatto estivo perfetto. Peperoni arrosto morbidi e saporiti.',10,'Estate Perpetua','Scompiglio sotto il sole'),(51,5.0,'Piccante al punto giusto! Il peperoncino lavico è una scoperta. Da ripetere.',11,'Furia di Vulcano','Lava nel piatto'),(52,4.7,'Aglio nero e sale affumicato: abbinamento potente. Le cozze cotte alla perfezione.',11,'Vulcanologo Goloso','Eruzione di sapori'),(53,4.5,'Un piatto ardente ma non devastante. Lo consiglio con una birra fresca.',11,'Birra e Lava','Furia domata'),(54,4.9,'Il peperoncino lavico è mitico. Vorrei comprarlo in barattolo.',11,'Peperoncino Man','Liquido di fuoco'),(55,4.2,'Troppo piccante per la mia ragazza, a me è piaciuto. Abbiamo litigato.',11,'Coppia in Furia','Discussione piccante'),(56,4.6,'Salsa rosa delicata e fiori edibili: un piatto da vera principessa pirata.',12,'Sirenetta Marina','Segreto incantevole'),(57,5.0,'Il corallo di pomodoro e panna è una creazione geniale. Fiori profumati.',12,'Fiorista del Mare','Incanto commestibile'),(58,4.3,'Molto delicato, forse troppo per un pirata tradizionale. Per palati fini.',12,'Gourmet Pirata','Elegante ma leggero'),(59,4.8,'Visivamente stupendo. Il sapore è dolce e romantico. Piaciuto molto.',12,'Cuore di Sirena','Segreto svelato'),(60,4.5,'I petali di fiori sono un tocco raffinato. Le cozze erano freschissime.',12,'Cercatore di Bellezza','Sirena in tavola'),(61,4.0,'Brodo leggero e saporito. Peccato fosse l\'ultimo piatto disponibile.',13,'Fantasma di Flotta','Lacrime salate ma buone'),(62,4.5,'Capperi e limone: freschezza marina. I crostini neri sono originali.',13,'Ombra Salata','Fantasma rinfrescante'),(63,3.8,'Brodo troppo liquido per i miei gusti. Preferisco consistenza.',13,'Zuppa Densa','Lacrime leggere'),(64,4.7,'Ecco un piatto che emoziona. Sembra di sentire il pianto dei marinai.',13,'Poeta dei Mari','Lirica liquida'),(65,4.2,'Buono ma non memorabile. I crostini neri erano un po’ molli.',13,'Critico Severo','Lacrima asciutta'),(66,4.9,'Tre formaggi e tartufo: un lusso che merita ogni doblone. Eccezionale.',14,'Re dei Pirati','Braciere reale'),(67,5.0,'Il più costoso ma ne vale la pena. Cheddar affumicato e tartufo: coppia regale.',14,'Nobile Corsaro','Lusso in tavola'),(68,4.8,'Gratinatura croccante, tartufo abbondante. Un piatto da cerimonia.',14,'Banchetto Pirata','Braciere degno di un re'),(69,4.5,'Forse troppo ricco per un pasto normale. Ideale per occasioni speciali.',14,'Mangiare Sano','Opulenza ogni tanto'),(70,4.7,'Il gouda si sente meno, ma il parmigiano domina. Comunque sublime.',14,'Formaggio D.O.P.','Re dei formaggi'),(71,3.9,'La zucca è originale, ma il sapore del cocco copre un po\' le cozze. Comunque buono.',15,'Olandese Volante','Vento leggero, sapore discreto'),(72,4.5,'Zenzero e lemongrass: abbinamento fresco e aromatico. Latte di cocco cremoso.',15,'Speziale Maledetto','Brezza profumata'),(73,4.2,'La zucca contenitore è scenografica ma il piatto scotta le mani. Servire con attenzione.',15,'Mani Bruciate','Caldo come la maledizione'),(74,4.7,'Piatto leggero e profumato, perfetto per una serata estiva. Lo riordinerò.',15,'Brezza Marina','Volante ma gustoso'),(75,4.0,'Un po’ troppo dolce per i miei gusti salati. Meglio le versioni piccanti.',15,'Salato Salomon','Dolce volante'),(76,4.4,'Harissa e yogurt: contrasto perfetto. Davvero un \"morso\" deciso.',16,'Squalo Bianco','Morso affilato'),(77,5.0,'Piccante equilibrato, la menta fresca dà un tocco sorprendente. Da leccarsi i baffi.',16,'Predatore','Morso letale ma buono'),(78,4.3,'Lo yogurt calma un po’ il piccante. Ben studiato.',16,'Pescatore Attento','Squalo in agguato'),(79,4.8,'Harissa fatta in casa? Sapore autentico. Complimenti allo chef.',16,'Speziato Volante','Nord Africa nei mari dei ladri'),(80,4.1,'Un po’ troppo forte per la cena leggera. Ma come piatto unico ci sta.',16,'Dieta del Mare','Morso pesante'),(81,5.0,'Lo zafferano è divino. Questo piatto vale il viaggio fino al galeone sommerso.',17,'Oro Liquido','Tesoro ritrovato (peccato esaurito)'),(82,4.9,'Vino bianco e zafferano: salsa elegante. Patate novelle morbide.',17,'Sommerso d\'Oro','Liquido prezioso'),(83,4.5,'Peccato non sia più disponibile. Era uno dei migliori.',17,'Tesoriere','Oro perduto'),(84,4.7,'Le patate novelle assorbono benissimo il sugo. Un piatto completo.',17,'Patatoide','Galeone patatoso'),(85,4.6,'Zafferano di qualità, si sente. Prezzo giusto per un piatto così ricco.',17,'Speziale d\'Oro','Oro in ogni cucchiaio'),(86,4.1,'Buone, ma la polvere da sparo (pepe) si sente tanto. Per palati robusti.',18,'Cannoniere Jack','Scoppio di sapore'),(87,4.5,'Impanatura croccante, salsa barbecue piccante azzeccata. Ottimo street food pirata.',18,'Fritturista Jack','Sparo riuscito'),(88,4.3,'Un po’ pesante da digerire, ma buonissimo. Da mangiare con le mani.',18,'Mani Sporche','Polvere in faccia'),(89,4.8,'La paprika affumicata nella panatura è geniale. Le cozze fritte non sono banali.',18,'Affumicato','Sparo saporito'),(90,4.0,'Troppo fritto per i miei gusti. Preferisco le cozze al vapore.',18,'Salutista','Polvere leggera'),(91,4.7,'Il rum e miele creano una salsa densa e dolce. Sembra una poesia ubriaca.',19,'Nostromo Ubriaco','Cantico da ricordare'),(92,5.0,'Chiodi di garofano e lime: equilibrio perfetto. Salsa da leccare il piatto.',19,'Ubriacone','Cantico indimenticabile'),(93,4.5,'Un piatto dolce e alcolico. Perfetto dopo una battaglia.',19,'Miele e Rum','Dolce ubriacatura'),(94,4.3,'Forse troppo alcol, ma il miele compensa. Buono ma non esagerare.',19,'Sobrio Marinaio','Cantico a metà'),(95,4.8,'La scorza di lime fresca dà la sveglia. Geniale.',19,'Agrume Ubriaco','Sveglia piccante'),(96,4.2,'Semplici ma fatte bene. Le \"ossa di pane\" sono simpatiche.',20,'Corallo Spettrale','Scheletro croccante'),(97,4.5,'Vino bianco e aglio: classico intramontabile. Le cozze erano perfette.',20,'Classicista','Ossa classiche'),(98,4.0,'Grissini di segale un po’ duri, ma l’idea è carina.',20,'Masticatore','Ossa dure'),(99,4.7,'Piatto semplice ma eseguito benissimo. Le cozze bianche sono una rarità.',20,'Cozzaro','Scheletro bianco'),(100,4.3,'Prezzemolo fresco abbondante. Lo consiglio a chi ama la tradizione.',20,'Tradizionalista','Corallo del passato'),(101,4.5,'Curry verde potente! Chi ama il piccante impazzirà.',21,'Drago Marino','Soffio infuocato'),(102,5.0,'Bambù e peperone rosso: texture fantastica. Curry tailandese autentico.',21,'Thai Pirata','Drago in gabbia'),(103,4.2,'Piccante ma gestibile. Il bambù è un po’ insipido ma croccante.',21,'Mangia Bambù','Soffio orientale'),(104,4.8,'Salsa densa che avvolge le cozze. Un viaggio in Thailandia senza lasciare la taverna.',21,'Viaggiatore','Soffio d\'oriente'),(105,4.0,'Troppo simile a un curry normale. Mi aspettavo più originalità.',21,'Esigente','Drago comune'),(106,4.0,'Il nero e il Porto: eleganti. Peccato la disponibilità limitata.',22,'Confraternita Oscura','Teschio e ossa degni'),(107,4.9,'Inchiostro di seppia e riduzione di Porto: abbinamento sofisticato. Scalogno perfetto.',22,'Cultore del Teschio','Simbolo di gusto'),(108,4.5,'La casseruola a teschio fa la sua figura. Piatto da collezione.',22,'Collezionista','Teschio da esposizione'),(109,4.3,'Il Porto rende la salsa dolce. Forse troppo per me, ma buono.',22,'Amara Verità','Dolce teschio'),(110,4.7,'Lo scalogno caramellato è la ciliegina. Un piatto da confraternita segreta.',22,'Scalogno Nero','Segreto svelato'),(111,4.6,'I calamari fritti con le cozze sono un duo vincente.',23,'Sfinge Marina','Anello di sapori'),(112,5.0,'Pomodorini ciliegia e olive taggiasche: condimento mediterraneo. Origano profumato.',23,'Mediterraneo','Sfinge deliziosa'),(113,4.4,'I calamari erano un po’ gommosi, ma il sugo delle cozze li ha salvati.',23,'Masticone','Anello imperfetto'),(114,4.8,'Piatto completo e ricco. I pomodorini danno freschezza.',23,'Giardiniere Marino','Sfinge fresca'),(115,4.5,'Le olive taggiasche sono una goduria. Peccato poche.',23,'Amante Olive','Anello salato'),(116,4.3,'Involtini originali, la besciamella li rende morbidi. Buoni ma impegnativi.',24,'Cuoco Stregato','Pergamena gustosa'),(117,4.8,'Foglie di cavolo nero morbide, ripieno di ricotta e noci: cremoso e croccante.',24,'Vegetale Pirata','Stregoneria vegetale'),(118,4.5,'La besciamella al formaggio avvolge bene. Peccato sia un piatto lento da preparare.',24,'Paziente','Pergamena che sazia'),(119,4.0,'Troppo ricco e pesante. Meglio come piatto unico.',24,'Leggero','Stregoneria pesante'),(120,4.7,'Involtini ben sigillati, il cavolo nero non era amaro. Bravi.',24,'Cavolo Nero','Pergamena riuscita'),(121,5.0,'Alla diavola come si deve. Le cozze giganti sono un lusso. Imperdibile.',25,'Corsaro Nero','Ultima sfida, vittoria assicurata'),(122,4.9,'Peperoncino, aglio, prezzemolo e vino rosso: classico diavolo potente. Cozze enormi.',25,'Diavolo Corsaro','Sfida superata'),(123,4.7,'Il pane abbrustolito è perfetto per la scarpetta. Una goduria.',25,'Scarpetta','Ultimo morso'),(124,5.0,'La mia preferita tra tutte. Piccante e saporita. Il corsaro vince.',25,'Campione','Sfida vinta'),(125,4.8,'Un piatto degno di un capitano. Lo consiglio a chi cerca emozioni forti.',25,'Vincitore','Sfida epica');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-14 11:58:58
