

/* ???? ?????????? (????????) */
DROP TABLE IF EXISTS media CASCADE;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	url VARCHAR(250) NOT NULL UNIQUE,
	filename VARCHAR(250) NOT NULL UNIQUE,
 	metadata JSON	
);

--/* ?????? gender*/
----CREATE TYPE gender_t AS ENUM ('male', 'female');

/* ??????? ?????????????*/
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL, 
    lastname VARCHAR(50)NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    gender gender_t,
    password VARCHAR(100),
    photo_user INT,
    created_at TIMESTAMP DEFAULT NOW(),
    
    FOREIGN KEY (photo_user) REFERENCES media(id)    
);

CREATE INDEX users_firstname_lastname_idx ON users (firstname,lastname);

/*??????? ? ??????? ????????*/
DROP TABLE IF EXISTS addresses CASCADE;
CREATE TABLE addresses(
	id SERIAL PRIMARY KEY,
	user_id INT,
	country VARCHAR(50),
	city VARCHAR(50),
	street VARCHAR(50),
	home VARCHAR(50),

	FOREIGN KEY (user_id) REFERENCES users(id)
);


/*??????? ? ????????????? ???????? ???????*/
DROP TABLE IF EXISTS brand_names CASCADE;
CREATE TABLE brand_names(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL
);

/*??????? ????????? ??????*/
DROP TABLE IF EXISTS categories CASCADE;
CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	category VARCHAR(150) NOT NULL
);

/* ??????? ??????*/
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name_product VARCHAR(255),
    brand_id INT,
    category_id INT,
    description TEXT,
    price INT, 
    
    FOREIGN KEY (brand_id) REFERENCES brand_names(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

/*??????? ???????? ??????*/
DROP TABLE IF EXISTS product_sizes CASCADE;
CREATE TABLE product_sizes(
	id SERIAL PRIMARY KEY,
	sizes CHAR (14) NOT NULL
);

/*??????? ??????*/
DROP TABLE IF EXISTS colors CASCADE;
CREATE TABLE colors(
	id SERIAL PRIMARY KEY,
	color CHAR (30) NOT NULL
);

/*??????? ?????????? ??????*/
DROP TABLE IF EXISTS number_products CASCADE;
CREATE TABLE number_products(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  color_id INT NOT NULL,
  size_id INT,
  quantity INT  DEFAULT 0,
  
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (color_id) REFERENCES colors(id),
  FOREIGN KEY (size_id) REFERENCES product_sizes(id) 
);


/*??????? ?????????? (????????) ??????*/
DROP TABLE IF EXISTS photo_products CASCADE;
CREATE TABLE photo_products(
	id SERIAL,
    media_id INT NOT NULL,
    product_id INT NOT NULL,
	color_id INT,
 	
 	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (product_id) REFERENCES products(id),
 	FOREIGN KEY (color_id) REFERENCES colors(id)
);

/*??????? ??????????? ????????*/
DROP TABLE IF EXISTS orders_product CASCADE;
CREATE TABLE orders_product(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  color_id INT,
  size_id INT,
  total INT DEFAULT 1,
  
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (color_id) REFERENCES colors(id),
  FOREIGN KEY (size_id) REFERENCES product_sizes(id) 
);


/*??????? ??????*/
DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  order_product_id INT NOT NULL,
  address_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (address_id) REFERENCES addresses(id),
  FOREIGN KEY (order_product_id) REFERENCES orders_product(id) 
);

/*??????? ??????? ? ????????*/
DROP TABLE IF EXISTS reviews_shop CASCADE;
CREATE TABLE reviews_shop(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
 
  FOREIGN KEY (user_id) REFERENCES users(id) 
);

/*??????? ??????? ? ??????*/
DROP TABLE IF EXISTS reviews_product;
CREATE TABLE reviews_product(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
   
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id) 
);

/*??????? ??????*/
DROP TABLE IF EXISTS discounts CASCADE;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
  product_id INT,
  discount INT,
  started_at TIMESTAMP NOT NULL,
  finished_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

/*
 * ??????? ??????????
 */

INSERT INTO media (id, url, filename, metadata)
VALUES (1,'http://murraykertzmann.com/','vero',NULL),(2,'http://kirlin.com/','reiciendis',NULL),(3,'http://harris.org/','aliquam',NULL),(4,'http://walter.com/','accusamus',NULL),(5,'http://kuphal.org/','laborum',NULL),(6,'http://cronawelch.biz/','illo',NULL),(7,'http://dubuquerau.com/','libero',NULL),(8,'http://murazikarmstrong.org/','eius',NULL),(9,'http://www.thiel.com/','explicabo',NULL),(10,'http://www.veum.com/','tempora',NULL),(11,'http://www.lindkuhic.com/','praesentium',NULL),(12,'http://kuvaliswalsh.info/','qui',NULL),(13,'http://www.considinemurphy.net/','expedita',NULL),(14,'http://gutkowskiroberts.net/','perferendis',NULL),(15,'http://abbottbatz.org/','enim',NULL),(16,'http://bechtelarmcglynn.org/','sit',NULL),(17,'http://gerhold.com/','voluptates',NULL),(18,'http://becker.com/','nulla',NULL),(19,'http://www.oconnellrosenbaum.com/','consequatur',NULL),(20,'http://www.runte.net/','veritatis',NULL),(21,'http://strosin.org/','omnis',NULL),(22,'http://lemke.org/','eaque',NULL),(23,'http://padberg.com/','quia',NULL),(24,'http://www.mraz.com/','quo',NULL),(25,'http://www.labadie.com/','delectus',NULL),(26,'http://www.lubowitz.com/','nobis',NULL),(27,'http://gleichner.info/','ratione',NULL),(28,'http://lakin.com/','iusto',NULL),(29,'http://www.gaylord.com/','dolores',NULL),(30,'http://zulauflemke.com/','unde',NULL),(31,'http://boehmmetz.com/','est',NULL),(32,'http://huels.com/','iste',NULL),(33,'http://www.orn.com/','esse',NULL),(34,'http://leschullrich.com/','officiis',NULL),(35,'http://lakinrice.net/','fugiat',NULL),(36,'http://www.goodwin.com/','ipsam',NULL),(37,'http://www.wilderman.com/','harum',NULL),(38,'http://hilll.com/','dignissimos',NULL),(39,'http://gibson.net/','placeat',NULL),(40,'http://pacocha.org/','molestias',NULL),(41,'http://beer.info/','totam',NULL),(42,'http://kesslerhartmann.com/','consectetur',NULL),(43,'http://carter.org/','doloribus',NULL),(44,'http://www.kunde.com/','et',NULL),(45,'http://cassinlangosh.com/','quis',NULL),(46,'http://www.bernhard.com/','repellat',NULL),(47,'http://www.hodkiewiczbednar.com/','rerum',NULL),(48,'http://reinger.info/','fugit',NULL),(49,'http://www.koch.com/','molestiae',NULL),(50,'http://emmerichcassin.biz/','vel',NULL),(51,'http://www.leannonbogisich.com/','aut',NULL),(52,'http://lubowitzrutherford.com/','modi',NULL),(53,'http://www.gutmann.com/','quisquam',NULL),(54,'http://www.hicklepacocha.com/','ad',NULL),(55,'http://www.dietrich.net/','tempore',NULL),(56,'http://carter.com/','adipisci',NULL),(57,'http://wiegand.com/','cupiditate',NULL),(58,'http://www.kuphaltorp.com/','blanditiis',NULL),(59,'http://farrellbode.com/','ipsa',NULL),(60,'http://www.croninprice.com/','nam',NULL),(61,'http://feil.net/','commodi',NULL),(62,'http://moore.com/','nihil',NULL),(63,'http://collins.com/','alias',NULL),(64,'http://boehmcrist.com/','aspernatur',NULL),(65,'http://www.schneider.com/','sequi',NULL),(66,'http://www.shanahanzieme.com/','voluptatem',NULL),(67,'http://www.ohara.com/','labore',NULL),(68,'http://eichmann.biz/','sed',NULL),(69,'http://www.durganstiedemann.biz/','facere',NULL),(70,'http://jacobson.net/','pariatur',NULL),(71,'http://www.buckridge.info/','ut',NULL),(72,'http://www.ritchierice.com/','magni',NULL),(73,'http://www.schneiderwolf.com/','asperiores',NULL),(74,'http://johns.biz/','illum',NULL),(75,'http://bednarwillms.biz/','sint',NULL),(76,'http://www.hodkiewicz.org/','minima',NULL),(77,'http://swift.com/','ea',NULL),(78,'http://auer.org/','numquam',NULL),(79,'http://abbott.biz/','ex',NULL),(80,'http://okunevahackett.com/','sunt',NULL),(81,'http://www.terry.biz/','ullam',NULL),(82,'http://www.macejkovic.info/','nostrum',NULL),(83,'http://kutch.com/','reprehenderit',NULL),(84,'http://waelchi.org/','maxime',NULL),(85,'http://www.reingertromp.biz/','neque',NULL),(86,'http://www.cummings.info/','a',NULL),(87,'http://www.harberparker.com/','dolorum',NULL),(88,'http://weissnat.info/','dicta',NULL),(89,'http://www.beahanborer.com/','at',NULL),(90,'http://prohaska.com/','quasi',NULL),(91,'http://www.smitham.com/','minus',NULL),(92,'http://www.rogahn.org/','soluta',NULL),(93,'http://mueller.com/','ducimus',NULL),(94,'http://wittingemmerich.com/','aliquid',NULL),(95,'http://bahringerfriesen.com/','veniam',NULL),(96,'http://www.carrollbednar.com/','provident',NULL),(97,'http://abbottweimann.org/','odio',NULL),(98,'http://quigley.com/','id',NULL),(99,'http://deckow.com/','dolor',NULL),(100,'http://www.senger.biz/','laboriosam',NULL);

