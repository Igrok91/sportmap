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
  `сreator` varchar(45) NOT NULL,
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
INSERT INTO `basketball` VALUES (1,'basket','55.750457','48.739340','https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos','https://vk.com/igor_ryabtcev','Innopolis','Sport','12','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0@\0\0\0@\0\0\0�iq\�\0\0�IDATx�\�y�\�u\�w\�~˼y�`�\\\0n\�N\�%.�$\�Vb\�2Eǎd1%+NŊ\�JU6W\�\�r\�)\'q\�.��Td%���\�eڌIʊH-%. � @l\�f\�\�\�}\��\��CP�(\�?���x\��^O���s�s\��\�.�\�B�\�.��o�x�p\�N����j\�p�\�F]_72�\�\�\�8gjͿ~f��\���We�k,Y\�:�g6\�x5�\�\���u\�/��y\'\�\�#\�c�Ե\�\��\��\��\��U͆��z�\�V���=\�\�\�M11w]\�\�\�[*\�Z���,���l�Y\�^89\�}h~\��\��<��\�y\�	��W%�\�\�\��g�]<�ёF��)Bi�h�\�K9��\�\�\�0\���!�ޚ q\�N\�C\��@�#Ĉ��\�e\�Mu�fr6����R�\��|\��F�G/\�\�7��=�~v\�\�6��oDՆ�\�\Z�|���\�#\��Եܺ�N�]Z+\�\�EL{\�]\�;O�<��>|\0\"1D�VL8t��\'f��\�\��\��x\��B�?�F��o\��﮼��\�\�\�Q��Th8�\�����\��}#[�\�N���,\��ɰ�E�˳\�\�5\"����\�\0\��\��\�ڿ�\���\�w[���4/\�Q���?��OL\\{;�o1F�\�PxfV\"�{� }\���;�\�H\"�,#:K�9�Y�\��\��%XC\�^��4�\�v\�H�눐�]\�KG;_xm\�|�+GY9W\�\\o�m�\�[&��˟���\�|\��A��\�\�PZ�\�O��*ZX\�{����\�:��=\�@�18�P��J��`�\"Z��%@1\�c\�\�{6���Y�F�G��u_���~\�n��[�/��$Q�\�SL/,��\�`�Oc�+�-��\��AD\� 8j\�\Z��\�L1\�Nym5\�dK����}BD�j\�\�A�]\�ؔ���_�\�=A��7�\�6w\\:z�֫���\�\�&�\�GM�$O\\\�壳�\�m�\�\�tsD`-�D\\����+�b\�7�\�6��\�\��\��\�+@\n�J�i�\�ܠ\�36t�؆\����Z\��\�\�;J�\��\�\����n\�ۺaۄ��1v��\�\�7��\�\�\�\\��I�;Ě\�\�{\�!���TR㛯\��\��9\�\�\�v�\�Gn\�g���\�@*!3�V\�Zr�\�p\�5\�\�i�o��.�\0\�/�c|�\n~\�\��\�O�;r5�SSԒ��@@\�\0B���\'�\���\�GDO�A BAV<�\�c)NV�·\�y\��\�ܲ3\�\�\�\�\�\�@\�Ⱥ)Y��s�$1(�O�\�\�N�\\�<;iy����uc��\�θ?<\�\�3�Uw\�q\�om\�s�\\��x�+�\0�(AH�\�d\�?6ϝ׌Ьv-�H\"JH�*\\؅�%�H<AV�\�\�gx�ɣ|�#��\�*&7�;9\�x�� q\�B$����\�\�ү��T��ힽ�\�o�|\��W\��}畀+vV~��;>8l�rja%ϝș^\�X\\\�ȍe�\�\�{\�c�N��gOC�\�I\�S���b��o\n�kPW S͗��̣O\�\�r�\�.��\�ʰ֕٢�!dy�S�\�EB\0׏\�\�\Z�7���7>�K|`۞?| \���\�O1�\�\���\��\n�\�#G�;\�|I�\r��\�9�\�\�\�\�,�f\�.�\�;\�en9#����\�\��*\�G+�\�\'��\�W�3�\�)\�\�\"^e��=��\�?q%%>B�m�\�g>v�������?��\�\r\�]�[���^\�dt@Sтj*yx\�\n}x\�\�M\��wez\��\�;K7\�Y\\\��\�\�*/]\�c|\�6��a�U\�\�\�탒�\nt�\'�\�$Ĳ$�d�A\�Rg\">Dj�`c��U�?��Zܽ��m��;��\��=cL-;\�x�%uȕnࡧg�bsʮ\�U\�]�s\�\�X�-:\�ӗF6jn��\�e����\�K\�ި8|j��>9\��i\�`M1\�\�b�/�\"8\0��4e�>\�\�\"BB��.ڐ���_\�\�\��K\��=���\"�\����CS+��\�\Z\�Y�$Zp|Ʋ\�\�r\�\�\�\Z�e�=1x(+�\�Y���\��҉Y��\�\�ǩ%�\�^\\\�O\��/�l�w\�s\�u��GZ&�\�01�iC�HD\�X\�*D!\�\n��O\��{g\�\'\��\�G�S\�6V�;�40A�\�\�6\�\�\�c�\�\�;�l1P��5X��)j}\�\��x��\�\�{�?�\�\�!\�@M b\�\����\�ȯ\�1��\�K�\��\'�\�3]b�$�L�!\"bYIG��\�2\�\"�B)\�xS\�}\�E�z\�P�\�=C\�d7B\�1���.s�I#	\�\"\�q�\�S�\\4\"I��k}Q\��j�\��\�Z��ω\��F5��1��5<w_Q\��Mc|�;�|\���>��K7��ԡ\�\�	\nB\�Z=Q�#@J�P��F\�]M\����\���\�\�zEj!$/O\�\�/�سYa�\�[�2��3�\�eې\�;C����7Wz�\�	\��%�\�vװ��3ޔxg	\�B�\Z\�J\�PK\"�\�}��\��9<k�\�G3�\�xj���P�=�2B)�R)Ai�jJ�U\�g\�xV�uu���v�ցE.���H������g\r�}`M	ڙr\�[{��2lZC\'��W�;�w�\�<!x�\�Ʊ\�uܼM�;?Ug�.�߆g&#\��d\�!���J DDjE�H�\��s&��*w�:\�k/���[\�]\��1�\���L.t�hO�Xc�\��#8[X\��+���V|��w�y�>W�\�{��v�u��\�U\\>&�\�{S�N���Sg!D�H)��R\�D\�_S;\�\�jb\�D��\��*׌Y\�� \�M�\�\�b�\�\�b�FH�\�ْg�I[�\�\�����\���y�������\�\�H*#�����1�\����$��\0� �(<@\n��H��W\�\�{/\�M��$�\�\��xr�>V�q�C��5����\�/wi$�\�\\_�w8W�ֺ5��WB\�#7�\��H\���8e�2>��˶&\�l��L��\'�B��HEI�@jE%��s$ࡃ��ܑy\�{Wњ\"7��M\�\�Yf\n�ҡ�vٝ�E\�\�\�s׻f�\�\�#�-\"�-S\0�=�� ��TD\�v,#U\�_͌\�}@QJ\"�DH����Bj�֢\�Y�\�Y	x\�\��3WU�fK��\�)�Յ\"F��C�[:�!\�\��9s\Z�u��\�i\���\�Z����̭�P��[���-*R[�PVy��%�o�\�H>�3�CTu(]��-�Z!�BH\�?����mG\��Ю�n�\�,Oaxۮ�\n�[\�f\r8��S\�\�y�}Q\�O��\��\�\�3TL.9�E�ۂ\�\�\�Z^�u������K+�\�\�\\\�|3�c�a@I�(%QZ��Ǻ؂7_]:�ܵC/\�\����\���\�2N\r\��yN�gM\�m)�gl\�ׅ�+5A˦~�\\vt�uS\�\�G�+��rDB\�	��[���j\�\�\�&��(%��:I@r�tΉ�ծ?\\Q\�\�#xX�<L��PLS[C�ŀǗ��\�\�O�:B�-��������\�l;0�ZH\����=\�>�\�\�ZH�\�\�͍Y�1cIB\��F&\nb��\�\�/���,\n���\�-��,�|�ly�X\��ծ��oJ��]�$��\�%\�-[\Z\�\�CC\�г��\�)ߣ�.� h͕�Ej\Z^\�GI5(I���\�=+\�lϪ�<|\�؀\��E\�K�7��\�\�\�\�8E�\�J�)��b\��@8�aݸ�\�p\�\�P��<\���BCBx���yE,�\�T����\�K6��W\�P\�]��\'\�-\�-���`\�S�\�guY��eQ\�\�\�9\�\�$��0Uـ3x����	!\��|(�0x�sTp\\6��1��\�\�\�\�\�r݀5�뉡T�HTJ	D�\�\�Xd�\�V�}�K-dR\�e�\�\�\�\��\�����^\��JT��\��\�\�\�X�=�i/\��[�)\�?�\"e�4�\��|n�\�sŐe\�%�X���.�epX\�C�:��D��D&�f��1�8N�!�J\r�4������u���\�1|�\�\��J�	D\0!���\���&=\�˫��M�\n�4Bʵ�\�{\�\�\�\�j���\���:;k]bk�B�	Bd\"\�Z\"�@i�Z\���Z\Z\�Tk3\�ёe�\�\��|�p\�\0�b\�\�]�$B��\�\�98Op�\����:\"�:\\�a\�mL��\�v�\�n\�\��#�Bѽ�Tq\�\�r�\�`9\�{��\��^�N$I�P�,ݿw,P�$I%\�m\ZXQG����lea\�=�\���P�x(�\��@�!\�G�-\��Xϖ�\0�9�T,�WW\�\�\���\\\�.\�\�\�\��}-�L9\�n��%�\�[-IR}\�\�<\r<9}\r!Ns�H\�xE\�W91�}\��Ü5�%\0\�:�3mGK���TP\�c�g$\r��)�/��e�*����t\�zD\�\��\�\�Z�\�QL�$�@WI�l�Z���Bi�E��׫(�b�az�\�z�%����\�-p����\�R�/Rx\�jBZ��(z�\"p�0\\IX\�xO�\�X�L�6���\"_�\�$#\�\�X��	��U@%H��Wű%��J��7�\�Jb��\�k�\�\�xK{�\�\0��𻓭�?�9Ձ~\�Z�JBK��,9ͱ�Bs���.m\�\�\�b*��\��A%���6;\�m����I\�\�\�:Q\�g��\n/(_*F���6�A*j��\�\���\�\���\�/t��\�\�\�\����\�l�r`�)�������ρ\�`U�o!�47�8�PNL��	\nQ�\�e�\�(��鬒��\�\�\�6\�*9[�:D�\�\�|\�\�{0b@��t`�4��αվ�\��}|��?\�\�9��k�\�B\0����\��z�[�\�]i���7�\�ҧyP<1[\��1K�F�&U��\�쥱�˵��\�P5̻�\��j.�V�{T\"�J�\�\�R��\�1dREE\�\�\�\��7/=�߀z	�L\���{�\�?����\�T\�5o\�\�*I�A���剙:(\�5�� JKK�\�\��*��\�\�\�wI#��gZT�\�\��+D�k�Ԣ�:��1�N\�\"\�[s|��\���k/L�P+q�@�3\�P\��\�E\�ř�HUĉ\�\�\�Z]��jV=��<v��k\�,Cu@���%�\�;�u$$�(��+R�mOpq\�<��%DA�!I}������:˟~c�}q_�k@�\�\0+\�\�	=p\�J�\����,_9n�\�STm�Ê\�O*f2\�M\r�\�ڲ����{� \�)H)\�Xiq(\�Ĝ\�\���\�I�Js��֏�TyZ��죧��K/�^����\�W\�zϕ\�\�! \�\����\�\�9�zٰ{�PS%́Cu\�_���u rѐ\�GQ�\�2�\�\�_�bG��m4AM\Z�*\�\�Υ4ώ\r\n\�7�T)RJ*d}�d\�?�\�\��ۣ\�?��{�\����߳|^~��69]>�vb%~穣\�\�~�]��\�7\�ڔ���|�d�[vVh\�T��D���(��{a\�C�\"\�\n���L6\�י\�\�\�@%�Uĭ.�\��^\��{��\�xhR��z���\�}	<,\�Z�+U\n��FA㖭�{o\��\�%�c�w��\�S7Z|�X\�\���X\���P\���@i�.�+)�A�\�\'/��\�\'��\�����/}o\�\�=\�\�)�\�u\�8\�zF1/��\�k��\�\�\�%=$`���۶\�{�\�\���wVwNܴC��t�\"�Gyz�\���b�\'ԅ�(	ZD���F�\��-ǧ�?�\�\�#\�\rL�{^\���C	�<[w������WXS�nu]�@�J\�ƚ\�[\�\r\�~���\�-\�ۼ:2ШP�V�Z#�\\Ko1�b\'�/fq�V�p|�5��X{\�\�\�\�K<cB\\(��\��A���m8\�\�盀�D�¢G�.����u�b\'6����hcS�\�*���8M\'�\�?wj\��\\Gf��\��\�s\�ݬ\�\�[z}X�i;\��_���=\�\���{}FﵞE\��^o\��\�\�\�\�\�3\�;�_f֗��7��\�sf;3�\�\�څv�]hڅv�\���o�K��\�\0\0\0\0IEND�B`�','Татарстан',NULL,NULL,NULL,NULL,NULL);
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
