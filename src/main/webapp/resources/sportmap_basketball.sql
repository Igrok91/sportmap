-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: sportmap
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `basketball`
--

DROP TABLE IF EXISTS `basketball`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basketball` (
  `idbasketball` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(145) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `links` varchar(90) NOT NULL,
  `Ñreator` varchar(45) NOT NULL,
  `sity` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `house` varchar(45) DEFAULT NULL,
  `image` longblob,
  `subject` varchar(45) DEFAULT NULL,
  `info` varchar(145) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  `coating` varchar(45) DEFAULT NULL,
  `school` tinyint(4) DEFAULT NULL,
  `institutions` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idbasketball`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basketball`
--

LOCK TABLES `basketball` WRITE;
/*!40000 ALTER TABLE `basketball` DISABLE KEYS */;
INSERT INTO `basketball` VALUES (1,'basket','55.750457','48.739340','https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos','https://vk.com/igor_ryabtcev','Innopolis','Sport','12','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0@\0\0\0@\0\0\0ªiq\Ş\0\0±IDATxœ\í›y\×u\Şw\é~Ë¼y³`¬\\\0n\àN\Ñ%.¦$\ÚVb\Å2EÇd1%+NÅŠ\íJU6W\Å\år\Ê)\'q\Å.¹œTd%‘‡²\ÚeÚŒIÊŠH-%. ¸ @l\Äf\ß\Ş\Ò}\×ü\ÑıCP„(\Ì?Á­ºx\İı^O÷÷s¾s\î¸\Ğ.´\íB»\Ğ.´ÿo›x§p\ïN‘¦‰¼j\Ãpõ\æF]_72˜\î\ì\ß8gjÍ¿~f®ú\Í§©We¶k,Y\Ú:¨g6\Öx5õ\î\é…û”u\á…/¾Šy\'\ß\ï#\àc»Ôµ\Ç\ê÷\î˜ø\Éñ\ÑúUÍ†’z•\ÉV…û¿=\Ç\ã\ÏM11w]\Õ\Ï\Õ[*\ÖZ€÷,÷¬¶l˜Y\È^89\Ó}h~\Ùş\Ùÿ<ö¾\ïy\Ş	ø‡W%·\ï\Ü\Şüg—]<ôÑ‘Fš¤)Bi¢hğ\ÈK9Ÿı\ß\Ù\Ü0\Ü÷¾!®Şš q\ã±N\àC\Äû@‘#Äˆµ\Åe\ãMuşfr6û½ÿşRø\Æù|\ßóFÀG/\â²\İ7ûº=›~v\Ó\Ä6™öoDÕ†¨\Ô\Z´|˜\â¥#\ÓüÔµÜº«N°]Z+\Ë\ä­EL{\Û]\Å;OŒ<„ğ>|\0\"1D–VL8t¢ó\'fòõ\Å\Ãñ\àùx\ïóBÀ?ºFıò»o\Şöï®¼ñ†Á\Æ\Æ\ËQõ„Th8µ\äùü£¯\à²»}#[‡\íNµ†,\Ñ¼É°EºË³\ä­\Å5\"¼„’\ï\0\Ñ¦\æó¥\ÇÚ¿ñ\Ùü½\İw[ü½­4/\ÛQûƒ»?ôOL\\{;ªo1F‚\ËPxfV\"Ÿ{ø }\Êğñ;·\ĞH\",#:Kğ9ÁY¢\Ëñ\Ö‚%XC\Ş^¦»4\ív\ëHğëˆº]\ÇKG;_xm\Î|ú+GY9W\ê\\o¼m„\Í[&¾úËŸş…Ÿ\Ş|\í‡•A‚·\Ä\èPZ¹\âO¿ş*ZX\î{ÿúªŠ\Ü:‘”=\Æ@18„P¨´Jğ`º\"Z€–%@1\Çc\êš\â{6§ş‘YıFÀG¶±u_«ò—÷~\ê—nù±[ï ›¢/²•$Qü\å“SL/,ó‰÷\ï`°OcŒ+„-¬Á\çÁAD\ï 8j\Õ\Zˆ”\åL1\ÕNym5\ådK±§´}BD“j\É\ÖAµ]\îØ”ø‡_ü\Ñ=Aÿ¨7ü\ì6w\\:zÿÖ«ÿşõ\ïº\é&º\íGM­$O\\\áå£³ü\ÜmŒ\Õ\ètsD`-òD\\÷—‹û+©b\Ù7ù\î¡6¿\ä\Ù÷\Ê‹\Ë+@\n‚J¢i¤\ìÜ \Ù36tıØ†\Îı¿¨Z\çó\ã\Ò;JÀ\îõ\Ï\Üı‰ûn\İÛºaÛ„ ˆ1v‘™\Õ\È7›\ä–\İ\Ã\\¾½I–;Äš\Ò\Ä{\ì!ˆ„‘TRã›¯\äü\Éÿ9\Î\É\év\ÂGn\èg¼¢©\ë@*!3V\æ™Zr\ëp\à5\Ï\ãi¢o½¸.ş\0\â/¾c|ò\n~\å\ïş\ÜOÿ;r5SSÔ’‚÷@@\Ä\0Bñ­¦©\'\Û÷Œ\âGDOŒA BAV<\çc)NVùÂ·\æy\àñ\ÃÜ²3\á\×\î\Ø\È\Ä@\çÈº)Y»…s‘$1(®O¸\ë\â”N˜\\²<;iyö”üøucòû\ÏÎ¸?<\ï\Ü3ÁUw\Üq\Õom\Ûs\\¦–xú+‚\0ˆ(AH\Ìd\ì?6Ï×ŒĞ¬v-‚H\"JH´*\\Ø…€%ˆH<AVø\Ü\×gxøÉ£|ú#üø\î*&7´;9\Îxœ˜ q\ŞB$¸ˆ÷‘\è\ÙÒ¯˜¸Tğşí½§\âoµ|\åñW\æó}ç•€+vV~û¦;>8l¨rja%ÏÈ™^\ÌX\\\ÍÈe¥\İ\Å{\ÇcûNñõgOC€\èI\ÔSÁ††b¼©o\n†kPW SÍ—¿·Ì£O\ç\×rŒ\Û.«²\ÜÊ°Ö•Ù¢ğ!dy¬S“\ÆEB\0×\Æ\á\Zö7œ7>±K|`Û?| \ÛÁñ\ïO1·\Ô\ÆùÀ\Ìü\nõ\ë#G—;\Ü|I“\rıš\Ü9ò\Ì\Ò\ê\æ,­f\Ì.µ\Ø;\Õen9#·şª\â\Òñ*\ÛG+ü\Å\'øù\âƒW÷3·\Ü)\Ê\á\"^e¶ˆ=½Œ\å?q%%>B‘mı\âg>v™øÀŸŒœ?õø\Ë\r\î]À[ƒ÷^\Õdt@SÑ‚j*yx\ï\n}x\Ï\åM\ê‰wez\Ã\Ç;K7\ÏY\\\éò\Ú\Ì*/]\â…c|\í™6®a¦U\å\Ù\ãíƒ’Š\ntŒ\'„\Ñ$Ä²$–d”A\ÄRg\">Dj©`c¿üUğ?”€ZÜ½•›m½ö;Ÿú\èò®=cL-;\áx÷%uÈ•nà¡§g¸bsÊ®\ÍU\Ú]ƒs\ë\ÖXœ-:\ÑÓ—F6jn¸¨\Æe›ûøö\ËK\ìŞ¨8|j•¯>9\ÇÁi\Ç`M1\Ş\ŞbŒ/Š\"ïŠ²8\0¡°4e>\Ê\Ï\"BB­¢.Ú„‡Ÿ_\à\ä\Ûò€K\Æõ=Ÿ¾ó\"½\ëòº–CS+¼÷\Ò\Z\ŞY¬$Zp|Æ²\Ò\êr\é\Æ\Î\Zğe¡=1x(+½\ÎY¢·¤\ÒóÒ‰Yó\É\ÛÇ©%\Ç^\\\ä«O\Îñ/şl†w\ï¬s\Ïu¶öGZ&ı\é01®iCHD\ÄX\Ê*D!\è¯\n½¡O\Şş{g\Ã\'\Ïö\åG¶S\İ6V¹;©40Aò\â\É6\Ş\æ\ìcŠ\Ò\×;l1PŒ5X»¼)j}\ï\Êóxğ\è\Ş{?¶\Ì\Ö!\Å@M b\à®\Ëûø÷\İÈ¯\Ü1À¾\ãKü\Óû\'ù\Ê3]bˆ$²LŸ!\"bYIGˆµ\ã2\Ï\"•B)\ÉxS\İ}\ÏE¢z\ÎP«\Ê=C\Íd7B\Ó1‘½¯.sñI#	\ë‘\"\Òq’\ÃS«\\4\"I¥§k}Q\Òöjı\à\ìZ©›Ï‰\Ù»F5’ˆ1®5<w_Q\çúMc|ş;ó|\îñ>’òK7§ŒÔ¡\íŠ\Â	\nB\ÂZ=Q’#@JPš¡F\Ü]M\Ù¼©œ\Õúª\ê\ÆzEj!$/O\æ\Ì/µØ³Ya­\Å[Á2¿’3¿\ÜeÛ\Ä;C´¦°¾7Wzƒ\Ë	\Ş%º\â¾v×°¸š3Ş”xg	\ŞBÀ\Z\ÏJ\ÇPK\"ÿ\ä}ıü\ë»û9<kù\ÍG3ö\ÏxjªŒûPš=ô2B)„R)AiújJ÷U\äg\ÃxVšuuƒ–‘vøÖE.‘¾H€ğ©…g\r£}`M	Ú™r\È[{šŒ2lZC\'·ôWÀ;w\à<!x‚\äÆ±\ÚuÜ¼Mñ;?Ug°.ùß†g&#\ÊÁd\é!”ƒJ DDjE’Hú\ëò†s& ¯*w¤:\ák/·™[\ä]\Ûœ1ø\Ò‚³L.t©hOŸXcñ\Şœ#8[X\Ö¼+ô ¸V|—w‹yú>Wü\Æ{‚ó¬v£uø—\ïU\\>&ø\Ï{SöNªòõSg!D¤H)‘¤R\èD\Ñ_S;\Î\İjb\ìD§Á\ç¿ş*×ŒY\Æú \ËMñ\Â\Îb­\å\Ôb—FH„\ÃÙ’gŠI[ü\Î\Û”³®¼\×œÁy‡÷§¿ş¸ôŠ\é\ØH*#ÿøºÀ1ø\ÂÁ‡–$©ğ¥\0š ”(<@\n¤’H¥©W\å\Æ{/\âM…ğ¬$µ\æ\àÿxr•>V¹q´C–»5€ÁŒ±\Ì/wi$\è‹\\_€w8WşÖº5ñ®WB\è½#7…\ë÷H\ê÷¶8eœ2>¾«Ë¶&\Ülˆ…L¢£\'øBü´HEI€@jE%ƒs$à¡ƒ®úÜ‘y\î{WÑš\"7¥õM\á\ÎYf\nÁÒ¡°vÙµE\Å\è\Ês×»fñ\Ö\ã¬#‰-\"‹-S\0ş=öŠ Œ‹TD\àv,#U\Â_ÍŒ\à}@QJ\"”DH’ ´Bj‰Ö¢\ÊY²\İY	x\ä…\Ùğ3WU¸fK•¹\é)²Õ…\"F­ÁC[:™!\Å\ãÁ9s\Z¼u…µ\İi\ë÷¼\ÇZƒªÌ­šP„‹[»¯˜-*R[‘PVy™‹%–oš\çH>À3«CTu(]‚-‘Z!•BH\Ö? µ¸mG\ÒùĞ®”nñ\ä,OaxÛ®¢\n[\èf\r8£ñ¶¬S\ã\éy¿}Q\ÅOˆ\è¥\×\Ñ3TL.9¬EüÛ‚\Ü\à\ÃZ^½u‚ˆ¾‡®‡K+«\Ü\Ô\\\æ‰|3»c›a@I„(%QZ£¤ÇºØ‚7_]:«ÜµC/\Å\Îˆ’ö\Â­¹\É2N\r\ÆºyNğgM\Ùm)†gl\Ñ×…+5AË¦~˜\\vt²uS\Ö\ÑG‚+ÁûrDB\á	¬‡[ú¦©j\É\Ó\Ù&´(%Š®:I@r–tÎ‰€Õ®?\\Q\É\á#xX<L¶¼PLS[CğÅ€Ç—À\É\ËOû:Bœ-´£÷·–‰\Èl;0¿ZH\Şùµ˜=\Ğ>”\×\âZH„\à±\ËÍY˜1cIB\á©F&\nb¤›\Å\É/Á­,\n®÷ğ\Â-½µ,|…ly¡X\ÂñÕ®Á›oJ¹]¼$Áœ\î¬%\Ë-[\Z\à\è¼CC\èĞ³º\ë)ß£¼.¥ hÍ•Ej\Z^\ÎGI5(I¥‚‚\à=+\èlÏª<|\ßØ€\ÒE\èK7†¥\É\Ã\è\æ8E«\ÎJœ)—±b\Êñ@8­aİ¸À\Ïp\â\ØP•¼<\×÷BCBxø­yE,À\ëT’¦\ËK6£¼W\ÌP\Ñ]­£\'\Ï-\Ë-ÿô¹`\ãS­\ÌguYõ¡eQ\Ö\Û\Ş9\Â\Â$«³0UÙ€3x‰øµÁ	!\ÖŠ|(„0x‚sTp\\6”°1¡\ç\È\Ø\ï\Çrİ€5ñë‰¡THTJ	D¢\Ø\İXdÿ\âV¦}“K-dR\ße¥\í²\Õ\Î\Ûû\Èş¥Š^\ìõJT‘Š\ïğ\Ê\Ñ\×X=…i/\ã²Ÿ[¼)\Ü?˜\"eö4Á\ç—|n±\ÖsÅe\Ù%œX‘¨ˆ.”epX\ë¾C©:•¨D¢”D&”f¼–1˜8Nš!’J\r©4øŒ™û”óœuõ¬ğ¥\Ã1|ª\Ü\Ü·J­	D\0!¢¬¹\Ç‚§&=\ËË«¤ºM”\n©4BÊµ…\Ç{\í\Õ\ï\Ûj–‘º\àù¥:;k]bk¡B¡	Bd\"\ÑZ\"µ@iZ\Ëõ‚Z\Z\ØTk3\ã†Ñ‘e¯\Í\Ø¿|”p\Î\0°b\â\Ë]¿$B€¨\Ö\Ô98Op‘\íı’•:\"Á:\\–a\ÛmL§\év°\İn\á\Æœ#ºBÑ½‹Tq\ì\èr°\İ`9\à{–÷\Åø^N$I¢P‰,İ¿w,P©$I%\ãµm\ZXQGúŒ™¹lea\Å=ğ\ÃğıP¾x(š\îğ@Œ!\ÑG¼-\ÂÀXÏ–†\0©9¾T,WW\è\Í\Úô¡\\\ê.\ã\Ù\ç\ÖÁ}-¼L9\Ğn ¼%ô\Ê[-IR}\Ú\íµ<\r<9}\r!Ns¼H\éxE\ÈW91•}\åşÃœ5¼%\0\æ:ñ3mGK«ˆ®TP\Îc­g$\rŒõ)ö/¢óeš*º’‰½t\êzD\Ã\ØÀ\Ñ\å’Z›\ç³QL”$‰@WIºlÿZ–…Bi‰Eˆõ×«(b¬az¶\Õzğ%û™·‚\í-pÿ¡¸÷\ØRü/Rx\ÒjBZ«(z«\"pù0\\IX\ÍxO°\ÅX¾L¿6¶¶˜\"_û\Ş$#\×\ÕX¤Á	†¨U@%Hı·WÅ±%ø€Jû¨7ú\ÑJb³\ìkı\×\çxK{Š\Ş\0³­ğ»“­°?‘9Õ~\ÒZŠJBK®,9Í±–Bsº”.m\Ï\İ\Ëb*„µ\Õ©A%’„6;\ëmöš­­I\Ò\Â\â:Q\åg‘ş\n/(_*F”®6†A*jµ”\ç\äûÿ\ê\åø»\å/t‰±\×\ß\Ğ\Şòş€\él­r`´)¾¯¦¤®÷ƒÏ\È`U°o!¥47Œ8¢PNLˆµ	\nQ\×e¡\â‰(À•é¬’š‰\ç\é\î6\Æ*9[ú:D¥\×\â|\Í\å{0b@ª„t`­4«¡Î±Õ¾ğ\è·÷}|ª•?\Ç\é9€õkğ\çB\0À¾ùø\êöz´[†\â]i¥‚®7ğ\ŞÒ§yP<1[\çú1K³F‘&Uùò\å§ì¥±ò¼—Ëµ–¥\ØP5Ì»¯\Ú®j.VŠ{T\"‘Jœ\Ş\ĞR§¤\Í1dREE\Ã\ìŠ\å¡\ïû7/=ùß€z	öL\ë÷{“\è?ú‘§¦\ã·T\Û5o\Ò\Õ*I­A‘ªå‰™:(\Å5£– JKK\Ô\å*Á¬\Ë\å\ÅwI#µœgZT’\È\Åı+D©kŠÔ¢’:•1”N\Ñ\"\â[s|õ±\×şøk/LÿP+qõ@‹3\ÈP\ëˆ\ç´E\æÅ™ğHUÄ‰\İ\ã\áZ]­¡jV=¹ñ<vªk\Æ,Cu@¥õµ%ø\Ò;’u$$™(†«+RmOpq\ß<ı‰%DAŒ!I}ˆ´¹©´¿:ËŸ~cú}q_şk@¤\ë\0+\Ş\è	=p\çJ€\àŸŸ›,_9nª\ÕSTm€ÃŠ\ïO*f2\ÍM\r¨\ÒÚ²Œÿ’¥{š \×)H)\ÙXiq(\ÛÄœ\é\ç²ú©\â¡IJs”¤Ö’TyZó§øì£§şøK/º^‚­”€\×W\ëzÏ•\Ü\Û! \Õ\éş¹ğ\è\É9»zÙ°{÷PS%ÍCu\Å_¿’°u rÑ\ÃGQ–\È2–\×\â_‹bGŠµm4AM\Zš*\ã\éÎ¥4Ï\r\n\Õ7‚T)RJ*d}õd\ç?ı\Í\ì¿ıÛ£\á?–À{¢\×úƒ¬ß³|^~ó69]>´vb%~ç©£\æ\É~™]¹¹\é7\îÚ”²˜§|ód[vVh\ÔT±‹Dû„(–±{a\×C±\"\ê\n›š’L6\Ø×™\à\â\Ã@% UÄ­.ğ\è÷^\Û÷{»ò\ëxhR¸şz‹÷½\Õ}	<,\ë¶Zœ+U\nµ­FAã–­ò¾{o\ìû\ä%ƒc¸wª\æS7Z|ŒX\çˆ\Ş½‡X\Ôù‘P\ìü¢@i¤.ö+)°Aò\ç\'/¡®\á\'†Ÿ\ãÀ¡©™/}o\å\ß=\î\Ğ)Ÿ\Öu\Î8\ï¹zF1/˜•\çk©ğ\í\ì\Õ%=$`ªŠ‰Û¶\Ë{¯\ß\ÙüğwVwNÜ´Có—tˆ\"ÁGyz§\Çúb¢\'Ô…§(	ZD’˜±Fñ\à‰-Ç§÷?ù\Ğ\Ş#\Ş\rL®{^\à€C	¶<[wş†©±·»WXS¨nu]—@¨J\ÆÆš\Õ[\Ò\r\Û~üı»\ä-\ïÛ¼:2Ğ¨P©V‘Z#„\\Ko1Šb\'‰/fq–V²p|º5¹÷X{\ß\Ş\æ±\ÃK<cB\\(Ÿ¥\×ıA€§­m8\Ã\âç›€õDôÂ¢Gˆ.œª¤¶u´b\'6õù‰ñ¦ºhcS\Õ*ª‘‹8M\'­\é?wj\Å\\Gf»°\Ôû\ås\Üİ¬\ë\×[z}X¼i;\ßÿ_ §¶=\Ï\è³ş{}FïµE\×ÿ^o\íõ\à\Ì\×\ß\à3\Û;ı_fÖ— š7–¤\ësf;3¾\ß\ìÚ…v¡]hÚ…v®\íÿ¼o–K¦ó–\è\0\0\0\0IEND®B`‚','Ğ¢Ğ°Ñ‚Ğ°Ñ€ÑÑ‚Ğ°Ğ½',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `basketball` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-30 19:13:13