INSERT INTO users (id, firstname, lastname, email, gender, password, photo_user, created_at)
VALUES 
(1,'Marlon','Adams','orn.regan@example.net','male','2fe8b9bdcdd3c421a5fe284af744025e220e5a72',92,'2021-08-02 19:10:07'),
(2,'Florencio','Stamm','willa.hintz@example.org','female','d765e75c1640e20c79b4a6458b8d6a5572ea5135',80,'2021-05-31 20:24:55'),
(3,'Mara','Kemmer','deborah61@example.com','female','65643ab951ae7b670ce9f77999c98937606c3d13',55,'2021-01-22 04:03:54'),
(4,'Edwina','Roberts','zlockman@example.com','female','bbe2e9289f3f0c66f21104683c6c43451a9ca834',100,'2021-06-06 21:55:25'),
(5,'Dannie','Rohan','ashlee.toy@example.com','male','51df6b9a8487e270f50830a76d053117afe25e9e',22,'2021-07-12 08:10:46'),
(6,'Aurore','Collier','astiedemann@example.com','female','7799a4629e7b5ef6469353d92b170cb80cd3e24c',49,'2021-06-05 19:27:25'),
(7,'Josefina','Funk','sterling66@example.net','female','5044fff8246e6ad4ab8b42373477a82700b9f746',67,'2021-01-11 13:20:08'),
(8,'Maxine','Hoppe','kmohr@example.org','female','b2fc757536259dc3e267e0ee38585e76a3d1e5e8',20,'2021-05-27 03:33:41'),
(9,'Kevon','Larson','wendell.wiza@example.com','female','2cec35a7175f9b1de176c0071fd0b8f5ffcfa0d0',75,'2021-11-28 06:18:26'),
(10,'Erica','Ferry','gabe.berge@example.org','female','de367f031072abf7cf54892be4f0fbbc2ac1081c',24,'2021-02-23 12:17:37'),
(11,'Matilde','Mann','sharvey@example.com','female','26374b5c47ab78e47996ccbf33ea3aa00fca08c3',6,'2021-11-09 18:13:49'),
(12,'Addie','Jaskolski','von.barton@example.net','female','8f0dd93fab2d5b611c52f499249916e35ade7b2a',99,'2021-01-23 13:53:10'),
(13,'Osborne','Reichel','donny31@example.net','female','884ad09472c70270fb511faba78914db6eca1cc8',76,'2021-07-31 14:27:57'),
(14,'Flavie','Sauer','vaughn58@example.net','male','f66e18d46ee025ea607c9afe9d055244ef0f9598',98,'2021-11-10 13:43:10'),
(15,'Dennis','Donnelly','hudson.kendrick@example.org','female','85028d69fa83b48d6a0e7cf93e3cb4b9f1d67a4b',91,'2021-10-27 07:35:20'),
(16,'Neal','Maggio','elmo73@example.org','male','f9b7a1bf5f3cbf252037d08214a489f52fa05e90',94,'2021-05-07 03:59:42'),
(17,'Burnice','Reynolds','fprosacco@example.org','female','5675b5985ce2d99ade50988c12da8a2c2bdcfc99',33,'2021-10-10 12:17:48'),
(18,'Hassie','Pouros','ford.dibbert@example.org','male','dd9e619ff5d20e69a71b8d03eebf2fb10009ad84',25,'2021-09-18 13:00:26'),
(19,'Norberto','Dach','wisoky.eli@example.org','male','aee4718a7d13428b2c72c1f144c930b3a88c7885',68,'2021-04-27 18:39:09'),
(20,'Hector','Predovic','melany.muller@example.org','male','839b11c2fb1c334ebdf7319bd71327bf4dceb6f5',32,'2021-08-16 17:31:56'),
(21,'Narciso','Christiansen','sammy14@example.com','female','8134474f2a050691f827e36ada5dbc065b9e7aca',68,'2021-01-09 21:47:47'),
(22,'Gudrun','Fritsch','bins.serena@example.com','male','702a2524ea0028a21a7cf73a8d47a201a9bfd30f',49,'2021-07-03 15:00:47'),
(23,'Ophelia','Kunde','leonor.harvey@example.com','female','cb454ccf7f4ecd4116766a76d592bff9ff1772b8',64,'2021-12-27 19:17:37'),
(24,'Jena','Towne','tschuppe@example.org','male','5a305c9c2dc5c8da27752b1b9b7fb3b4419b0bf8',61,'2021-03-30 18:14:47'),
(25,'Lucienne','Runolfsdottir','elian.nitzsche@example.net','male','aae6b1b2c7e72e661ba2d072a8ed504326a0176f',29,'2021-08-15 12:35:09'),
(26,'Deion','Kilback','hwintheiser@example.net','male','84334615df0dd11185ba3b0a9c582546b0aa6579',61,'2021-08-13 00:07:10'),
(27,'Lorna','Swift','rodriguez.dewayne@example.org','male','2e016c4165c34d0487e928e2cc730ad24e1e5d6a',14,'2021-12-07 08:39:17'),
(28,'Curtis','Baumbach','marshall66@example.com','male','35740a7ec19a7ce4b80e4a4a033a2101827bf86f',19,'2021-02-23 04:02:17'),
(29,'Christine','Schroeder','denis.lind@example.com','female','aa043fed5114e31cdc3261172b2581d2b21c29be',74,'2021-07-01 11:50:00'),
(30,'Jailyn','Barrows','arne.thompson@example.com','male','1f7e5838de617cba9031db272d0d8d95c91abc96',11,'2021-09-16 00:13:25'),
(31,'Deja','Daugherty','vlehner@example.net','female','003d7a5100ca1761511fe12744acae450ef50ff0',88,'2021-11-17 12:00:48'),
(32,'Blake','Schmeler','queenie.mayert@example.com','female','9828d6ca671ebd144c61d3d33eb814e925ad19d1',13,'2021-08-19 03:05:10'),
(33,'Sandy','Smitham','wreynolds@example.com','female','6ef7e541fb25e498489ac2e88216d7c54ee65e63',78,'2021-08-27 07:50:48'),
(34,'Alexane','Marks','leora.hessel@example.com','female','ee95b47d4348c983e05e4a24a74e7bda0334eb31',26,'2021-10-27 22:10:03'),
(35,'Josh','Roob','orrin.hyatt@example.net','female','66df12df3e9984127629bbca3280fb1343982f5a',75,'2021-02-19 12:58:40'),
(36,'Kennith','Johnston','emard.ciara@example.net','female','a3347d00af1b51483b4e192c1f1ec58a87a9f3fa',65,'2021-03-09 06:14:12'),
(37,'Herbert','Schamberger','dana.morissette@example.net','female','9978247e119f1871440520f566da3cf7e4968f23',97,'2021-05-16 13:29:06'),
(38,'Pansy','Quitzon','freddie.mcglynn@example.com','male','e5256a5bce492194397fe45f46e9dc7365a27ac8',18,'2021-11-19 09:41:12'),
(39,'Maida','Batz','oboyer@example.com','male','050d3f3e36bf69c8152a752e0e99c773a7a9d292',99,'2021-03-03 13:29:23'),
(40,'Emelia','Ondricka','lmills@example.com','female','de80c3f042fdc355b635363cbe44dee97bad0604',100,'2021-12-02 04:02:20'),
(41,'Elian','Kub','wdavis@example.com','male','bb172ed0f2b822414fe323f98f797628690fa156',8,'2021-04-06 21:12:55'),
(42,'Diana','Macejkovic','boris.harris@example.net','male','83596e6f29e3042e122447f86601f61cd1d86499',75,'2021-03-12 18:56:55'),
(43,'Forrest','Leffler','gfeeney@example.net','male','35bd7d1ba81102cd798a1693d2ad3fbdf7ab489a',96,'2021-12-14 00:12:03'),
(44,'Keaton','Lowe','wilderman.alfreda@example.com','male','8c779a8eec744b731f1eaf032a34a72be0a95736',27,'2021-02-24 20:47:39'),
(45,'Federico','Larson','florence39@example.org','female','e7017466d53c8b38ed16bf3dcd6aca277db211e2',71,'2021-01-29 04:07:02'),
(46,'Tina','OKon','gertrude.willms@example.org','female','3de84e0c955be90a398a288a8cc2bfcdf7c8e54f',33,'2021-11-11 05:18:36'),
(47,'Aurelie','Morar','gbreitenberg@example.com','female','a77bbcee3df2c3f75f45347179ded095622ddfad',38,'2021-06-13 22:37:52'),
(48,'Jarred','Little','pouros.vallie@example.net','male','f8e53ee56e3135a44718da69bd8ae8013b45c140',79,'2021-09-29 07:34:09'),
(49,'Jade','Haley','rodriguez.rosalee@example.org','female','5f31e18beddc10225f5d545a2395d4397694063b',6,'2021-11-21 12:35:15'),
(50,'Michael','Sipes','bernadette.pfannerstill@example.com','female','1f651b2edab24dfa22d3663b7ac1a85a1bc25ed1',74,'2021-09-01 21:09:55'),
(51,'Yasmin','Howell','wkutch@example.net','female','ada27286bb9dd50ac73f22b8448ee0c234bf3bf4',66,'2021-01-28 15:53:52'),
(52,'Lucy','Towne','block.jerrod@example.org','male','b75b15133213e882861b0c74ffac14c3e298e86d',32,'2021-01-17 00:35:32'),
(53,'Lue','Rolfson','fpowlowski@example.com','male','b5306b8e42934bdad5f99fffa22e0c201ba79b00',45,'2021-01-14 02:46:37'),
(54,'Mollie','Swaniawski','kshlerin.katharina@example.org','female','bb1f48fdd10bce94cd3c14fad3b933cae783cb43',74,'2021-05-12 17:01:07'),
(55,'Lambert','Klein','schuster.neoma@example.net','male','64e5f3308fbadb832e277d75d0ce072f4a7575f3',23,'2021-01-18 19:56:12'),
(56,'Robbie','Koch','gerlach.stefanie@example.com','male','57611553b4ff745cb9b154cf0d451ff4258e283b',10,'2021-07-20 13:27:17'),
(57,'Abbey','Mraz','jany80@example.net','male','377819dd8540044436d2d065907850a6fc8c97f2',47,'2021-01-24 10:43:35'),
(58,'Arlie','Feil','madge.pacocha@example.org','female','7e159ddeea9e0762f6ed6f0b225078368a8f2596',76,'2021-02-04 09:42:46'),
(59,'Rita','OHara','pansy77@example.com','female','77cd345d271c6bebb46d8a0cafa1c7449af5c050',99,'2021-05-12 15:58:11'),
(60,'Chad','Marquardt','waelchi.dimitri@example.org','male','61cdbcc228eb76ad368a7ef262384a754aa75204',13,'2021-01-31 11:33:23'),
(61,'Santino','Haag','vsauer@example.com','male','b4eb6c19e4afb643870254e95125f9111ef5659f',8,'2021-04-22 05:24:25'),
(62,'Ken','Labadie','amira64@example.com','male','60e6121e9c209be531856ee5b21c8cca0e27b7c0',93,'2021-04-14 02:36:48'),
(63,'Manuel','Hoeger','kertzmann.godfrey@example.org','male','307d9d32d34ea20a0e6d125283cad8da78a04b2c',21,'2021-05-22 10:47:32'),
(64,'Edgar','Robel','ysteuber@example.net','female','2a3e2b07e557d39c0b3b484ef388331ca8c3e1fe',23,'2021-06-14 05:18:07'),
(65,'Newell','Jones','janelle01@example.net','female','f4078441a59091edaaedbc4cc302e1fefed956b2',18,'2021-01-14 02:02:18'),
(66,'Kayleigh','Hayes','arthur.rippin@example.com','female','3521bf058396a344d826e9e188b2da41e0e99bb0',87,'2021-10-04 12:50:14'),
(67,'Meagan','Reinger','hkihn@example.org','male','332bb71b8df9150e918380fb3bc34921f0b6cfa3',76,'2021-12-16 02:28:43'),
(68,'Daphne','Ratke','beatty.jimmie@example.org','male','0b08bfbc33d102fb94dd8c892d630198bdd59afd',93,'2021-10-29 12:12:05'),
(69,'Rebecca','Brakus','klindgren@example.net','male','a01a54ba509d2e212f34506e953bd17221b80bde',3,'2021-05-20 14:11:56'),
(70,'Katlynn','Lang','heidenreich.darrick@example.com','female','38ec51ae6029420e4fd212c83e1b7296f6580146',36,'2021-03-06 20:53:09'),
(71,'Odessa','Gleason','earnest43@example.net','female','240e4552b0707545cf801cac30dcf39a50468d9c',24,'2021-08-09 06:19:58'),
(72,'Juanita','Murphy','bella.ohara@example.com','female','fecb4458489cfb7604262a7aa51f3dc799d147e4',16,'2021-01-05 18:19:27'),
(73,'Jace','Deckow','geraldine.pagac@example.net','female','990d821b270980e195f82db490722eefb3d6e59e',40,'2021-06-13 18:43:15'),
(74,'Flossie','Cremin','idickens@example.net','female','8a8de481c811882e166e7f55935b4a2ed0e49ea5',36,'2021-03-18 20:19:32'),
(75,'Zetta','Greenholt','zanderson@example.org','female','27f22618f7cfb8f1843dcfa0b6131f56e009a8f6',32,'2021-01-02 10:17:22'),
(76,'Chauncey','Wolff','eloise45@example.org','male','2bca4013abbfd0ed14354438cb382bd86495ec3b',16,'2021-01-07 07:55:42'),
(77,'Hailie','Bednar','delpha.mitchell@example.com','female','59eab17d7f892c66645730407541e313c9b37df7',60,'2021-07-28 06:58:11'),
(78,'Jakob','Langosh','jdare@example.net','male','eff9bbb2086d589c47ae62173fd22c6d619c6f27',4,'2021-07-27 17:26:09'),
(79,'Wilmer','Volkman','harvey.leann@example.org','male','ae2685b0bf812415f48b7eba2d779d0cbb014940',49,'2021-04-24 12:55:28'),
(80,'Clinton','Feest','terrance.kuphal@example.com','male','4da1513bba207cef5019128f8721eda7f9f70dbd',43,'2021-11-29 12:39:09'),
(81,'Katelin','Rodriguez','alexa.schimmel@example.net','male','28b3d712a46305209da8b69c21115414b0922634',22,'2021-10-20 01:33:29'),
(82,'Jordyn','Roberts','twila.blanda@example.net','male','3f900a1b2cf1c5f9c228f9ec75c1727245234b08',97,'2021-07-01 17:13:16'),
(83,'Tillman','Bayer','muriel70@example.org','female','ec9e15aaa074588db7f69ab2eafc14e3444addd5',52,'2021-10-12 12:08:47'),
(84,'Stephen','Walter','ryan.jewell@example.org','female','120f49bb80ccecfd6bf96fa48df4a5f02da19ecd',24,'2021-03-20 08:48:11'),
(85,'Henriette','Nolan','katlyn.mayert@example.org','female','56d01dd4c1f076d75e25c52fec7190ede8280592',49,'2021-04-27 22:07:26'),
(86,'Ewald','Graham','isabelle82@example.com','male','35c806a37e45275000e48e0f4d0e3912f003a48d',33,'2021-11-12 13:33:03'),
(87,'Jamal','Renner','poreilly@example.net','female','7cc6da766d3b5c6dd7aa7fa476039a3091618746',94,'2021-09-27 20:19:54'),
(88,'Destin','Rogahn','immanuel.smith@example.org','male','59b5db1e6d3d5bddc4c3cb21923fe83e96875e7c',49,'2021-10-29 16:44:20'),
(89,'Dusty','Altenwerth','gunner48@example.com','male','2c9a12c11189898c5a5610412ccf53dca499c403',57,'2021-05-09 22:39:29'),
(90,'Coy','Ferry','laurie42@example.com','female','85da5f02124411ff930f1675b6ae346e75b0d98a',35,'2021-07-08 15:41:38'),
(91,'Mallory','Langosh','wrosenbaum@example.com','male','6ea5947c308f7e812c3d51116584f1af9de45f09',46,'2021-08-22 21:15:12'),
(92,'Ebony','Sipes','yolanda47@example.com','male','52c94f8e3741331a24e27d92488e9c77c07883c7',59,'2021-04-17 03:33:19'),
(93,'Ahmad','Watsica','aufderhar.concepcion@example.com','male','0e0ab544e9fe4c48b4bfa09a8b993a70f28077eb',73,'2021-10-26 02:26:41'),
(94,'Peyton','Bayer','mhalvorson@example.net','male','edfb71a9f1079d38944f2cb588f8576f0088305e',35,'2021-09-04 11:46:21'),
(95,'Dylan','Swaniawski','naomie87@example.org','male','34492290291cb37a16dd3c3c715996426fc7e2cc',70,'2021-02-12 03:01:32'),
(96,'Jaydon','Howe','harvey.ivah@example.com','male','09c799c12e9ec1f59aa348877203398362723b59',78,'2021-09-26 21:50:40'),
(97,'Antone','Keebler','xharris@example.org','female','ecebcab2e566ff6f7acaaf46d8e59f931cfc6572',51,'2021-09-29 18:41:09'),
(98,'Bill','Walsh','gillian99@example.org','male','4b7b036ccb80864664986969a907f9b25218a961',65,'2021-12-30 13:03:40'),
(99,'Karley','Zieme','william38@example.com','male','42c61dd93a2f4ff0d70aad4d911b1fd23a9df0f7',68,'2021-01-05 19:26:17'),
(100,'Duncan','Morar','mkshlerin@example.com','male','d4b762cd043de1927d7cca122fd7143d113173f4',33,'2021-08-06 19:42:45');

INSERT INTO addresses (id, user_id, country, city, street, home)
VALUES (1,87,'SouthCarolina','South Tyrellberg','Zella Ford','Apt. 716'),(2,9,'Vermont','Lake Karson','Kellie Valleys','Suite 615'),(3,88,'SouthDakota','Schoenchester','Grimes Grove','Suite 308'),(4,50,'Missouri','Robelland','Alexa Meadow','Apt. 877'),(5,56,'Maine','New Scottystad','Grady Stream','Suite 403'),(6,78,'SouthDakota','West Diegomouth','Bosco Pass','Apt. 914'),(7,10,'Colorado','Port Jaquelin','Hyatt Forges','Apt. 229'),(8,17,'SouthCarolina','Donnellyburgh','Kyla Centers','Apt. 964'),(9,31,'Idaho','West Jeromehaven','Murphy Meadows','Suite 009'),(10,20,'Idaho','Marceloton','Roxanne Island','Apt. 015'),(11,50,'Kentucky','South Rebekamouth','Cronin Street','Apt. 495'),(12,25,'Wisconsin','Port Diamond','Jast Ramp','Suite 848'),(13,47,'Mississippi','Metzshire','Amina Streets','Apt. 654'),(14,67,'Colorado','Kunzeborough','Sophia Prairie','Suite 084'),(15,26,'NorthDakota','Hartmannshire','Halvorson Street','Suite 243'),(16,21,'Kansas','Leannontown','Shaylee Cliff','Suite 107'),(17,61,'Iowa','Port Aniyahmouth','Bridie Coves','Suite 455'),(18,32,'Utah','Lulaton','Chanel Field','Suite 093'),(19,24,'NorthDakota','North Jimmymouth','Schamberger Isle','Apt. 358'),(20,54,'Nebraska','Kaelynborough','Rita Spurs','Suite 612'),(21,14,'Iowa','Keeblerstad','Walsh Junctions','Suite 092'),(22,34,'Montana','Toychester','Ivory Hill','Apt. 944'),(23,48,'Texas','Kilbackmouth','Lind Union','Apt. 847'),(24,73,'Vermont','East Laylaport','Wisoky Dam','Apt. 448'),(25,30,'Alaska','Edgardoburgh','Telly Extension','Apt. 965'),(26,94,'Alaska','New Melissaside','Kuphal Canyon','Apt. 042'),(27,43,'NorthCarolina','Lizaville','Nicolas Meadow','Apt. 872'),(28,98,'Mississippi','Mitchellshire','Stroman Views','Suite 642'),(29,29,'Washington','Myrtisport','Kailyn Ramp','Suite 166'),(30,69,'NorthDakota','Edwardshire','Jody Walk','Suite 464'),(31,69,'Nevada','Elwynmouth','Gleichner Motorway','Suite 819'),(32,42,'Montana','Wunschbury','Amanda Squares','Apt. 765'),(33,21,'RhodeIsland','Lake Alda','Erdman Pine','Suite 753'),(34,63,'Michigan','West Abbigailview','Joe Walk','Apt. 932'),(35,92,'Pennsylvania','Port Jodieport','Ryleigh Ways','Apt. 088'),(36,54,'RhodeIsland','North Georgiannashire','Fay Stream','Suite 673'),(37,43,'Oklahoma','South Gillian','Mraz Light','Apt. 511'),(38,31,'Connecticut','Millschester','Carmella Estates','Suite 975'),(39,51,'Indiana','Marciaport','Will Inlet','Apt. 420'),(40,21,'Wisconsin','Port Javier','Kovacek Streets','Apt. 854'),(41,1,'NewJersey','Quitzonmouth','Dooley Spring','Suite 781'),(42,24,'Kentucky','West Samantha','Borer Isle','Apt. 090'),(43,49,'NorthDakota','Lake Kalebborough','Buford Courts','Suite 615'),(44,22,'Florida','Trantowville','Maurice Viaduct','Apt. 091'),(45,44,'Missouri','Rueckerchester','Schneider Run','Apt. 529'),(46,91,'NewJersey','Shawnafurt','Abbott Lodge','Apt. 239'),(47,45,'Wisconsin','Hellerhaven','Domenick Radial','Suite 696'),(48,45,'Virginia','Davischester','Mariela Oval','Suite 965'),(49,99,'Louisiana','Wardmouth','Lolita Forge','Suite 911'),(50,30,'Vermont','North Rickey','Mariam Forge','Suite 823'),(51,45,'Maine','Lake Napoleon','Lelia Lake','Suite 712'),(52,37,'Idaho','Rickeyton','Ondricka Views','Apt. 608'),(53,80,'NewMexico','Meredithburgh','Timmy Streets','Suite 288'),(54,26,'Utah','Goyetteton','Willis Ports','Apt. 840'),(55,30,'Wisconsin','Willieshire','Walter Pine','Apt. 263'),(56,86,'NewYork','Adityaburgh','Beer Ports','Apt. 772'),(57,2,'NorthCarolina','Scarlettborough','Ernser Village','Apt. 404'),(58,7,'Vermont','Joanniemouth','Beatty Circles','Apt. 862'),(59,99,'Missouri','West Elyssa','Doyle Ports','Suite 469'),(60,1,'Oregon','Karleyfort','Jerad Turnpike','Suite 781'),(61,21,'SouthCarolina','Haleyburgh','Lindgren Club','Apt. 164'),(62,75,'Arizona','Koelpinmouth','Renner Flat','Suite 531'),(63,77,'Louisiana','New Glennie','Tromp Lake','Apt. 514'),(64,28,'Maine','Port Neoma','Gregoria Prairie','Apt. 303'),(65,65,'Utah','West Wiley','Von Pike','Apt. 800'),(66,13,'Idaho','Hilpertside','Pearline Village','Apt. 863'),(67,14,'Louisiana','Lewisshire','Kub Square','Apt. 738'),(68,55,'Oklahoma','Karolannborough','Magdalen Dam','Apt. 622'),(69,8,'Louisiana','East Lesly','McDermott Divide','Suite 396'),(70,80,'California','North Victor','Morar Light','Suite 817'),(71,66,'Indiana','Isadoremouth','Miller Shores','Apt. 881'),(72,41,'Nevada','North Julie','Lindgren Inlet','Suite 383'),(73,70,'Idaho','Runolfsdottirmouth','Koss Fork','Apt. 610'),(74,77,'Alaska','East Johnathan','Antwan Passage','Apt. 148'),(75,72,'Utah','Kunzemouth','Jessyca Lock','Apt. 083'),(76,6,'Colorado','Octaviaberg','Jody Corner','Suite 363'),(77,76,'Hawaii','Adrianahaven','Waelchi Island','Apt. 307'),(78,81,'Nebraska','Wizaton','Stokes Mews','Suite 721'),(79,70,'Massachusetts','Lake Nelletown','Runte Corners','Suite 962'),(80,100,'Nevada','Port Cecileland','Tara Vista','Suite 765'),(81,66,'Alaska','Gradyland','Veum Stream','Apt. 758'),(82,48,'Colorado','New Reynoldside','Dickinson Ridge','Apt. 340'),(83,85,'NewYork','Port Kathryn','Miller Springs','Apt. 500'),(84,16,'Colorado','Jakaylaport','Wisoky Highway','Suite 013'),(85,18,'Vermont','East Donaldborough','Roob Corner','Suite 282'),(86,66,'Arkansas','Gretabury','Stamm Throughway','Suite 806'),(87,6,'Nebraska','Hoegertown','Medhurst Ports','Apt. 603'),(88,36,'California','Malcolmton','Randal Stravenue','Suite 363'),(89,35,'Indiana','North Susana','Sarina Spring','Apt. 500'),(90,36,'Maryland','North Agustin','Demario Isle','Apt. 707'),(91,17,'Louisiana','Cooperton','Labadie Meadows','Apt. 202'),(92,92,'Illinois','Elinorberg','Kihn Fords','Suite 295'),(93,92,'Alabama','Dominicshire','Kub Spurs','Suite 533'),(94,54,'Utah','South Fredericfurt','Legros Points','Apt. 015'),(95,52,'Massachusetts','Harrisbury','Adelbert Vista','Suite 903'),(96,9,'SouthCarolina','New Athenamouth','Crystel Underpass','Suite 341'),(97,38,'Pennsylvania','Quigleystad','Stracke Parkway','Suite 360'),(98,7,'Vermont','South Anjaliborough','Satterfield Shoals','Suite 831'),(99,25,'Oklahoma','Lake Amiyachester','Dagmar Plains','Apt. 598'),(100,75,'Vermont','Kilbackchester','Amy Prairie','Suite 727');

INSERT INTO brand_names (id, name)
VALUES 
(1,'adidas'),
(2,'puma'),
(3,'opium'),
(4,'nike'),
(5,'vero'),
(6,'neque'),
(7,'tempore'),
(8,'voluptatem'),
(9,'consequatur'),
(10,'esse');

INSERT INTO categories (id, category)
VALUES 
(1,'men'),
(2,'women'),
(3,'kids'),
(4,'accesories');

INSERT INTO products (id, name_product, brand_id, category_id, description, price)
VALUES 
(1,'voluptas',1,3,'Sed a accusantium quia qui sequi autem cumque aut. Tempore explicabo et nulla debitis. Tenetur recusandae maxime ipsum ea molestias eos. Suscipit et ipsam eum occaecati velit incidunt.',68342),
(2,'quo',1,3,'Repellendus qui id reprehenderit qui. Eius quam totam architecto id doloremque.',40292),
(3,'distinctio',10,1,'Eligendi dolor sit aut. Omnis natus aut et odio autem quo id perspiciatis. In officia quis voluptas reiciendis natus atque mollitia quos. Neque earum officia harum.',47282),
(4,'dolores',10,2,'Sequi veritatis qui quae unde nesciunt et. Ipsam fuga hic optio voluptatem provident et aut voluptatem. Quod quia exercitationem et officiis quasi. Hic sed corrupti sapiente sed. Sunt nemo debitis aut natus illum provident.',74800),
(5,'voluptas',2,4,'Magni voluptatem sed velit. Beatae laboriosam temporibus fugit ratione sunt illo provident. Harum voluptate mollitia ea repellendus commodi sint. Qui dignissimos quo voluptatibus et mollitia harum neque.',44826),
(6,'repudiandae',7,4,'Voluptatem dolore eos sunt voluptatibus dolorem modi. Sequi minima ex totam dolorem impedit ipsum consequuntur. Libero occaecati distinctio cumque perspiciatis quidem doloremque eius ea.',33147),
(7,'labore',9,2,'Ipsum et voluptatem a repellat ut sed qui. Sit sit cum autem ab et tempore doloribus quia. Corrupti a quia velit quae dignissimos esse.',2574),
(8,'ex',3,3,'Dolorem amet doloremque quidem libero quos. Et officiis quisquam sint accusamus assumenda. Modi molestiae nemo omnis velit natus est.',75696),
(9,'officia',2,1,'Reprehenderit quia dolores accusamus non. Cupiditate omnis voluptas et natus reiciendis. Eligendi repellat fuga blanditiis.',93329),
(10,'earum',9,2,'Sed cumque modi sit rerum. Illo minima similique veniam qui molestiae non explicabo dolorem. Voluptatem qui laudantium sapiente vitae tempore architecto eveniet. Eos itaque assumenda officiis odio unde.',64048),
(11,'atque',8,1,'Magnam eligendi voluptatibus dolores doloribus eveniet. Et veniam voluptatem ut incidunt quia nobis. Officiis labore dignissimos velit soluta sunt impedit cumque itaque. Commodi voluptatem atque sint cumque debitis facilis libero.',1309),
(12,'laborum',4,3,'Voluptate accusantium voluptas velit et incidunt et doloremque dicta. Perspiciatis doloribus provident id debitis ut et. Dignissimos aut recusandae necessitatibus nisi placeat quis dolores.',7283),
(13,'dolore',5,1,'Voluptas quae quo est. Eligendi modi est laudantium aut non magnam asperiores. Molestias et consequatur voluptatem fuga nemo excepturi sit ratione. Nemo corporis laborum voluptatem quia.',161),
(14,'labore',2,2,'Consequatur aut impedit a harum. Adipisci culpa et ipsum tempora delectus tempore. Earum illo aperiam libero dicta molestias perspiciatis.',50800),
(15,'porro',6,4,'Illo molestiae quia rerum optio sint voluptatem. Rerum dolore quo soluta voluptas. Quaerat rem reprehenderit rerum sequi possimus sunt.',73800),
(16,'jacket',9,3,'Excepturi in aut architecto voluptas quis. Eos aut velit consequatur esse. Sapiente corrupti nesciunt iusto accusamus fugiat.',72150),
(17,'rerum',6,4,'Culpa veniam tempore odit quo rerum est officia nulla. Corporis molestias distinctio dolor repudiandae voluptatem aut. Commodi atque eligendi vitae ducimus qui ratione.',29970),
(18,'sed',3,1,'Dolorem odio quo totam quis autem aliquam. Error reprehenderit nam dolor sequi a velit vitae. Ea officia aut ullam nostrum blanditiis a. Quia et ex incidunt adipisci aut.',4066),
(19,'nesciunt',7,3,'Est vitae saepe ut ut corporis dolores sit. Et fuga dicta delectus ut. Et sit et ab aut voluptatibus veniam eos occaecati.',56590),
(20,'quo',8,1,'Voluptatem suscipit a quo qui ut. Quis deserunt quisquam amet amet aliquam eaque reiciendis. Consequuntur dolorem dignissimos tempora vel similique nihil. Neque cum aut praesentium sit et.',14666),
(21,'quis',8,3,'Veniam laudantium excepturi fugit. Non sed aut magnam quia. Sunt aliquam aut autem quia corrupti et non officiis.',75356),
(22,'cumque',6,4,'At reprehenderit similique exercitationem sit maxime eum. Iure velit occaecati libero vitae qui ad. Dolorum laudantium reiciendis sed temporibus.',29665),
(23,'veniam',8,1,'Nihil explicabo a similique magni. Iusto sit magni atque consequatur qui officiis. Esse nostrum quo quis hic.',200),
(24,'fugit',5,2,'Dolores ab in tempora quibusdam et omnis. Quis incidunt dolorem pariatur quis facilis. Omnis temporibus aut adipisci in eius corrupti. Magnam explicabo natus quidem quasi et.',26451),
(25,'beatae',8,4,'Harum optio ad quis sint delectus nisi aut. Aut facilis recusandae cumque ab tempora assumenda ut quos. Minus ex ipsa nemo esse ut.',200),
(26,'a',9,2,'Autem itaque qui dolores ea rem consectetur. Totam corporis nisi tempora porro. Error corporis beatae explicabo repellat magni facere eveniet.',33409),
(27,'reiciendis',1,1,'Velit odit saepe beatae necessitatibus vel. Inventore esse laudantium doloribus sit quae at mollitia labore. Omnis rerum autem animi facere.',16800),
(28,'debitis',3,2,'Velit ex inventore facilis libero. Ea velit ab inventore officia. Eos molestias totam nisi ratione illum eos. Quas ut deserunt laboriosam id recusandae ipsam sapiente voluptate.',82058),
(29,'eligendi',2,2,'Sunt similique harum aliquam rerum quia voluptatibus accusamus. Et aut nisi minus sit numquam. Aliquid fuga et est doloribus.',28126),
(30,'nihil',3,1,'Aspernatur eum suscipit id eum id est. Quam molestias nisi explicabo sed. Tempore recusandae qui minima nam. Quis itaque a omnis sit sit rerum. Aut perferendis nesciunt iusto et sunt qui.',1000),
(31,'tempore',5,4,'Voluptas atque praesentium consequatur harum nulla. Atque harum et voluptas facilis minus iure magni. Quas amet et non quos non consequuntur beatae.',4000),
(32,'ducimus',2,2,'Praesentium accusamus aut nostrum qui. Ea quo ullam quas asperiores earum debitis. Est aliquid dolores voluptate libero quaerat quis. Delectus at sit et nisi quia.',887),
(33,'et',8,4,'Et nisi veritatis et quaerat. Sed reprehenderit ipsa enim. Incidunt molestias dignissimos qui eveniet.',5808),
(34,'suscipit',3,1,'Voluptatem autem dolores sed autem sed repudiandae illum neque. Quaerat totam eaque nihil voluptate harum. Eos magni non fugit vero ea. Illo velit molestias odit quidem cumque magnam quidem.',140647),
(35,'blanditiis',7,4,'Ut expedita ad voluptatibus voluptates esse voluptatibus. Omnis iusto reiciendis dolorem fuga. Ut doloribus corrupti veritatis iste et dignissimos occaecati. Adipisci quia ut nihil aspernatur sed quibusdam. Eius doloremque quo sequi ullam eum qui quis.',6000),
(36,'aut',3,3,'In error eius mollitia itaque eos. Quia qui veritatis rem blanditiis distinctio vel sapiente voluptates. Earum distinctio aut qui delectus. Eum quidem fugiat numquam hic asperiores eum natus.',80503),
(37,'perferendis',9,3,'Laudantium aspernatur optio ducimus excepturi. Blanditiis aut repudiandae sit hic ut. Voluptatum consequatur occaecati deserunt aut sit aut. In recusandae molestiae odio ab vitae. Qui perspiciatis labore repudiandae officia voluptatem in sit.',2410),
(38,'ex',2,1,'Vel aut quia voluptatem totam asperiores facilis vitae. Autem ullam dolor esse inventore id.',16084),
(39,'illo',7,2,'Aspernatur aspernatur quibusdam alias voluptatem. Ratione aut occaecati consectetur ratione et itaque est. Ab est eius temporibus doloremque. Quis dolorem aliquam et ut consequatur.',52124),
(40,'quae',9,3,'Aut voluptas quia et eos non a. Est hic ad consectetur reprehenderit. Error odit dolorem debitis officia laborum. Et delectus nobis ut rerum provident dolor eveniet.',60150),
(41,'dolore',2,2,'Ipsum ut sed enim est in facere. Veniam qui voluptatem similique repellendus harum. Nihil et quo rerum a quaerat. Tempore voluptas delectus atque iste voluptas explicabo.',36270),
(42,'quia',4,1,'Accusantium ea inventore recusandae repellendus recusandae et. Cupiditate quasi quae similique iusto recusandae laboriosam ea. Doloremque similique quibusdam suscipit enim voluptatum nostrum. Mollitia officia occaecati a aliquid minus.',64442),
(43,'accusantium',7,3,'Iste rem laborum ut ratione ut odio qui. Saepe totam sed sunt et ea occaecati consequatur voluptas. Aliquid magnam totam soluta delectus eos quia quo. Porro accusamus fuga eligendi dolor accusantium amet.',723),
(44,'sint',6,1,'Magnam voluptatem rerum aspernatur ipsum rerum est. Mollitia occaecati et rem a sint est omnis. Quia non tempore architecto quam quos.',9290),
(45,'omnis',3,4,'Nobis vero fuga eos sed eos eligendi. Quia vel et necessitatibus. Cupiditate voluptatum delectus non. Quod ducimus sequi molestiae dicta. Consequatur velit deserunt expedita voluptatem fuga harum.',40100),
(46,'libero',5,4,'Labore cum eum ducimus quam recusandae aut. Quisquam impedit temporibus pariatur et modi est fuga. Dignissimos et repudiandae reiciendis ab. Libero quas non doloribus error aliquid veritatis.',8000),
(47,'architecto',5,4,'Minima quis perspiciatis quia nesciunt velit voluptatum recusandae impedit. Et aspernatur sit asperiores.Quo corrupti numquam dolorem aliquid alias. Rerum corporis accusamus vitae voluptatem et perspiciatis hic.',100),
(48,'repellendus',3,4,'Est nobis deleniti alias minima facilis illum inventore. Dolores sed qui omnis iure consequatur quia similique magni. Nihil ducimus voluptatem qui et delectus non ullam. Excepturi velit culpa quia cumque asperiores veritatis eum.',128),
(49,'molestiae',1,3,'Soluta sit odit doloremque illo autem aut. Autem consectetur optio fugit eos facilis omnis. Laborum facere sit dolorem et distinctio. Iusto sunt est vel natus quas.',4000),
(50,'saepe',9,2,'Ea blanditiis pariatur illum rerum temporibus. Vitae explicabo explicabo at consequatur nobis illum. Consectetur incidunt ex nostrum voluptatem sint fugiat voluptas architecto. Consequatur molestiae veniam qui ut similique.',19793),
(51,'aut',5,1,'Sunt et culpa fugiat quo doloribus. Eveniet non eum officia aut deleniti. Et facere illo cumque nulla eum. Eum consectetur quia quaerat voluptatem fugiat est.',2900),
(52,'qui',3,4,'Vitae et et illo ut dignissimos. Enim laudantium tenetur cumque ab molestias. Id autem occaecati error quis aut et. Aut deserunt impedit mollitia fugiat ipsum.',29380),
(53,'accusamus',8,2,'Est illo qui enim et ut nemo et fuga. Officia vero deleniti quibusdam quam. Excepturi ullam ex quo et est in quia. Velit quasi quia dolor et ut.',1740),
(54,'repudiandae',6,4,'Vitae aliquid quia magni repudiandae est. Ex eligendi enim enim. Laudantium officiis consequatur vero quia quia. Magnam veritatis laborum aut ut quos natus.',91420),
(55,'hic',4,3,'Aut a molestiae laborum hic vel. Ipsum adipisci dignissimos totam et assumenda qui. Veritatis ut quia esse aut.',4100),
(56,'laboriosam',2,3,'Eaque facilis deleniti tempora qui delectus modi est voluptatum. Nobis provident sit voluptas et repudiandae consequuntur. Esse omnis molestias ipsum consectetur.',8379),
(57,'voluptates',10,1,'Vel quasi sint quam tempore ea sequi quisquam. Repudiandae accusamus voluptatem at omnis dolorem. Asperiores aliquam accusamus eius et autem.',219),
(58,'et',5,2,'Delectus aut earum quia at et aut animi. Sapiente et dolorem aut quidem est incidunt. Itaque voluptatibus velit est rerum ut voluptatem magnam.',9000),
(59,'aspernatur',7,2,'Quod delectus est qui suscipit ut. Aliquid dignissimos quasi mollitia consequatur quo dolorem aperiam.',57498),
(60,'corporis',5,4,'Nisi aut incidunt beatae nostrum commodi sint. Aliquid quisquam perferendis incidunt distinctio reiciendis nostrum earum et. Eos quia culpa rem ducimus repellendus qui. Blanditiis nisi illum nihil necessitatibus sint possimus.',4000),
(61,'nobis',8,1,'Aut architecto est et et delectus suscipit delectus non. Ipsa inventore pariatur sequi consequatur enim. Optio sed earum quidem enim.',80131),
(62,'eum',8,3,'Ratione voluptatibus a iusto distinctio ea placeat. Consequuntur sed ut ullam provident. Mollitia exercitationem eum voluptas quos et occaecati.',1100),
(63,'tempora',7,1,'Nostrum quod voluptate eos veritatis dolor fugit. Esse quisquam quidem ipsam reiciendis debitis.',12680),
(64,'occaecati',8,4,'Soluta fugiat ut vero autem. Sunt aut ab qui quo consequatur. Repellat aliquam rerum illo a consectetur atque ea.',83600),
(65,'illo',10,3,'Ea sed qui recusandae temporibus et esse. Assumenda vitae perspiciatis et totam. Sapiente est quisquam ut et rerum libero. Neque eos quidem odio placeat recusandae reiciendis vero.',8302),
(66,'recusandae',10,2,'Fugit fugiat atque totam asperiores dolores asperiores voluptatum. Dolor qui quibusdam doloribus cumque. Aliquid voluptas hic sunt dolores quae doloremque ut. Dolorem eos fuga aut magni aut omnis molestias.',3690),
(67,'iure',4,4,'Ex officiis quo corrupti nulla soluta aut. Sed voluptatibus est enim blanditiis dolor enim iste. Nam autem quas dolorem nihil. Ut illo at quia numquam vero rerum voluptatibus voluptate.',8463),
(68,'praesentium',5,3,'Sapiente nam quasi non voluptatibus eum blanditiis voluptas. Earum omnis provident ut accusantium. Accusantium corporis asperiores voluptatibus. Ipsum maxime incidunt deserunt voluptates corporis expedita officia.',89713),
(69,'qui',10,3,'Iusto id non architecto consectetur nihil adipisci quaerat. Suscipit molestiae aut enim corrupti vel earum. Commodi magni cupiditate cupiditate.',30.00),
(70,'et',5,1,'Alias adipisci quam nisi molestias et optio ea. Et eum velit quis veritatis commodi. Harum eos quas numquam rerum.',70870),
(71,'dolorem',8,3,'Architecto consequuntur consequuntur totam et. Non sapiente eligendi quam sed quia praesentium hic in. Incidunt ut et dolores corporis ut blanditiis omnis dolor.',15273),
(72,'delectus',7,3,'Voluptas vitae exercitationem temporibus ut cupiditate. Tempora at ipsum aperiam. Architecto modi adipisci sit sed impedit.',8460),
(73,'itaque',8,4,'Aspernatur saepe nulla sit pariatur et illum. Iure consequatur ut aut perspiciatis inventore in. Magni modi dolorem est totam vero.',12004),
(74,'enim',5,4,'Dolore sequi ut distinctio explicabo non aspernatur. Voluptas vel ullam tempore consequatur libero. Reprehenderit est fuga id minima est.',27781),
(75,'ipsam',10,3,'Quibusdam voluptate soluta odio nam. Sint culpa ipsum est iste a consequatur. Et quaerat dolorem natus unde.',33347),
(76,'quis',9,4,'Praesentium assumenda sunt quos dolores. Rerum placeat perferendis quis quae tempore delectus. Animi unde minus aliquid omnis sequi quia eum.',13925),
(77,'minima',2,4,'Earum officiis sunt nulla quisquam id pariatur reiciendis. Fugit aliquid amet reprehenderit tempore iure aliquam molestiae. Esse laborum labore consequatur consequatur voluptatibus odio est. Et doloremque quis voluptatem tenetur.',9741),
(78,'nihil',10,1,'Quidem voluptate ea recusandae vel. Et sit dolorem adipisci. Earum inventore eligendi at. Voluptatem fugit velit eos quidem quisquam similique ipsam dolorem.',2000),
(79,'sapiente',2,3,'Eos odit rem nihil et natus unde hic. Et sapiente optio vero repellendus voluptatibus nostrum. Voluptatem error quas alias et magni.',17660),
(80,'voluptatem',3,4,'Consequatur veritatis saepe beatae facere doloribus unde non. Aut harum in animi quis. Qui asperiores aut sit rerum beatae quis.',9646),
(81,'magnam',7,1,'Accusantium temporibus officia incidunt et similique. Ipsum nemo et adipisci perferendis. Molestiae quia illo numquam eaque labore neque ipsum.',11089),
(82,'ullam',8,4,'Perspiciatis et molestiae et ut corporis illo. Ut veritatis non enim id corporis. Est eum odio voluptatem aliquam deleniti nobis sit. Rerum asperiores odio impedit possimus repellat.',39319),
(83,'velit',8,3,'Aut necessitatibus adipisci minima totam officia dolorum. Libero omnis exercitationem quas vel qui. Non asperiores iure id qui doloribus ea eum.',703),
(84,'voluptatem',9,2,'Excepturi maiores qui rerum non itaque accusantium. Dolor autem repellat cupiditate quas ut cum. Reiciendis incidunt adipisci vel autem. Inventore rerum sit voluptate dolorem sunt et. Repudiandae sed vitae voluptas quia non pariatur quisquam.',16400),
(85,'et',8,4,'Non illo tempora molestias. Facere dolore porro ducimus et ea. Possimus libero vitae ducimus commodi est.',29040),
(86,'ratione',9,1,'Assumenda a vero voluptatem distinctio. Facilis quo dignissimos error et.',322),
(87,'esse',5,4,'In corporis placeat debitis aut. Natus vero et omnis pariatur consequatur. Suscipit rem blanditiis quod sit error. Placeat libero enim odio.',6000),
(88,'laboriosam',6,4,'Sint doloribus at perspiciatis eum eaque sunt. Id a mollitia eius quia hic. Ea veritatis quia ex velit. Dolore aliquid et rem occaecati.',17275),
(89,'excepturi',6,3,'Quaerat quisquam totam quo sed quia ipsum voluptates totam. Aut sed molestiae ut cumque. Reprehenderit tenetur neque ea fuga. Cumque et nisi iste eius et.',279),
(90,'temporibus',7,4,'Esse quam mollitia earum minima. Odit perferendis sequi velit labore voluptate recusandae blanditiis. Ullam quis dolores cumque unde sit. Sint et qui est facere repudiandae perspiciatis in. Repudiandae et maxime velit dolorem eveniet praesentium.',7720),
(91,'blanditiis',4,4,'Quo laboriosam itaque tempora ea. Provident ut aspernatur sint vel molestias delectus. Dolore adipisci consequatur aut dicta. Dolore numquam quis modi eveniet odit.',5900),
(92,'animi',3,2,'Eum ut repellendus facilis sit aut quia. Similique aliquam vel exercitationem veniam. Rerum et esse quibusdam. Unde tenetur et perferendis natus deleniti quam voluptatem laudantium.',53860),
(93,'unde',5,4,'Porro quisquam vel quia dolorem quibusdam qui. Nulla autem reiciendis quod dolor.',2817),
(94,'consectetur',2,1,'Tempora impedit modi consequatur et sit. Odit sapiente impedit corporis ut qui. Ullam quo aut ducimus. Minus maxime nesciunt exercitationem nisi reiciendis aliquam dolore.',16094),
(95,'doloribus',7,1,'Fugiat minima quia dolorum voluptas sed fuga sequi. Velit omnis blanditiis consequatur optio totam ut porro. Et natus cumque illo aperiam quasi.',5539),
(96,'dicta',9,2,'Nihil dolor et sed nobis molestiae optio necessitatibus cum. Sed consequatur corrupti totam nisi sed ipsa aut. Id aspernatur asperiores facilis esse error. Asperiores sapiente ut tempora accusamus at quibusdam.',58040),
(97,'incidunt',10,4,'Veritatis voluptas consequatur sint corrupti dolor. Est est vero aut beatae quisquam dolorem. Culpa neque dolorum voluptas provident quis facilis quia qui.',59047),
(98,'sed',2,4,'Animi minus reprehenderit laboriosam enim error sed. Nobis aut iusto omnis totam repellendus. Cum quisquam nemo ut placeat et. Itaque repellat qui molestiae cupiditate aliquid.',2798),
(99,'fugiat',10,3,'Rerum quas velit architecto harum est. Quisquam tempore sed est. Omnis exercitationem sunt consequatur doloribus quia.',37526),
(100,'voluptas',6,3,'Totam nemo eaque aspernatur aut culpa aut quo. Ut nihil libero sit dolorem repellendus ipsam quia ex. Repudiandae ratione minus voluptates tempore. Tempore accusantium ratione distinctio deserunt excepturi laboriosam est architecto.',19770);

INSERT INTO product_sizes (id, sizes)
VALUES
(1,'XS'),
(2,'S'),
(3,'M'),
(4,'L'),
(5,'XL'),
(6,'XXL'),
(7,'XXXL'),
(8,'XXXXL');

INSERT INTO colors (id, color)
VALUES (1,'Beige'),(2,'Lavender'),(3,'DarkSlateGray'),(4,'PaleGoldenRod'),(5,'PowderBlue'),(6,'Cyan'),(7,'PaleGoldenRod'),(8,'Orange'),(9,'MediumSlateBlue'),(10,'Peru'),(11,'White'),(12,'GreenYellow'),(13,'WhiteSmoke'),(14,'DarkViolet'),(15,'Ivory'),(16,'Tan'),(17,'DimGray'),(18,'DarkBlue'),(19,'DimGray'),(20,'BlanchedAlmond');

INSERT INTO number_products (id, product_id, color_id, size_id, quantity)
VALUES (1,50,6,7,30),(2,61,3,1,20),(3,92,12,6,6),(4,94,6,2,3),(5,26,5,4,6),(6,85,6,5,23),(7,55,11,1,27),(8,90,3,5,8),(9,49,11,4,5),(10,1,9,3,23),(11,19,16,3,11),(12,48,19,1,4),(13,18,5,2,0),(14,22,17,6,21),(15,45,5,6,23),(16,24,2,4,11),(17,88,9,2,12),(18,7,13,6,4),(19,57,10,3,5),(20,96,2,6,5),(21,65,10,1,26),(22,79,14,4,14),(23,94,18,4,0),(24,72,16,3,10),(25,76,12,4,22),(26,50,5,3,1),(27,40,17,5,29),(28,83,7,4,27),(29,63,12,8,28),(30,100,9,2,22),(31,82,18,6,25),(32,13,6,1,22),(33,4,4,5,24),(34,72,17,2,17),(35,48,3,3,22),(36,14,17,6,1),(37,80,12,7,2),(38,41,19,4,27),(39,47,12,7,11),(40,38,14,4,7),(41,57,16,8,2),(42,54,20,6,7),(43,39,12,2,28),(44,98,14,4,7),(45,74,6,8,27),(46,53,7,6,27),(47,79,13,8,10),(48,36,4,3,1),(49,51,16,8,24),(50,44,6,2,4),(51,51,9,7,10),(52,87,10,2,27),(53,12,6,7,14),(54,93,10,7,27),(55,24,18,2,13),(56,51,18,3,7),(57,64,11,3,2),(58,85,7,6,15),(59,85,10,1,27),(60,71,17,4,18),(61,75,13,6,27),(62,89,7,5,30),(63,78,3,1,0),(64,1,3,6,18),(65,18,13,1,8),(66,77,11,3,23),(67,13,4,1,4),(68,68,14,3,23),(69,4,5,5,5),(70,93,11,8,21),(71,60,6,4,7),(72,90,7,4,19),(73,77,8,7,24),(74,97,6,3,29),(75,99,20,3,5),(76,35,8,6,11),(77,21,15,5,25),(78,19,3,4,26),(79,71,5,2,19),(80,7,17,3,25),(81,69,9,4,6),(82,91,8,5,24),(83,59,6,2,8),(84,1,12,3,6),(85,35,4,4,13),(86,61,9,3,19),(87,43,19,5,7),(88,9,4,7,27),(89,61,9,8,17),(90,15,16,1,10),(91,68,15,6,5),(92,56,12,4,8),(93,56,18,3,29),(94,96,12,3,16),(95,54,18,8,13),(96,3,18,7,4),(97,72,20,1,25),(98,85,14,7,21),(99,7,18,2,28),(100,79,4,4,28);

INSERT INTO photo_products (id, media_id, product_id, color_id)
VALUES (1,10,31,17),(2,35,93,7),(3,98,30,18),(4,40,29,1),(5,57,78,4),(6,54,31,2),(7,92,7,10),(8,39,3,9),(9,20,59,2),(10,29,78,11),(11,40,55,3),(12,39,16,19),(13,17,66,12),(14,6,34,20),(15,33,6,3),(16,90,88,17),(17,40,5,16),(18,79,65,8),(19,54,95,1),(20,97,9,6),(21,97,34,5),(22,2,51,17),(23,60,59,8),(24,93,65,9),(25,29,26,4),(26,85,10,2),(27,67,51,5),(28,80,57,20),(29,97,15,14),(30,33,45,9),(31,24,90,18),(32,5,31,9),(33,7,3,12),(34,30,92,14),(35,1,51,13),(36,92,24,4),(37,89,2,9),(38,68,25,2),(39,71,77,9),(40,78,93,14),(41,8,5,18),(42,63,77,5),(43,84,26,13),(44,74,73,15),(45,58,41,4),(46,16,58,18),(47,64,87,17),(48,68,96,13),(49,96,51,10),(50,47,76,11),(51,95,69,5),(52,50,32,20),(53,23,99,6),(54,59,73,5),(55,88,20,3),(56,5,16,11),(57,43,74,10),(58,78,47,8),(59,44,45,20),(60,50,9,9),(61,7,76,5),(62,75,19,17),(63,40,79,8),(64,47,87,19),(65,89,51,11),(66,45,43,7),(67,71,87,17),(68,57,97,11),(69,9,15,6),(70,97,62,7),(71,41,59,1),(72,60,63,1),(73,68,20,20),(74,3,61,4),(75,89,45,10),(76,76,90,15),(77,75,46,15),(78,12,92,14),(79,32,23,8),(80,44,7,20),(81,16,38,7),(82,81,6,4),(83,25,3,20),(84,98,95,9),(85,88,42,12),(86,45,42,8),(87,39,88,11),(88,53,43,15),(89,11,21,10),(90,10,16,20),(91,3,86,13),(92,95,63,9),(93,20,97,6),(94,37,47,4),(95,8,12,3),(96,11,95,17),(97,71,44,15),(98,25,59,3),(99,67,69,6),(100,44,39,17);

INSERT INTO orders_product (id, product_id, color_id, size_id, total)
VALUES (1,6,19,6,4),(2,25,11,5,1),(3,78,4,3,2),(4,40,15,3,1),(5,13,1,3,3),(6,91,12,8,2),(7,39,17,1,3),(8,39,12,6,1),(9,49,10,5,4),(10,96,10,8,1),(11,56,8,4,2),(12,63,9,7,2),(13,21,5,3,3),(14,48,11,3,1),(15,79,16,3,2),(16,71,6,1,4),(17,68,4,3,3),(18,70,9,1,4),(19,57,17,7,4),(20,15,1,8,3),(21,38,14,5,3),(22,23,12,1,3),(23,93,11,7,2),(24,71,8,2,4),(25,34,1,5,3),(26,96,10,6,2),(27,44,8,1,3),(28,93,14,8,4),(29,39,19,5,2),(30,86,15,6,3),(31,62,14,5,1),(32,71,1,7,1),(33,19,2,5,3),(34,64,8,8,3),(35,79,6,8,1),(36,53,17,8,4),(37,36,20,6,1),(38,88,18,3,1),(39,37,13,8,1),(40,87,11,5,3),(41,86,17,5,4),(42,12,16,8,2),(43,42,8,5,1),(44,65,2,5,4),(45,69,8,2,1),(46,20,6,4,3),(47,22,16,4,1),(48,97,5,3,1),(49,73,7,5,4),(50,35,9,8,1),(51,100,8,8,1),(52,16,11,5,3),(53,70,9,3,3),(54,37,14,3,4),(55,92,20,6,3),(56,68,10,6,4),(57,34,12,3,2),(58,61,1,8,3),(59,33,2,8,1),(60,95,4,7,1),(61,24,7,7,1),(62,48,16,7,2),(63,75,16,7,4),(64,94,16,8,1),(65,18,19,5,4),(66,84,13,3,1),(67,49,2,8,2),(68,24,16,2,4),(69,34,16,4,3),(70,14,20,4,4),(71,26,13,7,1),(72,14,10,6,3),(73,56,9,2,3),(74,11,10,1,2),(75,71,1,5,3),(76,6,15,6,4),(77,14,20,3,1),(78,84,15,4,3),(79,3,10,4,1),(80,29,20,4,4),(81,12,10,2,2),(82,97,1,2,3),(83,39,20,6,4),(84,94,19,6,1),(85,56,8,8,4),(86,38,8,8,2),(87,74,6,4,2),(88,39,17,4,3),(89,50,11,2,1),(90,77,13,1,1),(91,37,15,1,2),(92,23,3,1,1),(93,98,2,6,2),(94,62,7,1,2),(95,15,3,4,1),(96,3,6,8,3),(97,32,11,7,3),(98,96,7,2,1),(99,72,5,6,4),(100,79,7,7,2);

INSERT INTO orders (id, user_id, order_product_id, address_id, created_at, updated_at)
VALUES (1,58,88,34,'2021-01-08 03:34:23','2021-01-15 20:14:00'),(2,85,93,98,'1973-11-28 22:14:02','1978-11-28 15:33:07'),(3,46,36,1,'1973-07-19 08:22:51','1975-06-05 09:57:19'),(4,83,44,38,'1994-02-05 01:06:34','1987-03-30 16:00:32'),(5,23,88,16,'2019-12-15 16:24:08','1998-01-30 21:08:16'),(6,48,50,79,'1986-03-04 00:45:28','1970-03-13 01:59:03'),(7,86,46,27,'2014-02-17 21:40:00','1977-03-23 11:13:46'),(8,54,84,37,'2014-03-25 11:20:50','2008-01-04 14:35:10'),(9,52,12,17,'1984-12-17 16:18:54','1970-05-06 18:37:56'),(10,80,52,58,'1971-03-04 00:42:18','1976-12-19 18:20:51'),(11,12,26,71,'1989-11-03 08:17:24','1975-06-14 17:15:08'),(12,98,73,82,'2003-09-12 02:56:30','1972-07-19 02:26:59'),(13,50,74,27,'1972-01-28 03:23:48','2011-03-09 03:06:18'),(14,59,3,55,'1973-02-07 22:10:01','1970-11-03 12:06:29'),(15,78,70,23,'1987-02-16 04:17:34','1974-10-22 02:09:39'),(16,92,47,83,'2004-02-26 10:33:37','1992-09-09 15:29:12'),(17,26,97,87,'2000-07-20 22:30:53','1972-07-29 16:56:30'),(18,65,82,44,'2020-10-31 02:34:01','2001-02-01 00:08:15'),(19,7,48,15,'1999-05-12 11:25:09','1986-12-21 09:03:50'),(20,84,32,80,'1988-11-11 12:38:09','1990-09-22 22:55:05'),(21,41,5,7,'2021-03-12 18:42:28','2020-05-04 23:31:22'),(22,1,50,75,'1988-02-26 07:32:21','1995-09-05 18:49:54'),(23,20,93,29,'1972-03-22 02:06:55','1996-02-27 16:44:50'),(24,15,95,82,'2008-12-06 06:17:24','1977-01-08 01:04:30'),(25,67,26,95,'2018-05-03 02:45:53','1971-04-16 17:03:31'),(26,3,27,40,'1973-08-10 10:51:34','2005-01-18 10:28:13'),(27,5,63,71,'1982-11-06 22:51:01','2018-07-26 16:45:34'),(28,69,84,61,'2003-09-06 14:38:09','1999-01-05 21:50:32'),(29,58,27,98,'2015-05-12 21:38:03','2020-09-05 15:16:24'),(30,90,81,5,'2000-09-25 10:45:02','2017-09-30 18:10:33'),(31,14,47,7,'2008-12-26 20:29:37','2005-10-29 08:43:32'),(32,32,89,76,'2013-03-25 16:28:51','1985-04-27 02:17:01'),(33,29,4,31,'1973-05-24 13:41:50','1983-07-09 14:18:14'),(34,36,76,39,'2018-11-12 18:32:50','1983-10-11 17:20:32'),(35,42,78,11,'1999-12-25 15:30:19','1989-03-24 14:20:05'),(36,5,61,21,'1986-12-05 05:59:30','2017-09-08 01:28:56'),(37,85,56,38,'1981-02-07 05:16:02','1992-04-03 16:21:55'),(38,11,62,4,'2000-08-05 05:06:12','2010-02-10 03:54:43'),(39,48,31,19,'1992-04-21 16:43:02','2009-01-10 17:12:44'),(40,81,74,71,'2008-11-13 04:41:22','1973-11-15 14:04:14'),(41,68,26,12,'1998-01-13 13:48:04','2010-11-19 04:57:26'),(42,98,16,41,'1971-06-16 02:43:42','2016-08-15 05:02:07'),(43,22,56,30,'1997-09-25 10:56:37','2018-11-11 21:02:54'),(44,78,54,19,'1994-04-10 21:13:22','1982-07-02 16:59:21'),(45,13,74,22,'1982-09-03 10:02:35','1986-11-27 12:28:23'),(46,73,86,28,'1985-09-16 01:13:45','2008-07-18 12:23:35'),(47,47,56,55,'1979-05-23 04:39:02','2015-10-02 22:51:44'),(48,88,93,15,'1984-03-12 13:02:14','2011-10-23 08:46:50'),(49,42,42,63,'2021-10-20 02:27:30','2008-08-16 06:51:33'),(50,55,11,89,'2020-02-24 13:25:06','1987-01-22 12:44:54'),(51,57,64,10,'2005-12-14 22:47:24','1990-01-24 03:31:35'),(52,76,55,48,'2007-07-14 09:43:23','1988-04-05 12:46:03'),(53,15,66,15,'1996-11-15 14:32:09','1983-03-06 00:57:27'),(54,45,44,68,'2012-09-16 23:30:49','1998-06-22 12:17:49'),(55,52,100,38,'2009-02-09 13:15:59','1991-09-19 11:38:52'),(56,22,38,9,'1975-09-08 22:01:41','1997-10-08 15:35:46'),(57,52,7,65,'1990-10-26 16:21:15','1998-03-06 09:12:17'),(58,3,15,21,'1975-10-12 13:43:39','2006-10-30 07:30:45'),(59,64,18,25,'2003-10-30 20:15:50','1989-08-24 13:47:12'),(60,89,12,15,'2001-09-25 02:03:18','1983-11-17 11:18:49'),(61,30,100,5,'1994-02-28 10:08:40','1976-06-27 11:07:05'),(62,51,94,17,'1998-09-16 12:26:03','2008-11-12 23:56:50'),(63,67,99,65,'2011-12-22 06:58:19','2016-07-18 12:08:26'),(64,47,15,50,'1990-08-21 18:12:06','2003-12-02 16:16:23'),(65,58,22,75,'2015-06-13 09:56:22','2005-02-18 19:37:31'),(66,97,70,37,'2013-02-23 03:05:40','2007-05-10 01:14:42'),(67,52,85,90,'1998-11-09 11:36:51','1980-02-09 13:44:57'),(68,68,15,73,'1979-09-11 06:22:20','1995-11-27 07:08:05'),(69,94,14,48,'2001-05-18 05:35:03','1981-08-25 03:50:01'),(70,39,92,73,'1974-10-09 09:05:02','2016-04-23 09:25:48'),(71,59,15,37,'1982-06-09 21:39:40','2014-12-27 06:11:15'),(72,18,97,69,'2003-04-21 20:04:59','1998-05-23 00:39:25'),(73,29,45,84,'1983-04-28 10:53:51','1976-04-23 04:21:16'),(74,13,23,9,'1971-11-24 04:30:43','1974-01-12 08:27:27'),(75,51,92,54,'1971-02-04 16:49:50','1972-01-05 23:01:08'),(76,90,43,73,'2008-02-13 09:14:21','1977-11-09 14:02:46'),(77,99,7,85,'1973-12-30 22:30:22','1985-11-02 09:54:27'),(78,31,36,97,'2000-06-04 10:24:33','2005-03-25 01:41:45'),(79,11,2,55,'2007-08-22 12:52:43','2020-07-09 11:38:05'),(80,46,59,1,'1986-01-26 10:59:21','1993-04-28 20:40:07'),(81,97,27,47,'2014-11-22 07:04:46','2018-04-25 21:15:14'),(82,93,92,36,'2016-04-29 02:55:55','2007-10-11 00:16:01'),(83,38,98,89,'2007-12-14 15:52:23','1997-12-26 23:31:57'),(84,92,45,72,'1971-01-13 20:33:37','2000-11-03 08:01:40'),(85,14,46,84,'2019-12-01 08:16:59','1993-12-13 17:06:03'),(86,93,33,26,'1981-03-31 09:48:06','1974-12-10 14:07:02'),(87,17,28,47,'1985-06-08 14:08:41','1985-12-15 20:31:30'),(88,45,26,86,'1995-08-09 19:19:30','2011-07-09 17:21:52'),(89,71,24,59,'1988-11-24 08:21:20','1980-07-26 16:05:38'),(90,66,46,92,'1982-06-13 23:37:01','2013-05-17 01:33:22'),(91,62,5,75,'1988-07-17 04:31:40','2005-07-10 02:39:32'),(92,98,72,48,'2014-05-05 01:22:12','1979-05-31 14:04:48'),(93,52,48,7,'1975-05-07 14:40:48','1986-12-20 13:03:53'),(94,47,1,24,'1985-07-25 09:09:17','1972-07-18 13:01:23'),(95,93,30,27,'1976-11-14 17:16:36','1974-05-28 17:00:37'),(96,97,84,38,'2007-02-27 07:37:39','2021-02-20 00:04:50'),(97,19,53,80,'1973-08-20 07:58:21','1992-09-19 21:37:21'),(98,52,59,99,'1988-02-27 13:20:19','1988-02-22 16:23:51'),(99,85,23,21,'1981-10-16 16:19:39','1992-05-03 23:44:04'),(100,58,99,34,'1981-01-03 13:46:27','2011-09-24 04:10:54');

INSERT INTO reviews_shop (id, user_id, body, created_at, updated_at)
VALUES (1,69,'Placeat et consequatur vel vel qui eum amet. Ut sunt omnis expedita repudiandae. Nulla ipsam recusandae praesentium magni provident ullam in perferendis. Ut id corporis quasi sed.','1998-05-12 22:31:27','2016-07-17 21:52:57'),(2,77,'Provident at mollitia eos est beatae et nihil et. Perspiciatis ullam qui impedit sed temporibus aliquid omnis quia. Laboriosam quisquam eos vel omnis recusandae aliquid. Corrupti qui et voluptatem nobis voluptates provident rem.','1975-02-05 17:14:03','1996-08-20 20:43:25'),(3,24,'Dolor ex consequatur omnis pariatur ut est nihil. Ullam odio ex impedit totam sit quia at aspernatur. Vel magnam maiores facilis minus. Omnis facere laudantium dolores optio dolores.','1979-10-21 19:33:43','1981-09-02 05:57:33'),(4,79,'Tenetur atque provident hic omnis quos deserunt. Et eos autem quae occaecati alias. In velit magnam aspernatur.','1976-07-13 12:16:16','1982-12-19 09:02:30'),(5,39,'Debitis inventore praesentium magni error corporis perspiciatis. Dignissimos tenetur explicabo est sed cumque quia harum. Omnis aut adipisci possimus voluptatem voluptatem. Delectus perspiciatis ut quod voluptatem quam.','1993-10-08 08:17:45','2004-03-07 06:14:11'),(6,1,'Sint delectus porro excepturi esse. Nihil sed ut fugit autem.','1980-05-29 02:54:09','1987-09-30 22:01:08'),(7,75,'Illum ut earum nam voluptates. Aut et eos nobis minima. Nam culpa beatae architecto debitis saepe aperiam eius.','1980-04-13 18:00:59','2016-09-22 07:18:56'),(8,58,'Blanditiis est quaerat facilis unde. Mollitia quaerat hic id sed sequi. Fugit deserunt qui ut libero eveniet sed alias eum.','1991-04-05 06:24:59','2001-01-29 21:54:45'),(9,94,'Et asperiores molestiae occaecati illum dolor et minus. Sequi voluptas sequi rerum perspiciatis consectetur et. Dolores rem similique reiciendis doloribus veniam dolorem voluptatem. Alias quis quia aut voluptatibus.','1977-03-19 08:22:07','1999-07-06 14:01:27'),(10,100,'Odio mollitia odit autem aut ab. In dignissimos doloremque voluptate. Porro ut dolorem tempore temporibus culpa pariatur eligendi.','2005-05-12 09:52:25','1997-05-24 18:55:21'),(11,47,'Aut eos aliquam ex cum quod est. Tempore nisi quos suscipit est autem aspernatur aspernatur.','1999-11-24 04:15:32','1998-08-05 08:42:47'),(12,37,'Nihil dolor tenetur non necessitatibus rem. Nihil expedita eos at. Nesciunt quod non quibusdam fugiat magnam dolorum qui molestiae.','1983-04-02 23:06:01','1985-08-20 04:29:22'),(13,56,'Illo nesciunt temporibus itaque nobis iure sed voluptas. Sequi iusto minima eveniet consequuntur doloremque quibusdam. Veniam consequuntur maxime officiis vel dolor. Quo neque magni possimus minima est et voluptatibus ratione.','2002-06-13 08:10:54','1971-07-24 02:28:33'),(14,48,'Impedit tempora non dolor voluptatum odit. Est possimus quasi quia repellendus enim assumenda quas. Modi repellendus occaecati quia molestias aut voluptates voluptate quia.','1981-06-12 23:59:09','2003-09-18 22:17:14'),(15,95,'At earum voluptatibus eaque molestiae. Corrupti sit qui earum non ea sit impedit perferendis.','1986-10-20 09:39:08','1978-04-17 06:48:21'),(16,59,'Ea praesentium officia ut. Et ut excepturi esse quos odit quia mollitia sapiente. Dolore eveniet odit laudantium voluptatem.','1984-06-15 12:01:23','1970-05-11 19:46:17'),(17,22,'Cum rerum aut ut corrupti nemo eum. Id accusantium cum consequatur et.','1970-12-25 13:00:47','1983-03-17 04:28:56'),(18,45,'Quia vel in itaque iusto officiis laboriosam natus. Rerum incidunt officiis earum beatae quibusdam a.','2008-03-29 05:50:11','1997-06-24 16:39:16'),(19,42,'Vero nam nulla in voluptate illum magnam. Sint nulla nesciunt et quia aut et. Ad nemo optio sunt ea dolorum fugit. Dolorum voluptatem vel voluptatem aliquid.','1995-04-25 13:58:13','2010-06-05 23:35:48'),(20,24,'Aut esse quia consequuntur laborum voluptas. Inventore quaerat illum itaque provident sit assumenda ipsum. Eum exercitationem ab repellendus quia et fugit.','2005-10-30 07:22:58','1974-08-14 09:25:46'),(21,9,'Quis hic aut voluptatem deleniti voluptatem. Et ut aut est id cupiditate aut qui. Assumenda laboriosam harum sed aut debitis libero. Ad omnis voluptatem odit velit accusamus.','2008-10-20 06:48:26','2012-11-06 15:50:04'),(22,41,'Quia eos corporis mollitia expedita. Ut maxime consequatur laudantium et voluptatem. Sint iste ut quidem debitis quos et.','2009-09-25 23:34:02','2013-05-04 07:49:28'),(23,11,'Blanditiis perspiciatis omnis impedit magnam eaque. Ea neque quod accusamus itaque. Ut voluptas enim natus et esse consequatur.','1976-09-18 07:23:02','1970-07-23 05:47:47'),(24,66,'Dolorum non magnam dolorum dignissimos quidem necessitatibus. Unde doloremque odit praesentium provident eligendi non cum. Perspiciatis velit nemo ipsa vel quis a accusantium qui. Tenetur facere debitis qui provident voluptatibus qui omnis.','2012-12-22 02:24:24','1973-06-15 03:35:20'),(25,66,'Provident beatae necessitatibus aut ipsum voluptas rerum. Neque et quae totam aliquam eos in quo. Sed consequuntur dolorem architecto eos error. Et nostrum sint architecto hic placeat est qui dignissimos.','2003-12-02 23:07:09','2019-05-19 00:43:36'),(26,64,'Officiis iusto modi earum natus. Voluptatem quibusdam quibusdam laborum quasi adipisci eum.','1979-05-16 17:44:34','2020-04-27 00:28:41'),(27,27,'Optio eum dolore eveniet voluptatem sunt. Qui aperiam suscipit id ea itaque et. Corrupti odit quis tempore dolores nemo. Ut qui tempora aut sapiente doloribus.','1999-09-20 14:36:21','2003-07-01 03:53:54'),(28,87,'Id id fugit eligendi quisquam ipsam. Tempore nam sequi vel eos. Est perspiciatis vitae fugiat id dolore qui non quia.','1993-03-07 23:44:01','2000-07-13 11:58:52'),(29,34,'At unde cumque ipsum. Molestias aut nobis qui vel ipsum tempora qui alias. Blanditiis vel exercitationem voluptate et et. Aut tempore velit quasi vel repudiandae consequatur ipsum.','1982-02-11 10:15:05','1977-04-14 13:24:39'),(30,37,'Nihil sint non quibusdam dolor facilis. Eveniet sed aliquam accusamus. Maiores aut fugit qui reiciendis voluptas reprehenderit repellendus recusandae. Numquam modi numquam voluptatem ab.','2018-02-26 12:33:06','2015-06-01 22:03:12'),(31,73,'Qui voluptas nobis sunt non atque ducimus. Commodi veniam quibusdam optio numquam. Quisquam dignissimos cum nesciunt fugit asperiores.','1984-06-27 15:20:30','1970-04-18 15:41:55'),(32,65,'Quia commodi eos quia et atque. Nostrum voluptatem nihil qui iusto. Repudiandae qui aspernatur natus dolorem sit eveniet. Placeat velit minus magnam est. Est temporibus sint quo possimus dolorem distinctio.','1984-02-03 09:15:00','1990-06-30 14:47:45'),(33,12,'Quo soluta ut beatae dolores est aut et. Optio dolore fugit molestias accusamus doloremque nisi asperiores. Et id ipsum aut pariatur suscipit quas.','2020-06-04 02:46:14','1986-12-24 00:32:28'),(34,22,'Enim quaerat maxime in vel accusantium omnis eos. Architecto sed iusto molestiae placeat. Nihil dolorem sit laudantium. Aut quod aut labore suscipit.','1976-03-04 11:43:29','1974-12-07 05:57:50'),(35,65,'Repellat tenetur veniam ab ab iusto non. Praesentium voluptatibus vitae earum mollitia.','2014-02-04 08:01:34','1983-02-15 12:11:50'),(36,69,'Cum labore et blanditiis incidunt perferendis natus aliquam. Voluptatibus qui necessitatibus et omnis numquam consequatur. Quo id non et odit quis dolor libero. Explicabo ipsum dignissimos ullam et architecto ipsum.','2003-03-26 18:06:29','1970-07-07 20:13:44'),(37,17,'Dolorem consequuntur voluptas doloribus facere blanditiis. Ea quia necessitatibus ut voluptatem rem nostrum eius. Deserunt et dolores nobis sunt. Fuga consequatur hic tempora.','2005-05-20 17:50:14','2008-08-03 22:50:32'),(38,22,'Nam dolores rerum rerum iusto esse qui aut. Autem animi perferendis beatae voluptas impedit voluptatem et. Accusamus itaque soluta ipsam facere atque. Ut dolorem iusto aperiam ipsum incidunt eveniet.','2013-12-19 08:51:58','1997-12-05 14:28:56'),(39,84,'Est in consequatur velit dolores nihil. Deserunt est eos architecto dolorum laboriosam corporis. Maiores consequatur sequi inventore cum.','2003-11-10 17:25:32','2004-04-05 02:05:48'),(40,92,'Cumque aut dolorum nisi et. Minima nesciunt laboriosam et veritatis sed ducimus aperiam quia. Pariatur temporibus eos illum architecto voluptates quia impedit.','2019-06-27 19:45:12','2016-06-01 05:16:12'),(41,6,'Ut quis pariatur et temporibus qui cum hic. Dignissimos iste porro voluptatem rerum amet. Fugiat debitis fugit cum mollitia hic delectus ut.','2008-12-19 01:37:29','1972-11-28 02:36:14'),(42,59,'Nam ut earum ullam corporis. Qui et ut rerum omnis. Sequi dolores perferendis culpa quis consectetur quibusdam sed repudiandae.','2018-07-12 20:43:26','1988-05-29 14:37:23'),(43,24,'Molestias tenetur a quos magnam minus provident. Nisi dicta laborum quas. Veritatis dolore incidunt dignissimos amet laborum. Deleniti et non et esse aut fugit.','1990-07-26 02:21:00','1971-03-09 03:03:38'),(44,6,'Voluptatem sunt exercitationem esse sint est animi dolores. Molestias corporis aperiam quia odit. Rem expedita omnis officiis nesciunt quos fugit fuga.','1999-11-13 08:02:54','1997-12-19 13:23:49'),(45,83,'Voluptatem qui placeat ipsam aut reiciendis. Omnis odio ea perferendis quam animi vel. Dolor neque placeat quos ipsa ut rem eligendi.','1994-04-13 12:11:39','2017-09-08 15:35:45'),(46,83,'Qui laudantium sit ut modi unde. Cupiditate eum numquam qui et animi. Veritatis sunt cum dicta aut.','1971-01-15 03:40:49','1974-11-25 14:44:21'),(47,40,'Enim dicta dolorum dignissimos necessitatibus. Voluptatem quas quis omnis. Porro accusamus unde quos eum voluptatem eum.','1979-03-18 17:26:00','1997-01-02 17:19:42'),(48,65,'Libero amet quis sunt quas consequatur quos. Rerum velit eum ut voluptatibus sit est mollitia. Maiores vero esse similique qui. Architecto et et quia officiis qui.','2008-02-12 23:49:52','2020-12-22 06:22:47'),(49,92,'Aut voluptatem provident iure veniam aut consequatur. Qui id deleniti in. Amet numquam nulla illum non magnam unde. Nihil omnis qui qui quia dolorum.','2004-11-21 11:55:52','2020-01-31 18:44:17'),(50,23,'Et earum libero sunt. Et dolorum eos quasi velit. Quaerat laudantium deleniti quaerat aliquam et qui eligendi.','2021-08-14 02:29:36','1972-08-03 05:34:57'),(51,55,'Incidunt similique voluptas saepe doloremque culpa qui sit. Fuga quod inventore necessitatibus rerum quia qui nihil. Et et beatae ad veritatis dolore sapiente rerum. Neque deleniti qui ut et. Quibusdam voluptatem adipisci natus ea consequatur corrupti.','2016-05-17 10:44:45','1994-09-20 23:52:44'),(52,65,'Quia eos ratione accusantium. Maxime qui eum tempore omnis.','1999-08-27 03:34:36','1971-12-24 17:51:44'),(53,16,'Molestias et odit voluptates. Optio iusto vitae minima eaque voluptatem quos est quisquam. Voluptatem culpa nobis dolor sunt. Voluptatum illo non vero saepe.','1999-07-10 13:14:30','2008-11-13 01:39:19'),(54,20,'Ex ut dolores architecto voluptatem. Et quia deleniti omnis dolores quo deserunt consequatur consequuntur. Dolores odio quam similique ut animi.','2005-08-23 06:27:32','2009-04-24 03:03:57'),(55,45,'Facilis assumenda quia impedit rerum sint sunt laborum. Quos ab sint eos possimus quis officia. Hic neque nesciunt excepturi quo aut et suscipit.','2021-06-11 21:50:46','1983-02-21 08:23:04'),(56,75,'Corrupti rem sed doloremque ut. Adipisci incidunt quos ullam ut. Id impedit dolorem incidunt aut ducimus atque quidem.','1985-01-27 20:40:12','1982-03-16 11:11:56'),(57,34,'Fuga id ipsum cupiditate eius inventore voluptatem. Quis quisquam exercitationem enim et qui non aut. Et dolorem quo ducimus minima facilis.','2013-09-14 21:40:35','1995-02-21 09:18:16'),(58,13,'Eos dolorum voluptatibus voluptatem harum vel ex accusamus. Ipsa quas aut laborum quidem.','1977-02-16 23:28:43','1983-08-26 11:25:06'),(59,15,'Eveniet blanditiis explicabo tempora et ut. Enim velit assumenda inventore. Non suscipit voluptate quae omnis et quod libero.','1995-05-09 06:47:39','1976-03-03 05:04:23'),(60,29,'Consequatur voluptatibus omnis ut maiores neque cumque voluptatum cupiditate. Iure impedit deleniti ex placeat. Rerum assumenda ipsa reiciendis distinctio.','2002-07-01 17:54:57','2014-04-24 02:28:08'),(61,100,'Nemo ipsa et iusto quae nemo. Impedit labore quidem quia fugit accusantium qui. Quo et sunt sit unde labore error. Hic quasi nisi perferendis pariatur magni sit assumenda reprehenderit. Accusantium non molestiae voluptatibus recusandae similique.','1986-04-30 08:57:43','1981-01-29 14:21:19'),(62,30,'Quia nesciunt dicta corporis sed. Recusandae consequatur et fuga id perspiciatis qui. Minus mollitia nihil architecto ut unde et quis. Aut et qui qui dicta ducimus.','1995-09-06 02:51:25','2003-10-02 04:56:51'),(63,66,'Doloribus totam eos suscipit est nihil excepturi. Architecto fugit repudiandae alias voluptas optio assumenda. Aspernatur odio sit odio consequatur perspiciatis. Sint nam reiciendis accusamus voluptas. Repellat dolorem impedit necessitatibus ut enim.','2018-04-28 01:10:04','1984-11-17 05:51:17'),(64,53,'Rerum atque est quo beatae. Est officiis non fugit fuga ducimus accusantium vitae. Fugiat voluptatum rerum aliquid non necessitatibus quidem autem. Quae excepturi quidem architecto perferendis natus vitae.','2004-04-26 10:04:27','1994-09-05 18:09:20'),(65,51,'Est est ea velit sed. Omnis adipisci et velit. Quia non nobis minus sapiente facilis sit molestiae.','2021-05-28 03:00:17','2010-02-01 12:48:01'),(66,50,'Quam maxime ex necessitatibus dolore. Quis sint aut voluptate nihil quaerat dolorum. Rerum qui sint voluptatum ex autem qui. Consequuntur quia in ut voluptas sed expedita.','2018-07-31 06:18:10','2009-04-07 13:29:50'),(67,3,'Nulla minus aperiam id atque est. Dolor nihil unde atque at quia. Consequuntur dolores animi vel nam quia dolorem. Qui et beatae laudantium perspiciatis molestiae in.','2006-02-01 19:08:43','1989-09-14 18:17:29'),(68,73,'Id non officia ut et natus cupiditate. Ut accusamus beatae est perferendis. Maiores quidem perspiciatis sapiente repudiandae ea modi. Nostrum repellendus reiciendis quasi non aperiam qui voluptates expedita.','2021-07-12 17:31:07','1976-05-29 12:17:43'),(69,53,'Est cum consequuntur ut optio delectus numquam est animi. Temporibus aut accusamus minus. Possimus voluptas maxime alias est. Dolorem facere assumenda et.','2011-06-17 00:56:06','1991-04-13 15:17:53'),(70,20,'Molestias sed ut perspiciatis autem. Nulla ullam est consequatur ut sed atque. Ut quo atque pariatur ab.','2004-11-30 12:57:36','2008-01-04 15:26:03'),(71,54,'Natus doloribus consequuntur itaque. Perferendis est alias sit similique quae est. Amet natus velit ab voluptatem quod. Dolor cum expedita non error.','1975-03-05 03:45:18','1976-04-28 04:08:47'),(72,46,'Quia aut enim alias totam exercitationem consequuntur. Reprehenderit sed et dolores dignissimos aut consequatur. Sit quos eligendi aut non animi aspernatur.','2013-07-11 08:34:27','2000-03-04 00:24:25'),(73,69,'Ab eveniet id dolorem ut molestiae minima. Id vitae occaecati omnis sequi. Dignissimos aut id omnis accusamus. Eveniet dolores alias sequi dolorem sint omnis vitae et.','1993-06-27 17:36:52','1996-12-24 16:54:07'),(74,20,'Quos sit dolorum tempora sit neque. Eum saepe debitis quo architecto fugiat. Eveniet aut quas occaecati explicabo quos quae cupiditate deleniti. Excepturi amet aut porro omnis ut eius expedita.','2020-01-07 05:27:29','1997-07-09 15:38:32'),(75,23,'Eos eos aut iste et est. Eum ut est quo aut veniam magni reprehenderit.','2009-11-16 18:24:35','1986-03-27 06:21:46'),(76,32,'Dolorum dolorem alias rerum nesciunt et quo qui. Repellat et illum qui mollitia. Ullam consequatur in labore veniam. In nemo molestias asperiores. Eum est quia architecto.','2005-12-29 02:31:23','1989-05-20 12:30:43'),(77,53,'Aliquam ab quo impedit culpa itaque ullam culpa cupiditate. Sint voluptatibus doloremque omnis esse vitae omnis ut. Laboriosam dolores incidunt nesciunt hic explicabo quam ut.','1988-12-25 09:59:19','1986-09-26 10:56:55'),(78,46,'Temporibus minima dolores voluptatem vero sit rerum perferendis. Alias rerum pariatur ad consequatur iste nemo omnis. Alias quo itaque et ipsum neque molestias tempore a.','1989-03-22 14:46:40','2008-08-28 20:38:21'),(79,78,'Dignissimos autem et numquam nulla quis magni et. Modi exercitationem cupiditate alias. Cum culpa tempora voluptatem. Officiis nostrum corporis quo et explicabo neque aliquam officiis.','2017-05-15 22:02:29','2004-03-24 15:55:09'),(80,9,'Autem voluptatem nemo in consectetur. Nobis totam et corporis et et.','1991-06-26 08:39:54','2011-02-14 20:18:38'),(81,95,'Veniam quibusdam ut soluta adipisci suscipit ut. Aut illum laboriosam ex autem enim. Nobis distinctio neque deserunt sint. Dolores voluptates voluptatem facilis vel corporis aut eaque tempore.','1985-06-07 07:18:17','2016-02-14 07:43:38'),(82,16,'Excepturi mollitia fuga fugiat ut aliquam error. Voluptatum impedit reiciendis repellendus optio. Nostrum nisi voluptate fuga quae maiores quod. Eum inventore aut necessitatibus qui. Ut praesentium repellendus modi eaque dolores id.','2005-11-15 20:56:05','1978-07-17 23:53:22'),(83,73,'Hic iusto consectetur consequatur perferendis labore voluptatibus error. Ratione recusandae consectetur dolorem esse. Fugiat in et doloremque veritatis. Ratione eum incidunt fugiat voluptatibus.','1986-05-17 12:35:37','2018-02-01 10:18:03'),(84,14,'Illo quos rem libero sit quaerat quo. Iure inventore non aut eligendi excepturi. Libero sint et eaque in.','1986-12-26 14:51:30','1981-01-08 08:50:53'),(85,81,'Quia optio voluptas dolore amet et. Non alias fugit hic dolore dolores aut cumque. Accusamus maxime optio debitis nihil accusamus dolorem ut. Excepturi doloribus dolorum aut aut expedita.','2019-10-11 20:21:42','2004-02-16 16:27:04'),(86,15,'Ad vel odio a sed architecto velit voluptas. Error doloremque ex doloremque.','1996-07-16 15:02:20','1991-11-20 00:03:13'),(87,77,'Voluptatem recusandae asperiores delectus tempora. Beatae adipisci provident molestiae ut a maxime voluptatem in. Atque eveniet laudantium ea. Unde architecto molestias ab. Velit rerum consequatur eaque vel neque ut.','2005-04-07 03:34:12','2016-07-11 22:42:01'),(88,33,'Corrupti possimus quia enim qui neque et. Qui in nisi accusantium eum voluptas qui dolores. Quidem totam animi sit delectus. Omnis sit ut ea dicta quas aspernatur rerum. Tempora voluptatem unde atque velit nam quidem ad.','2018-06-09 22:29:45','1976-01-22 20:35:22'),(89,13,'Quam non velit iste in voluptas id est. Totam quis adipisci quam magni quas. Ipsa aliquam laudantium hic fuga quo.','1974-07-03 14:04:21','1984-05-31 13:53:20'),(90,64,'Dolore et et hic. Et quis consequuntur est rem. Repudiandae numquam saepe ut dicta doloribus consequatur deleniti rem. Voluptates incidunt accusantium iste nobis at et.','1995-02-25 12:03:01','1998-08-16 13:20:54'),(91,3,'Vitae voluptatem voluptatum ipsa occaecati. Vel doloribus hic distinctio laborum voluptatibus consequatur. Quidem ut repellendus aut dignissimos repellat nam.','1975-01-24 15:15:16','1980-07-20 03:33:40'),(92,93,'Laboriosam non exercitationem magni. Dignissimos dicta dolor quae incidunt ab quod. Omnis qui reiciendis nam dolor sequi.','2001-03-21 08:25:33','2010-01-29 00:44:25'),(93,12,'Minima vel eos veritatis. Minima odio non enim blanditiis quo non qui. Commodi earum deserunt possimus non veniam sunt quo.','1997-02-13 07:49:59','2010-07-14 05:52:07'),(94,43,'Est dolore non dolor quis facere ut ullam consequatur. Aut quisquam veniam distinctio fugit veniam. Enim earum error blanditiis quia nesciunt.','2011-10-28 02:10:20','1987-04-20 13:26:22'),(95,38,'Deserunt occaecati est et molestiae laborum culpa exercitationem. Eveniet enim consequatur et laudantium nemo amet.','2005-03-05 06:41:04','1997-09-17 13:02:31'),(96,18,'Qui quasi et hic praesentium. Voluptas enim et ratione praesentium deserunt voluptas qui accusantium. Aliquid est est quia.','2002-05-05 10:32:28','1995-09-02 18:14:53'),(97,56,'Consequatur eveniet dolore quos ullam rerum corporis. Numquam dicta modi ut nisi sequi accusamus est. Inventore et sequi laboriosam officiis. Corporis iure aut earum maiores et aspernatur.','1984-05-11 04:27:05','1998-12-12 12:38:33'),(98,43,'Illum incidunt molestias dolores ipsam sed ea unde. Voluptatem accusantium delectus dolores quasi atque nisi exercitationem. Et et tempora aut sit qui. Nostrum cum quasi dolorem ut et.','1994-09-01 07:02:26','2007-08-23 10:01:33'),(99,62,'Omnis aut est dolore totam. Qui quis quos id blanditiis quo qui. Est est quia minima est minus.','2013-02-13 02:57:06','1986-07-31 10:18:16'),(100,52,'Vel corrupti velit harum cum laboriosam soluta. Sed non veritatis laboriosam dolor deleniti quaerat magnam. Sed quos aut expedita incidunt culpa modi. Vel fuga dolore ex eligendi. Assumenda placeat omnis enim nobis ea.','2004-12-28 17:43:23','1999-02-06 15:31:04');

INSERT INTO reviews_product (id, user_id, product_id, body, created_at, updated_at)
VALUES (1,80,67,'Nam ea repudiandae voluptatum saepe. Non sed sunt vero molestias nulla. Repellendus quisquam eligendi sed architecto nihil voluptatem. Perspiciatis aut itaque quae quia molestiae eos molestiae. Asperiores eaque consequuntur deserunt.','1976-04-16 06:27:07','1996-03-25 02:04:30'),(2,8,1,'Qui neque sed et quam quia cum. Rem harum est sed dolorum. Ut provident voluptatibus non dolorem ut odio iste ut. Maiores quod consequatur autem voluptatem similique sunt eligendi.','1975-05-10 02:46:57','2010-07-23 20:59:32'),(3,79,99,'Occaecati ipsa voluptas odio unde nulla autem. Magni suscipit cupiditate aliquid.','1989-06-03 16:33:28','1972-01-02 18:09:59'),(4,70,25,'Animi eum soluta maxime dolor. Et exercitationem autem quod ad est.','2001-05-06 01:48:32','2017-09-02 14:53:37'),(5,48,92,'Cupiditate odio iusto harum perferendis cum. Nemo voluptas ut nihil facere. Ut consequatur cumque temporibus libero.','2014-03-18 10:46:06','2001-08-11 05:28:27'),(6,58,82,'Consequatur eum aut sint et. Et deleniti hic architecto tempora. Atque et magnam repellendus omnis aut quaerat.','1996-04-19 00:00:38','1995-09-29 16:23:58'),(7,46,11,'Vitae culpa id assumenda tenetur saepe expedita. Aut ipsum numquam qui. Cum fugit sint delectus optio deserunt eaque sunt.','1976-02-08 05:31:47','1986-12-12 08:15:07'),(8,38,94,'Architecto corporis quidem sit. Veritatis ipsa veniam amet. Quisquam quam non molestias quas.','1979-05-31 18:14:09','1979-07-27 04:32:34'),(9,58,2,'Delectus odio qui officia dolores libero. Et veniam odit qui repudiandae in ab ipsam.','1998-04-09 19:10:08','1975-10-02 21:17:01'),(10,74,41,'A nulla eius nostrum molestias. Quo voluptate dolorem aperiam et aliquam velit. Dignissimos aut molestias quo totam suscipit quae. Molestiae explicabo aut vel ut nulla praesentium nulla.','1980-04-12 17:00:35','2016-04-26 05:54:26'),(11,30,22,'Qui dolores rerum aliquam sed. Odio laboriosam et et laboriosam et culpa unde cum. Id commodi voluptas et ea.','2010-10-06 18:24:57','2005-04-14 07:35:04'),(12,57,54,'Qui odit ea iusto facilis temporibus. Magnam earum vero nam magnam. Porro vel sit tenetur sit iure beatae officiis odio.','2002-06-01 06:35:46','2019-10-21 00:16:22'),(13,32,27,'Incidunt voluptates libero non labore. Fugit doloremque itaque quia molestias libero mollitia. Iure consequatur animi dolorem iusto dolores voluptas veniam.','1994-11-06 10:55:36','1976-07-10 12:52:44'),(14,56,31,'Expedita sit rem est occaecati odit non eaque. Maxime vel est aut porro. Id iusto placeat quae veniam molestiae illo dolorem.','1990-03-22 12:42:21','1985-03-02 13:09:13'),(15,8,79,'Sint ut reiciendis repellat accusantium delectus maxime aliquam consequatur. Eaque accusantium itaque blanditiis exercitationem tempore consequuntur.','1982-04-23 00:56:06','1981-07-01 20:59:01'),(16,100,72,'Voluptas eveniet unde facilis iusto voluptas eligendi distinctio. Tenetur accusantium possimus similique rem culpa ipsum. In voluptas eius autem enim. Aut est quaerat pariatur.','1977-07-17 17:46:48','2005-06-18 09:13:54'),(17,52,58,'Accusamus deserunt rem consequatur earum occaecati quae. Omnis quo fuga natus porro eum. Iure ullam facere quasi esse magnam ut.','2010-03-06 06:45:41','1981-07-21 14:24:25'),(18,79,96,'Nobis sequi similique quidem sint voluptatem porro. Est rerum voluptatem harum sed. Quaerat id reprehenderit eos quis vero pariatur. Qui facilis illo cum.','1993-09-24 18:19:11','1977-02-13 08:13:29'),(19,70,23,'Cumque minus veritatis quis neque a. Maiores rerum tempora sit delectus voluptatem. Quia aut autem qui et inventore saepe.','1987-08-26 20:40:53','1981-04-29 04:26:11'),(20,80,97,'Eaque suscipit exercitationem distinctio ipsa non ut rem aut. Mollitia dolorem suscipit eveniet laudantium aut dolore eum. Necessitatibus qui minus adipisci illo ut.','2008-06-30 14:41:01','1993-06-19 03:20:39'),(21,9,30,'Rerum at ratione est recusandae saepe vero sequi. Magnam non vel nesciunt iure quia maiores velit. Iure aut nisi et aliquid ipsa et.','1984-01-08 18:59:26','1982-09-08 22:43:19'),(22,15,20,'Voluptate ad quis sint fugiat assumenda ipsum aspernatur illo. Dolor similique et ipsa ducimus temporibus et hic. Ratione omnis corporis est possimus. Non reprehenderit dolorum quis eius doloribus.','2003-11-16 04:55:34','2003-07-27 10:30:42'),(23,32,50,'Aut sit omnis a minima rerum repellat non eum. Nihil nisi pariatur facilis nam est. Dolorem explicabo et dolorum sit nulla ut qui.','1998-06-06 18:08:05','1988-10-23 08:36:37'),(24,94,66,'Facilis incidunt alias nesciunt voluptas perspiciatis totam quod. Non molestiae accusamus et repellendus qui esse iusto. Modi non autem cupiditate optio a.','1996-05-06 14:09:03','1978-05-24 09:16:59'),(25,62,79,'Non et consequuntur similique voluptate non. Quam nihil excepturi ea voluptatem delectus qui reprehenderit. Blanditiis sunt sit dolore.','2020-05-19 23:55:43','2006-05-29 03:20:24'),(26,51,88,'Dolor voluptatum qui amet tempora hic. Aut eius totam natus dicta eaque.','2015-12-17 06:09:33','2003-07-31 22:00:41'),(27,79,65,'Suscipit eius excepturi tempora modi sequi. Sed animi neque alias et qui animi iusto. Quae aspernatur reiciendis sequi sit corporis enim aliquid cupiditate. Quidem sed ut atque ut nemo maxime. Veritatis aliquid minima dolores velit quas.','1996-08-27 08:19:47','2006-05-30 04:08:50'),(28,40,33,'Accusantium et numquam animi culpa alias. Quia ut voluptates doloribus hic expedita. Velit dolorum esse et neque.','1999-12-17 09:50:31','1974-06-09 02:44:52'),(29,1,5,'Accusantium numquam aspernatur quod. Repudiandae sed tempora enim culpa. Quia quam voluptas optio sed repudiandae.','1982-03-14 13:52:07','1973-12-01 20:53:19'),(30,52,81,'Ab velit tenetur ipsum veritatis voluptas. Nihil sit exercitationem in nesciunt. Ducimus eos quam voluptates aut eos est sed.','2005-09-14 03:09:00','1987-11-11 03:54:31'),(31,57,59,'Ut quo aut harum quos asperiores hic possimus. Illo in saepe in sint nam in aspernatur. Aperiam ducimus deleniti dolorem amet. Qui id ad quia ut dolorem odio ad cum.','1971-04-11 18:41:43','1979-02-06 19:14:35'),(32,1,42,'Nostrum dolor dolores voluptas quia. Quaerat est repudiandae tenetur debitis hic provident. Asperiores velit quasi voluptatibus repudiandae natus placeat. Cum sed voluptas expedita odio veniam.','2007-10-21 00:56:39','1981-05-20 01:56:21'),(33,98,18,'Incidunt nostrum quia ad. Voluptate animi et consequatur sit. Et sequi laboriosam rerum corporis vitae quo excepturi sapiente.','2016-08-07 16:47:07','1981-01-29 21:52:12'),(34,100,45,'Modi non sit aliquam omnis et. Distinctio nihil nesciunt sit ut reprehenderit eaque velit. Aspernatur ullam doloremque omnis molestiae. Aperiam ut sapiente explicabo.','1992-04-07 08:36:26','2001-06-21 16:41:49'),(35,19,75,'Magnam possimus neque quidem possimus voluptates beatae sunt qui. Qui voluptatem rerum tempore sed eum at et dignissimos. Dicta recusandae eaque possimus minus.','2003-06-10 10:16:09','1978-08-08 17:13:25'),(36,81,38,'Aut dolorem vel atque dolore nemo ut. Eos ut asperiores distinctio repellendus et accusantium at. Qui quidem quo soluta placeat et labore dolorem non. Aut ut et nihil quis.','2009-09-06 01:07:09','1988-09-13 09:05:10'),(37,87,12,'Quam qui ut itaque aspernatur sed totam praesentium. Aut consectetur est dolores saepe. Hic est quos officia tempore assumenda dolorem velit.','1993-02-04 23:19:54','2017-06-29 16:05:58'),(38,7,17,'Ad voluptas laudantium et aliquam omnis. Tempore omnis est adipisci. Consequatur itaque quis dignissimos eligendi aut et omnis. Molestiae cumque sunt nobis dolor qui.','2000-07-03 03:57:47','2000-05-24 13:29:01'),(39,59,20,'Sed sit aut omnis atque est. Est veniam tenetur quae asperiores commodi voluptatibus. Dolorem molestias quasi itaque officiis velit vel vero.','2007-12-18 08:10:18','1992-10-11 22:24:45'),(40,89,73,'Blanditiis quod sed voluptatibus aliquid ut illo. Quia non autem et in. Officiis fugiat aut expedita harum. Necessitatibus eum quia et.','2007-03-28 05:06:25','1985-04-06 20:46:20'),(41,52,77,'Et dolorum inventore fuga. Nesciunt aut voluptas totam facere voluptatem ullam. Provident fugit accusamus voluptatem nesciunt nostrum quia debitis corrupti.','1994-05-03 18:44:57','1973-07-13 14:40:44'),(42,39,92,'Voluptatem cumque hic delectus harum. Enim ad aperiam dolor fugit ipsum quidem. Unde voluptas quia natus et sequi odit temporibus voluptatem. Ratione porro quia minima nostrum animi id deleniti.','1971-01-21 00:41:44','1986-01-04 03:17:19'),(43,32,22,'Eius minima ullam et sunt reprehenderit ut ea ut. Beatae quas sint adipisci est. Incidunt itaque assumenda voluptas numquam eveniet.','2003-07-15 18:36:10','1989-05-20 04:48:41'),(44,97,87,'Qui temporibus numquam dolor aliquid. Ut qui saepe est dolore voluptatem et. Illum dolores est ullam.','1992-05-15 09:16:17','1976-02-15 20:00:43'),(45,60,4,'Incidunt incidunt quia numquam voluptatibus sint eveniet voluptatem. Excepturi ducimus quia voluptas quis sapiente dicta ducimus saepe. Minima provident dolor ex accusantium.','1999-09-23 19:21:04','1980-03-02 10:01:48'),(46,98,50,'Et doloribus qui magnam dignissimos. Officiis reprehenderit blanditiis blanditiis quas temporibus blanditiis.','2005-12-23 07:03:32','1989-05-10 14:40:00'),(47,92,72,'Dolores dolorem facere ea aliquid voluptas nulla quia. Velit illo beatae voluptatem molestias necessitatibus iste doloribus. Doloremque quis dolores esse.','2005-05-15 20:13:44','2015-01-07 06:25:53'),(48,31,42,'Et voluptas ut qui vel pariatur eligendi ut. Fugiat ullam asperiores est deleniti occaecati voluptates. Sit vero voluptas vitae quae tempora molestiae consectetur et. Quos neque rerum suscipit corrupti occaecati.','2002-08-30 18:11:06','1996-06-16 10:20:42'),(49,37,62,'Dolorem occaecati nobis voluptatem ullam omnis vel dolorum. Non quibusdam ut dolore vel tenetur sit consequatur.','2017-06-13 02:02:24','1976-02-04 18:54:38'),(50,62,79,'Itaque est enim magni. Explicabo consequatur accusantium explicabo enim accusamus. Quisquam qui eaque sequi sed id saepe. Soluta aliquid qui illum minus est perspiciatis.','2004-02-23 22:01:54','1981-06-11 23:15:45'),(51,48,66,'Fugit nulla magnam rerum necessitatibus qui similique error. Voluptas architecto quidem ullam est et est. Nulla alias magnam commodi possimus. Nihil nostrum soluta possimus dolorem.','1983-06-14 22:15:19','1991-06-13 06:59:55'),(52,80,34,'Architecto incidunt fugit earum ut assumenda inventore labore. Et recusandae alias molestiae unde dolor aperiam qui officia. Aut consequatur laboriosam officia vero. Nulla nihil vel omnis aut non et. Aliquid et est laudantium ut sed.','1980-07-08 03:04:01','2008-06-22 04:24:03'),(53,9,74,'Facilis facere omnis possimus qui a molestiae. At non optio enim hic iure omnis. Exercitationem numquam eos temporibus vel eum asperiores.','2021-10-03 05:02:20','1993-05-31 06:17:33'),(54,77,93,'Tempore alias sit quo. Nihil atque modi et eos. Vitae suscipit eum nemo quo assumenda tenetur illo. Sunt rerum porro recusandae id est consectetur adipisci. Dignissimos exercitationem aut earum.','1997-08-07 23:00:43','1992-03-04 21:43:44'),(55,57,11,'Totam quos veritatis perferendis magnam quas sequi sapiente. Possimus deleniti sint dolor sit. Omnis deserunt eligendi eveniet assumenda tenetur.','1971-04-22 19:10:04','2020-04-10 20:30:39'),(56,57,94,'Velit eum architecto nihil labore dolor ut quia. Vitae voluptatem maiores sint ab soluta. Error provident culpa ut. Veritatis non labore consequuntur.','1971-08-08 08:44:38','2001-01-23 01:44:50'),(57,23,64,'Cumque a sequi in. Ut eveniet doloribus ut consequatur praesentium nesciunt vel. Qui iusto quod aut possimus omnis. Ducimus sit quis deleniti placeat.','2002-01-15 14:00:29','1977-07-28 14:40:52'),(58,54,98,'Beatae numquam et mollitia nostrum perferendis. Fuga atque a placeat quam quibusdam alias. Et nisi et ipsa esse.','2011-12-26 10:51:00','2000-03-21 16:18:11'),(59,25,78,'Mollitia nobis temporibus sapiente soluta ducimus laborum laboriosam. Voluptas laboriosam delectus voluptatum cumque veniam.','2013-09-09 07:50:04','1980-02-29 14:08:39'),(60,50,83,'Dignissimos ab culpa architecto perferendis est consequuntur. Sunt vel quisquam esse corrupti inventore. Qui sint quis consequatur qui nihil qui perspiciatis animi.','1983-11-06 21:26:28','1998-04-11 16:55:47'),(61,98,65,'Sint quaerat ut numquam et voluptates autem. Suscipit sunt velit temporibus nostrum saepe accusantium. Numquam qui unde perspiciatis sunt quae eligendi consectetur libero.','2017-06-29 02:16:51','1971-12-24 20:18:21'),(62,48,3,'Qui dolorum voluptas atque nihil consequatur est ut. Quae in aut atque omnis magni alias beatae. Quaerat placeat dolor ut saepe et. Provident neque quisquam quod.','1993-10-14 06:50:58','2012-05-10 09:11:05'),(63,48,34,'Iste repellendus ea cum unde. Voluptas deserunt ut accusamus distinctio. Ea nulla eum autem ratione tempora soluta autem. Eos perspiciatis accusantium autem optio ullam rerum.','2011-02-13 12:29:21','2015-02-11 20:20:32'),(64,38,16,'Dolorem cumque nemo odio exercitationem et. Sequi ab provident voluptatem molestias soluta aut quos autem. Voluptate non aliquid voluptas temporibus harum soluta et.','1977-02-26 01:11:48','2005-06-18 23:36:15'),(65,37,52,'Reiciendis illo explicabo asperiores hic velit voluptatem itaque. Et maiores voluptate unde non dolorem doloribus aut dolorem. Ut ut ab voluptatem. Suscipit quo voluptas est sequi.','1988-06-27 13:29:32','2008-02-02 00:12:30'),(66,14,29,'Ut autem quia distinctio sint. Nihil dolores dolore quis voluptas sed impedit voluptatum atque. Architecto architecto eius autem laborum incidunt.','2013-01-22 03:44:13','2016-02-16 17:01:49'),(67,8,68,'Maxime accusantium similique dolores ut. Sit accusamus est aut repudiandae quia. Eos porro animi inventore blanditiis quo.','1985-07-21 06:45:15','1992-06-24 04:20:48'),(68,78,98,'Eum earum eligendi ut tenetur. Nam alias sit harum. Quis eaque ullam qui alias officia iusto. Optio dicta reprehenderit quas ad accusamus quidem.','1982-06-18 23:17:51','2002-08-20 00:26:48'),(69,92,1,'Qui nesciunt quo ut quo occaecati. Aut est temporibus facere quo iusto. Molestiae illum dolorem maiores. Officia eos quia qui molestias quis.','1994-10-10 10:38:37','2008-10-14 15:25:46'),(70,54,32,'Et ipsam a earum. Culpa amet in est voluptas repudiandae commodi dolorem suscipit. Totam laboriosam molestias amet quidem ea sapiente. Enim velit odit molestiae ea sed sed alias distinctio.','1974-06-07 06:45:42','1982-01-21 21:51:26'),(71,11,81,'Eum ut consectetur ut quis. Expedita ullam sequi doloribus doloremque. Qui sequi animi cum beatae error sapiente. Vel illo aut autem atque.','2002-03-18 20:45:15','2010-04-13 09:04:31'),(72,56,61,'In quibusdam molestiae sequi. Dolorum saepe rerum quod sit ut consectetur.','2012-09-29 19:30:02','2004-09-05 16:51:25'),(73,63,54,'Expedita nam ratione quibusdam omnis. Cum consequatur deserunt unde totam. Minus illum recusandae qui soluta. Libero nesciunt voluptas labore nisi natus error esse omnis.','1988-04-09 20:17:13','1981-02-09 05:00:36'),(74,3,33,'Voluptatem perspiciatis nemo nihil voluptatem consequatur qui quam. Fugiat fuga rerum reiciendis omnis nam. Autem nostrum ea qui soluta modi.','1989-06-30 10:19:14','2017-02-23 22:53:39'),(75,91,92,'Accusamus temporibus perferendis est dicta at necessitatibus atque. Sit non ipsam natus qui. Est vel sunt deserunt eius id. Commodi accusantium vitae et est explicabo enim sint.','1979-09-05 22:23:20','1982-03-30 06:35:50'),(76,15,63,'Ex in eum aliquam. Dolore eligendi et quis. Doloremque molestiae voluptatem ducimus et.','2000-08-11 05:45:17','2010-07-13 12:10:30'),(77,29,69,'Illo blanditiis quis est cumque dolore placeat. Ullam voluptatem qui rerum quas optio omnis. Ipsam rerum atque magnam minima ex laborum a consequatur.','2006-11-24 07:24:42','1972-05-29 05:48:47'),(78,4,67,'Ut omnis quam delectus amet explicabo. Doloremque et tenetur sit vero et est blanditiis. Aut neque perferendis quisquam. Nulla voluptate quo dolores velit ad. Vel sint commodi ipsa aut.','2003-02-02 06:13:00','1973-02-28 17:52:55'),(79,49,91,'Aperiam rerum qui quisquam quia fugiat. Quo aut error quas laudantium. Officia necessitatibus voluptas recusandae est id.','1971-09-19 11:19:50','1999-08-30 00:32:28'),(80,65,82,'Qui dolores molestiae et omnis nemo optio ullam laudantium. Modi quasi incidunt mollitia ut suscipit aut voluptatum. Aut delectus quia debitis ut. Quis sed facilis iusto repellendus omnis laborum architecto incidunt.','1971-08-30 00:19:23','2004-06-04 21:49:19'),(81,49,53,'Ut voluptatibus facilis qui impedit pariatur velit. Tenetur enim doloremque nulla consequuntur quidem voluptas. Cupiditate alias sint qui qui assumenda qui fuga. Repellat aut quibusdam inventore placeat dolore voluptatem ab.','2002-01-28 12:22:28','2009-03-14 02:59:19'),(82,45,7,'Dolor enim et saepe dignissimos. Omnis quae est aut et exercitationem nulla accusantium. Non est nemo aut id blanditiis consequatur.','1977-09-28 00:18:31','1990-08-25 17:21:40'),(83,12,71,'Quia est tempora rerum et et. Odio saepe aliquam commodi. A ad nihil modi fugit eos commodi omnis inventore.','1981-10-12 15:32:18','2005-06-02 01:52:47'),(84,99,77,'Praesentium consectetur in debitis fugiat et aut. Eligendi accusamus assumenda non. Quibusdam nisi officia voluptate. Officiis inventore repellat fugiat et et similique.','1988-10-03 03:56:32','2003-12-29 22:22:09'),(85,98,25,'Quis nihil minus enim nihil est earum. Accusamus in rerum dolore blanditiis quisquam inventore. Sit fuga sint aperiam incidunt dolorem ab quis laborum.','1978-08-11 07:58:21','1985-11-05 14:47:59'),(86,29,64,'Numquam repudiandae fugit eligendi asperiores quia. Atque est quos quia aspernatur possimus itaque minima. Laudantium fugit expedita officiis. Aut distinctio at ad itaque quos ut dolor sit.','1994-11-23 12:14:39','2008-11-22 01:08:15'),(87,32,80,'Earum cupiditate reiciendis a omnis odio velit quibusdam. Et quidem non quo corporis voluptatum. Atque quibusdam perspiciatis enim reprehenderit. Ad cupiditate et beatae magni.','2011-09-03 03:40:20','1975-05-02 07:46:30'),(88,88,83,'Omnis doloribus velit nostrum dicta aspernatur sed. Tempore nihil rerum ab itaque ea error.','1971-10-22 04:01:40','1997-08-03 20:51:24'),(89,8,75,'Sit sed soluta tempora minima deleniti. Pariatur est dolorem sit omnis quo quia consectetur. Harum et iste nemo laboriosam fugit.','1998-07-22 20:52:28','2007-09-27 17:44:41'),(90,37,69,'Est est et tempora soluta. Similique dolores dignissimos sunt. Aut et tenetur exercitationem harum exercitationem animi. Voluptatem quia sit vitae tenetur.','1985-09-03 14:33:03','2000-06-05 10:38:22'),(91,60,43,'Molestiae culpa consequatur ratione et quod nostrum enim. Esse incidunt amet vitae voluptatem est aut et vero. Cum magnam sapiente rerum ut facilis non esse accusamus.','1991-07-31 06:40:52','2010-08-19 21:40:51'),(92,78,16,'Impedit numquam omnis quod consequatur consequuntur ut impedit. Nisi nisi aliquid neque sapiente qui voluptates non sunt.','2010-02-10 01:29:21','2010-05-06 01:48:07'),(93,48,56,'Nulla voluptates sint sint aut quos. Omnis natus omnis aut tempore deleniti. Optio nihil veritatis ea hic veniam. Inventore minus architecto velit qui nemo. Sequi beatae at modi vero quos omnis magnam.','1982-12-19 06:02:23','1989-06-23 18:35:48'),(94,91,97,'Culpa corrupti eveniet nam voluptas omnis qui doloribus vero. Est sit rem rem in et modi veniam. Ratione iusto ut optio dolor maxime repellendus.','2000-05-08 05:24:07','1978-04-03 05:31:28'),(95,14,51,'Delectus porro eligendi fugiat qui voluptatem aliquid. Nostrum aliquid ducimus autem porro soluta. Rerum magnam omnis quod non laboriosam.','1999-02-24 13:19:37','2017-07-14 23:30:33'),(96,72,43,'Rerum voluptas quia tempore qui eius ab libero. Voluptatem enim id harum odit aut. Error vitae quis id animi sunt et asperiores.','1992-08-21 09:37:16','2002-07-18 13:40:01'),(97,51,35,'Qui architecto laudantium et aut id et. Repellat qui rem rem aut at sit doloribus. Consequuntur magnam corrupti animi dignissimos. Est eaque sed dolor consectetur maxime quasi deleniti illum.','2003-10-14 01:37:20','2010-01-04 23:11:29'),(98,56,15,'Et ea debitis error minus porro beatae. Quos amet nobis et occaecati. In mollitia ullam temporibus ab. Totam commodi autem voluptatum labore quod provident nesciunt.','1970-02-03 15:31:56','1975-08-31 18:25:34'),(99,87,86,'Distinctio voluptatem possimus voluptate omnis facilis dolorem. Blanditiis occaecati blanditiis non beatae et excepturi fugit voluptatibus. Corporis necessitatibus placeat unde architecto.','1987-05-19 03:07:38','2016-07-10 16:36:53'),(100,32,16,'Cumque rem consequatur rerum ea deleniti ex aut. Et et occaecati minus totam ipsam. Ea quia a odio quis ea cupiditate et.','2004-12-05 03:07:52','2007-10-25 08:47:34');

INSERT INTO discounts (id, user_id, product_id, discount, started_at, finished_at, created_at, updated_at)
VALUES (1,26,65,22,'1993-04-10 12:53:15','1976-06-09 08:44:44','1990-07-30 11:29:17','2020-09-24 01:15:50'),(2,56,88,19,'2004-06-23 01:08:22','2001-04-10 08:44:48','1972-04-28 09:46:54','1974-09-14 18:25:29'),(3,63,69,10,'1989-01-20 05:15:32','2001-01-14 00:36:38','1993-07-12 21:10:03','2012-11-07 02:23:28'),(4,28,56,23,'2004-09-13 05:09:48','1973-03-14 15:58:08','1973-02-19 08:46:57','2011-01-03 16:56:58'),(5,95,8,15,'1987-08-12 05:23:52','1981-09-13 22:54:15','1974-11-30 02:56:06','1985-11-01 17:28:57'),(6,13,35,9,'1980-11-04 02:05:18','1984-05-16 07:47:44','1982-10-08 17:12:18','2012-12-14 19:28:13'),(7,20,45,24,'2010-09-22 01:20:19','2008-06-02 03:15:57','1999-06-01 05:41:00','1992-01-13 15:50:54'),(8,65,91,24,'2021-05-02 15:50:12','1986-12-12 04:26:46','1972-07-28 19:36:42','2017-02-05 08:05:10'),(9,73,40,22,'1973-07-10 16:22:16','1976-08-23 05:19:16','2012-02-04 14:15:38','2001-10-02 12:26:45'),(10,62,60,23,'1981-06-08 03:36:42','1997-09-10 05:17:23','1985-05-08 06:30:15','2007-05-07 12:55:46'),(11,34,36,1,'1974-08-16 13:35:39','1989-06-26 10:49:36','2013-01-27 01:53:07','2016-09-26 00:48:09'),(12,64,81,11,'1981-04-18 02:09:52','1975-12-16 03:41:25','1972-01-21 18:48:30','1987-01-15 22:30:55'),(13,46,64,5,'1980-03-25 01:09:51','2012-03-18 05:20:26','1977-07-15 09:13:35','1978-09-06 11:48:12'),(14,45,87,18,'1972-04-09 12:31:50','1980-06-05 04:39:12','1976-09-16 20:15:54','1975-12-07 06:11:42'),(15,94,84,10,'2006-02-13 08:37:03','2001-01-17 09:21:46','1995-06-28 05:43:54','2011-01-07 18:52:10'),(16,28,51,19,'2012-03-04 11:57:06','2007-06-20 04:59:57','2008-04-12 15:52:21','2021-11-21 03:09:01'),(17,39,29,9,'2015-12-11 15:35:19','1984-06-14 09:50:07','1993-04-19 05:45:58','1974-10-06 15:20:47'),(18,89,67,13,'1978-12-23 07:07:38','1971-10-05 21:15:47','2007-09-28 00:52:11','1980-06-15 05:24:30'),(19,86,91,2,'2001-02-20 01:54:01','1999-12-21 22:01:06','1995-02-24 13:24:21','2011-09-25 12:43:21'),(20,72,96,7,'1986-11-26 12:09:06','1987-11-17 16:25:30','1999-05-03 02:24:08','2013-09-10 09:36:12'),(21,68,51,12,'2012-04-25 05:28:44','1975-10-02 01:42:27','1976-02-27 17:26:10','1974-04-12 02:40:37'),(22,20,25,8,'2014-05-05 18:05:09','1980-03-12 08:18:36','1982-03-15 11:07:53','2014-03-24 14:35:59'),(23,57,98,2,'2011-04-25 11:33:22','1974-09-21 12:14:43','1994-04-01 03:34:23','2018-11-15 05:20:18'),(24,72,48,18,'1975-06-19 10:17:57','1985-03-05 18:17:14','2017-05-27 09:38:56','1970-06-28 07:23:44'),(25,79,26,25,'2012-09-15 19:19:24','1974-04-29 02:16:02','1999-09-16 11:20:28','2008-11-17 18:18:54'),(26,58,87,4,'1974-02-19 18:14:59','1988-01-23 23:29:32','2006-06-22 08:55:29','1977-03-30 17:48:05'),(27,65,61,4,'1992-02-06 16:09:34','2011-06-08 18:44:33','1990-12-24 15:04:44','1982-05-30 00:15:57'),(28,21,34,20,'2008-03-22 00:32:07','2007-05-14 18:06:18','1997-06-11 09:54:16','2012-06-11 07:14:31'),(29,83,45,24,'2009-09-22 10:31:57','1983-04-29 03:03:10','1991-05-02 10:30:13','2007-02-06 10:44:18'),(30,45,86,9,'1997-10-30 07:44:14','2006-03-19 02:23:38','2011-12-05 01:00:30','2002-06-15 23:22:13'),(31,7,29,3,'1979-11-18 17:51:40','1975-08-24 23:11:07','1996-10-25 07:37:23','1975-10-18 00:39:13'),(32,17,22,4,'1994-01-18 18:43:04','1991-12-06 23:02:27','1996-03-13 02:05:37','2015-01-05 02:21:10'),(33,28,59,12,'1985-09-26 03:50:54','1986-06-29 13:40:05','2012-09-13 22:23:53','1997-10-26 04:57:39'),(34,81,64,5,'1990-12-25 20:29:34','2007-03-14 17:53:06','1992-07-17 04:53:43','1977-10-12 22:26:21'),(35,5,79,8,'2012-05-20 09:31:19','1998-06-17 07:49:27','1987-09-16 14:25:25','2019-04-12 17:34:45'),(36,91,6,3,'2014-09-26 22:38:19','2020-06-14 07:10:43','1997-10-24 09:49:12','1987-03-20 11:07:33'),(37,46,5,25,'1982-07-29 17:23:25','2008-08-25 12:28:27','1990-01-27 20:05:31','1970-01-20 01:28:24'),(38,75,73,4,'1996-07-11 17:37:48','2021-07-11 18:51:51','1978-11-23 00:58:04','1996-05-25 02:38:54'),(39,69,76,4,'1974-02-25 13:36:53','2005-11-11 17:29:27','1995-08-25 12:28:42','1974-07-23 00:38:54'),(40,63,62,23,'2014-12-04 15:46:20','1976-12-03 00:31:59','2016-02-24 05:48:38','1987-07-18 17:35:10'),(41,73,89,23,'1989-07-07 07:05:14','1999-07-02 07:39:40','1978-12-31 22:27:42','1978-06-11 03:18:02'),(42,49,93,19,'1994-09-27 00:05:11','1997-08-19 06:03:08','1974-09-19 12:06:56','2017-09-17 17:20:20'),(43,50,3,21,'2021-11-09 00:28:16','2010-08-23 06:32:22','2003-12-29 16:19:17','2014-05-24 11:11:55'),(44,68,61,16,'2014-10-01 02:53:06','2015-10-13 01:01:20','1998-02-27 06:47:33','2003-10-22 08:32:06'),(45,84,92,3,'1995-08-14 11:19:05','2018-11-09 11:10:45','1977-07-30 11:33:03','2009-07-15 05:21:08'),(46,64,71,15,'2015-11-10 16:58:44','1982-07-11 23:16:59','2016-05-11 22:47:59','1996-02-17 19:27:40'),(47,69,58,1,'1971-11-12 07:26:44','1988-08-24 17:22:51','2015-01-01 00:48:37','2019-01-17 22:35:15'),(48,8,6,25,'2000-11-24 22:15:05','1976-08-03 19:23:04','1992-08-15 11:14:53','1979-01-23 15:53:35'),(49,44,3,15,'2017-02-24 21:26:33','1987-12-04 20:42:00','1990-05-31 05:42:21','2015-04-29 22:40:59'),(50,92,61,3,'1975-05-18 03:04:40','2018-09-17 22:04:41','1980-11-30 06:23:00','1981-07-10 15:52:49'),(51,83,8,9,'2016-09-07 10:54:05','1982-09-08 08:29:03','1978-01-16 20:29:51','1990-07-30 17:03:18'),(52,18,66,24,'2010-11-19 17:29:09','1987-01-27 13:35:00','1988-01-14 05:50:57','2013-12-28 10:57:36'),(53,95,43,4,'2004-02-18 04:21:29','1978-11-01 21:52:33','1998-01-02 17:08:39','2015-03-26 10:55:45'),(54,13,86,24,'1994-01-31 05:31:53','2011-07-01 10:45:35','2003-10-12 10:11:18','1987-10-27 21:57:01'),(55,69,47,23,'1997-12-08 02:57:45','1981-12-12 08:30:17','1984-12-26 00:22:24','1997-08-10 03:41:25'),(56,89,14,19,'1999-12-07 12:16:01','1971-11-03 04:50:12','1989-05-16 17:52:13','1993-09-27 09:02:24'),(57,58,45,13,'1989-10-20 08:45:43','1984-04-11 20:53:24','1977-04-03 17:26:57','1998-03-09 02:17:45'),(58,39,73,24,'1981-09-17 22:09:24','1970-11-05 01:16:34','1977-07-26 19:29:02','1982-05-28 00:05:16'),(59,70,25,25,'1996-07-29 21:07:23','2000-01-01 20:38:44','1987-04-03 23:12:23','2018-03-07 19:41:28'),(60,70,49,20,'2005-11-29 03:54:42','2001-08-15 19:35:26','1993-12-16 01:48:46','2016-08-19 14:38:53'),(61,65,38,3,'1981-11-12 04:28:52','1974-04-10 02:46:29','1993-09-14 12:02:01','1977-11-04 05:18:09'),(62,68,54,16,'2005-09-25 09:43:32','1985-01-06 13:07:46','2015-08-24 06:08:41','1982-04-16 10:48:26'),(63,20,14,19,'1974-01-09 18:34:13','2020-11-06 18:55:55','1970-11-08 19:48:02','1986-05-30 10:59:42'),(64,77,46,19,'1990-07-19 10:24:42','1972-09-19 21:36:46','1985-08-01 11:10:18','1973-08-15 07:17:41'),(65,53,64,11,'1983-01-18 20:24:21','1979-04-12 07:15:51','2012-10-07 17:13:47','2015-07-23 23:27:54'),(66,91,64,13,'2002-09-12 16:23:38','2011-08-01 18:42:37','2003-09-20 12:12:03','2005-11-07 00:34:37'),(67,77,34,6,'1992-10-23 13:12:02','2004-11-15 09:08:52','1992-02-26 00:35:42','1988-02-10 00:56:47'),(68,42,3,13,'1984-10-23 20:32:54','1985-02-09 08:10:26','1990-02-18 21:26:05','2014-10-07 21:04:45'),(69,99,33,9,'1991-07-30 16:41:22','1982-08-18 07:26:23','1973-03-09 08:05:46','1987-12-08 00:29:56'),(70,66,73,6,'1977-05-20 02:25:55','2010-08-11 02:33:48','1990-04-30 15:58:39','1971-04-29 14:23:12'),(71,96,5,25,'2011-07-04 17:59:24','2015-08-12 03:35:08','2016-05-31 15:43:20','1995-09-24 13:01:07'),(72,9,53,7,'1982-10-05 21:14:24','2011-02-19 13:11:49','2008-09-06 02:03:47','2006-10-04 18:31:29'),(73,7,51,12,'1988-07-21 17:29:25','1970-09-25 12:51:04','2018-07-13 07:33:09','1990-02-09 22:27:36'),(74,59,76,2,'1983-06-01 13:33:39','2021-07-10 06:31:47','1987-04-14 22:40:57','2021-10-17 21:10:15'),(75,53,87,10,'1986-11-26 04:20:25','1973-04-28 00:29:11','1999-12-04 13:53:42','1999-02-06 13:38:04'),(76,33,35,22,'1975-12-25 15:04:03','1970-02-10 15:57:39','1977-10-17 06:41:33','2003-11-02 22:55:20'),(77,88,66,21,'1980-07-22 02:26:38','2012-07-30 19:47:31','2001-01-22 12:30:13','2019-09-03 14:18:17'),(78,3,60,10,'1987-12-17 03:50:57','1976-01-15 15:35:37','2011-09-23 18:35:03','1975-07-04 19:38:45'),(79,73,46,12,'1973-01-05 16:19:07','1995-11-10 11:10:38','2016-05-07 20:30:00','1975-02-19 06:14:24'),(80,42,11,14,'1993-01-01 16:19:45','2010-09-07 15:48:16','1981-06-09 12:09:20','1986-10-17 02:49:38'),(81,87,2,9,'1974-07-05 16:04:03','2002-06-18 23:22:20','2014-02-01 00:27:11','1972-03-16 04:56:40'),(82,73,74,24,'2001-07-27 19:34:26','2017-04-30 00:21:21','1973-09-08 02:53:03','1970-02-05 04:54:47'),(83,90,12,7,'1972-10-03 02:26:52','1991-06-24 20:44:08','1971-04-25 19:12:52','2006-03-18 13:15:04'),(84,82,92,3,'2020-10-08 02:53:42','1974-03-30 21:15:01','2007-10-25 03:03:11','2007-11-07 09:00:17'),(85,92,1,11,'1970-05-21 17:37:28','1999-12-01 18:56:24','1982-07-18 02:25:34','1999-06-01 04:47:58'),(86,14,19,11,'2014-04-09 03:58:57','1996-01-26 17:35:07','2021-10-08 08:57:57','2013-02-22 03:44:02'),(87,98,47,25,'1996-09-07 13:23:48','1980-03-24 21:14:15','2021-03-16 18:51:05','2011-11-16 10:28:52'),(88,75,29,2,'1971-08-20 17:30:08','2005-01-22 02:05:48','1974-08-04 04:36:56','2014-11-22 09:34:21'),(89,90,26,20,'2003-03-15 03:41:47','1990-06-18 12:44:26','2002-09-12 05:26:52','1976-01-02 11:07:21'),(90,29,51,18,'1990-12-22 03:43:30','1995-04-15 08:05:03','1988-09-25 06:49:27','2004-07-28 07:29:26'),(91,71,24,7,'1976-10-13 04:56:41','2020-12-09 00:19:10','2017-02-05 21:31:39','1997-06-11 07:30:40'),(92,83,33,18,'1991-05-25 11:46:01','2005-07-27 09:14:47','1984-10-31 13:59:47','2004-04-29 08:33:20'),(93,44,74,8,'2007-06-25 22:22:43','1982-01-29 22:58:17','1986-01-06 14:48:52','2010-07-13 23:12:50'),(94,10,80,9,'2020-06-04 21:04:40','2014-07-30 13:04:46','1970-07-05 15:33:24','1979-11-19 02:21:44'),(95,97,44,22,'2021-05-26 22:59:02','2020-10-16 22:20:02','2004-03-07 11:40:15','1985-01-01 20:50:10'),(96,82,34,11,'1988-01-05 20:39:35','1998-04-29 12:05:22','1971-07-01 03:04:02','1975-11-22 17:56:58'),(97,88,65,5,'2014-12-08 08:28:11','2014-06-20 21:45:04','1989-09-17 11:57:14','1983-11-13 11:50:53'),(98,93,41,7,'1970-03-05 10:52:25','2001-04-27 18:30:57','1999-06-09 00:27:41','2010-08-04 11:27:23'),(99,38,78,16,'1970-05-13 04:04:07','1991-11-01 13:32:51','1994-06-07 14:03:05','1983-07-22 10:26:00'),(100,37,68,8,'1993-05-17 15:19:14','1977-04-27 21:13:00','1972-06-29 14:12:51','2014-04-10 03:32:14');


/*
 * ???????
 */

-- ??????? ??? ??????? (??????????????) ??????? ? ?????????????? ???????????.
-- ??????? ??? ??????? ??????? ? ?????????????? ??????????? JOIN ? ??? ????????????? ???????????.

/*
 * ???????  ????????? ????? ? ?????? (jacket id=16), ? ??? ?? ??? ? ??????? ???????????? ??? ???????????.
 */

SELECT 
  CONCAT(
    (SELECT users.firstname FROM users WHERE users.id = reviews_product.user_id),
    ' ',
    (SELECT users.lastname FROM users WHERE users.id = reviews_product.user_id)
         ) AS user_name,
   reviews_product.body,
   reviews_product.created_at
FROM reviews_product
  WHERE reviews_product.product_id = (SELECT products.id FROM products WHERE products.name_product = 'jacket')
  ORDER BY reviews_product.created_at DESC
LIMIT 1;


SELECT 
    CONCAT(users.firstname,' ',users.lastname) AS user_name,
    reviews_product.body,
    reviews_product.created_at 
FROM products
    JOIN reviews_product ON reviews_product.product_id = products.id
    JOIN users ON users.id = reviews_product.user_id 
 WHERE products.name_product = 'jacket'
 ORDER BY reviews_product.created_at DESC
LIMIT 1;


/*
 * ????? ??????????? ????????????? ???????? "adidas" ? ???????? ????????????? ?????????.
 */

SELECT 
  (SELECT users.firstname FROM users WHERE users.id IN (
     SELECT orders.user_id FROM orders WHERE orders.order_product_id IN (
       SELECT orders_product.product_id FROM orders_product WHERE products.id = orders_product.product_id) ) ),
products.name_product    
FROM products
WHERE products.brand_id IN (SELECT brand_names.id FROM brand_names WHERE brand_names."name" = 'adidas') 
;


SELECT 
   CONCAT(us.firstname,' ',us.lastname) AS user_name,
     p.name_product 
FROM brand_names bn 
   JOIN products AS p ON p.brand_id = bn.id
   JOIN orders_product op ON op.product_id = p.id
   JOIN orders o ON o.order_product_id = op.id
   JOIN users AS us ON us.id = o.user_id 
 WHERE bn."name" = 'adidas';


/*
 * id = 1 T-shirt /2 orders_product.id = 79 & 76 
 * id = 2 sneakers /2 orders_product.id = 5 & 47
 * id = 27 shorts /1 orders_product.id = 77
 * id = 49 topic /0
 */



--??????? ??? ?????????????, ? ?????? ??????? ????? ??????? ???????.

--??????? ??? ????????????? ?? ??????????? ?? ????? ???????

CREATE VIEW users_who_have_not_made_purchases AS
SELECT 
   CONCAT(users.firstname,' ',users.lastname) AS user_name
 FROM users
   LEFT JOIN orders 
     ON orders.user_id = users.id 
 WHERE orders.user_id IS NULL;

--??????? ??? ????????????? ??????????? ? ????? country 'SouthCarolina'

CREATE VIEW users_residing_SouthCarolina AS
SELECT 
    CONCAT(users.firstname,' ',users.lastname) AS user_name
  FROM addresses
    JOIN users 
      ON addresses.user_id = users.id    
  WHERE country = 'SouthCarolina';

 
--??????? ???????????????? ???????.
 
-- ??????? ????????? (??????? ? ????? ??????????) ?? ?????? ?? id ??????
 
CREATE FUNCTION quantity_of_goods_in_stock(id_brand INTEGER, OUT count_product BIGINT, OUT sum_product BIGINT) AS
$$
SELECT 
COUNT(products.name_product),
sum(number_products.quantity)
FROM products
JOIN number_products ON products.id = number_products.product_id
JOIN brand_names ON products.brand_id = brand_names.id
WHERE products.brand_id = id_brand
$$
LANGUAGE SQL;


SELECT quantity_of_goods_in_stock(1);

 
--??????? ???????.


/*
 * ??????? ???????? ?????? ?????? ??????
 */


DROP FUNCTION check_discount_started_trigger cascade;

CREATE OR REPLACE FUNCTION check_discount_started_trigger() 
RETURNS TRIGGER AS 
$$
BEGIN
	IF NEW.started_at < CLOCK_TIMESTAMP() THEN 
	  RAISE EXCEPTION 'A spoon is the way to dinner. Set the current date.';
   END IF;
  RETURN NEW;
END
$$ 
LANGUAGE PLPGSQL;

CREATE TRIGGER check_discount_started BEFORE INSERT ON discounts
FOR EACH ROW 
EXECUTE FUNCTION check_discount_started_trigger();


INSERT INTO discounts (id, user_id, product_id, discount, started_at, finished_at)
VALUES (101,26,65,20,'1993-04-10 12:53:15','1993-06-09 08:44:44');

INSERT INTO discounts (id, user_id, product_id, discount, started_at, finished_at)
VALUES (101,26,65,20,'2022-02-24 12:53:15','2022-03-24 12:53:15');



























