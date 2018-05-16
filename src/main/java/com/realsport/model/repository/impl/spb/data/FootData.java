package com.realsport.model.repository.impl.spb.data;

/**
 * Created by IgorR on 08.07.2017.
 */
public enum FootData {
   /* PLAYGROUND_1("1", "Школа 29", "55.750338", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис","Кораблестроителей", "21", "true"),
    PLAYGROUND_2("2", "Школа 29", "55.750008", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис", "Кораблестроителей", "22", "true"),
    PLAYGROUND_4("4", "Школа 29", "55.750118", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис", "Кораблестроителей", "23", "true"),*/
    PLAYGROUND_5("5", "Школа №12", "59.944858", "30.219880", "https://chat.whatsapp.com/GA8i4Xyfm0uLMVsLDgGGNW", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Кораблестроителей", "21", "true"),
    PLAYGROUND_6("6", "Светлановский, 5", "60.004867", "30.335858", "https://chat.whatsapp.com/B5jwqxaoBdN2sACYdR9SQb", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Светлановский пр.", "5", "false"),
    PLAYGROUND_7("7", "Школа №90", "60.033307", "30.324836", "https://chat.whatsapp.com/7KBJyUUDFt090VrMI3sV3s", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Сикейроса", "5", "true"),
    PLAYGROUND_8("8", "Гимназия №73", "60.040004", "30.327709", "https://chat.whatsapp.com/8yrZPs9s8vE52Gi2pbCql9", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Энгельса", "115", "true"),
    PLAYGROUND_9("9", "Лицей №263", "60.046712", "30.333845", "https://chat.whatsapp.com/LrThczVjQn9ATQCsqEwO4I", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Есенина", "22", "true"),
    PLAYGROUND_10("10", "Опочинина, 10", "59.932666", "30.237443", "https://chat.whatsapp.com/AWjKELuSLTd8bC49SdrPNF", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Опочинина", "10", "false"),
    PLAYGROUND_11("11", "Школа №2", "59.944071", "30.222838", "https://chat.whatsapp.com/1eqYzWTEbjWGFlOD1EwM0K", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "32к2", "true"),
    PLAYGROUND_12("12", "Школа №518", "60.047551", "30.335708", "https://chat.whatsapp.com/7yqYAkIOs8W59eS1ZrB4yc", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Есенина", "24", "true"),
    PLAYGROUND_13("13", "Карташихина улица, 19", "59.935642", "30.240288", "https://chat.whatsapp.com/DLiTL30SQDxIsM7Ikckk7J", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Карташихина ", "19", "false"),
    PLAYGROUND_14("14", "Школа №6", "59.930148", "30.247321", "https://chat.whatsapp.com/8tIr8EL5qXCLud4dnK028u", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Шевченко ", "3А", "true"),
    PLAYGROUND_15("15", "Школа №4", "59.929510", "30.251619", "https://chat.whatsapp.com/KWh5WtwC9Ks9fz2VfEPPik", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Большой", "88Б", "true"),
    PLAYGROUND_16("16", "Гимназия №642", "59.936068", "30.237155", "https://chat.whatsapp.com/Ig7pgA7FAeG3DFDZBrNdyO", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Опочинина", "35", "true"),
    PLAYGROUND_17("17", "Гимназия №24", "59.943649", "30.282403", "https://chat.whatsapp.com/DF2Rdh1RamLAgogZTigEHC", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Средний пр.", "20", "true"),
    PLAYGROUND_18("18", "7 линия, 66", "59.945104", "30.274805", "https://chat.whatsapp.com/GBPEafPLONCHabhDpVufUt", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "7-я линия", "66A", "true"),
    PLAYGROUND_19("19", "Школа №29", "59.944677", "30.267884", "https://chat.whatsapp.com/4lFagjCuGsj1WJSmd8nnfo", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Малый пр.", "34A", "true"),
    PLAYGROUND_20("20", "Школа №11", "59.941782", "30.264462", "https://chat.whatsapp.com/Li5NwMlwwFe2YdPTaQaXb4", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "16-я линия", "55A", "true"),
    PLAYGROUND_21("21", "15-я линия, 20", "59.937703", "30.270151", "https://chat.whatsapp.com/BDWZ7ny5knIEnTB54Ai9IM", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "15-я линия", "20", "false"),
    PLAYGROUND_22("22", "19-я линия, 20", "59.936022", "30.265179", "https://chat.whatsapp.com/4LmP3gMeoqG1KXHECeyy7b", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "19-я линия", "20", "false"),
    PLAYGROUND_23("23", "Школа №17", "59.936835", "30.264294", "https://chat.whatsapp.com/CBKJPgTyo1B0OZxvjLSgfE", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "19-я линия", "22А", "true"),
    PLAYGROUND_24("24", "Школа №15", "59.940356", "30.241166", "https://chat.whatsapp.com/GvV76rHqt4sDuAJziOy4st", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Шевченко", "35А", "true"),
    PLAYGROUND_25("25", "ул. Наличная, 45", "59.943922", "30.232568", "https://chat.whatsapp.com/LHvqjS1Vim4CW0n2tRbspI", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "45", "false"),
    PLAYGROUND_26("26", "Школа №19", "59.940336", "30.237352", "https://chat.whatsapp.com/HN1WdEAZ0r1IfpImwpocRy", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Гаванская", "54А", "true"),
    PLAYGROUND_27("27", "ул. Наличная, 29", "59.938797", "30.234423", "https://chat.whatsapp.com/Ay7CnETbuFP95j8W0BQYG4", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "29", "false"),
    PLAYGROUND_28("28", "Малый пр., 90", "59.938988", "30.225296", "https://chat.whatsapp.com/FLu6c8ctlt1CGbscuGMVi5", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Малый пр", "90", "false"),
    PLAYGROUND_29("29", "Гимназия №642", "59.940727", "30.212377", "https://chat.whatsapp.com/KJn3xDjGVFY5etIfQLN4PG", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Морская наб.", "15к2", "true"),
    PLAYGROUND_30("30", "Боцманская ул.", "59.942727", "30.211523", "https://chat.whatsapp.com/6uu34qhxLoLF223YJPU2tS", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Боцманская ул.", "", "false"),
    PLAYGROUND_31("31", "Наличная, 36к6", "59.946947", "30.220369", "https://chat.whatsapp.com/KrkocjUV2iWHxOMh62XI2n", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "32к6", "false"),
    PLAYGROUND_32("32", "Гимназия №74", "59.998909", "30.350464", "https://chat.whatsapp.com/HrnK7fnjEV59YYlFIzpf3P", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Болотная", "6А", "true"),
    PLAYGROUND_33("33", "Лицей им. Неболсина", "59.998498", "30.353189", "https://chat.whatsapp.com/Dz6G4W1NLuPLZsq5UBm9Kt", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Муринский пр.", "43", "true"),
    PLAYGROUND_34("34", "Школа №145", "60.015645", "30.374056", "https://chat.whatsapp.com/FFPRXEGqjAEAc6X5pczksC", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Науки пр.", "13к4", "true"),
    PLAYGROUND_35("35", "Школа №57", "60.009088", "30.286757", "https://chat.whatsapp.com/7Vvzt3BC0YiHcLPwFXOj2f", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ал. Поликарпова", "7", "true"),
    PLAYGROUND_36("36", "Приморский техникум", "60.009012", "30.275999", "https://chat.whatsapp.com/3S2fpMa4PzuK40vRH0Wxgj", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Сизова", "15А", "true"),
    PLAYGROUND_37("37", "Гимназия №52", "60.001798", "30.285585", "https://chat.whatsapp.com/Jf1jmZHQ1IGGGwSutU8fiJ", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Богатырский", "7к4", "true"),
    PLAYGROUND_38("38", "Гимназия №66", "59.998315", "30.291927", "https://chat.whatsapp.com/7cxNjwVIQWw2PpceN5eSW9", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Аэродромная", "11к2", "true"),
    PLAYGROUND_39("39", "Школа №644", "60.001215", "30.260533", "https://chat.whatsapp.com/32cDAfK9F5hJ4s8wlg62Fm", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Богатырский", "19А", "true"),
    PLAYGROUND_40("40", "Школа №618", "60.003790", "30.252694", "https://chat.whatsapp.com/EC55kXY5RSe60GiUaq2Yju", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Гаккелевская", "24А", "true"),
    PLAYGROUND_41("41", "Школа №598", "59.999731", "30.238354", "https://chat.whatsapp.com/LJIisYgI4blIz3ezG3MKFi", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Ситцевая", "15", "true"),
    PLAYGROUND_42("42", "Школа №596", "60.006225", "30.241198", "https://chat.whatsapp.com/8C5xED5cD0JDHgSCIqn98d", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Камышовая", "18А", "true"),
    PLAYGROUND_43("43", "Школа №582", "60.011594", "30.238547", "https://chat.whatsapp.com/2IXlWN8GgHAImWBAg4KpXi", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Ильюшина", "15к3А", "true"),
    PLAYGROUND_44("44", "Савушкина, 107", "59.985535", "30.240571", "https://chat.whatsapp.com/9PR8oIUZ3LWBosBZkzTSS9", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Савушкина", "107к1", "false"),
    PLAYGROUND_45("45", "Школа №640", "59.985972", "30.237954", "https://chat.whatsapp.com/JDrl8h3NpZyDXuBAPw4Iz2", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Савушкина", "111к2", "true"),
    PLAYGROUND_46("46", "Школа №630", "59.998369", "30.213722", "https://chat.whatsapp.com/KpPbryXCNqPAE0o4oCxhpQ", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Мебельная", "21к3", "true"),
    PLAYGROUND_47("47", "Школа №655", "60.002607", "30.214195", "https://chat.whatsapp.com/J2zXFHFqYHr2U8xMEzqbPG", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Оптиков", "35к2А", "true"),
    PLAYGROUND_48("48", "Школа №320", "60.006227", "30.201079", "https://chat.whatsapp.com/F0fS6Z0oT475zgWmNr9GM4", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Оптиков", "47к5А", "true"),
    PLAYGROUND_49("49", "Яхтенная, 6", "59.986250", "30.213245", "https://chat.whatsapp.com/DfOCY4rbXpUIa8n2U536sW", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Яхтенная", "6к1", "false"),
    PLAYGROUND_50("50", "Школа №601", "59.985042", "30.209108", "https://chat.whatsapp.com/JwAyLKjl4wrBXd2QPjpE93", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " пр. Приморский", "143к3А", "true"),
    PLAYGROUND_51("51", "Школа №123", "59.982995", "30.349231", "https://chat.whatsapp.com/0IkMvXIhBwyED3YvvVNEnN", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Александра Матросова", "11", "true"),
    PLAYGROUND_52("52", "Школа №653", "59.985599", "30.419482", "https://chat.whatsapp.com/8rme91omxoDKoyxqVTxhTG", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " пр. Мечникова", "5", "true"),
    PLAYGROUND_53("53", "Гимназия №192", "59.986358", "30.420590", "https://chat.whatsapp.com/3x91O9saD1hDdO5n2HhtvJ", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Брюсовская ", "10", "true"),
    PLAYGROUND_54("54", "Школа №146", "59.981540", "30.409657", "https://chat.whatsapp.com/K6Gsx4z4pWg0RqfkxGbdpX", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Замшина ", "31к2", "true"),
    PLAYGROUND_55("55", "Школа №186", "59.980996", "30.400621", "https://chat.whatsapp.com/1tSy3BX6vTB6MheaXL9daQ", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Замшина ", "58к2", "true"),
    PLAYGROUND_56("56", "Школа №138", "59.968353", "30.400795", "https://chat.whatsapp.com/JVhFNnNRD5m7NyGGURdLJg", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " пр. Полюстровский ", "33к3", "true"),
    PLAYGROUND_57("57", "Школа №139", "59.966954", "30.406503", "https://chat.whatsapp.com/0dmw22i2FuD9SDr2shw95m", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " пр. Пискаревский", "14", "true"),
    PLAYGROUND_58("58", "Школа №188", "59.971075", "30.431585", "https://chat.whatsapp.com/IhEnm062jWpA5JWC1UWkzq", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Стасовой", "4к2", "true"),
    PLAYGROUND_59("59", "Ординарная, 5", "59.965669", "30.308325", "https://chat.whatsapp.com/8PVuPLSYkQ15kKTi7z4EGK", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", " ул. Ординарная", "5", "false"),
    PLAYGROUND_60("60", "Бол. Пушкарская, 17", "59.958780", "30.303952", "https://chat.whatsapp.com/BZQ5ZtRWBdb1AukVlKu444", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Бол. Пушкарская", "17", "false"),
    PLAYGROUND_61("61", "Школа №87", "59.955935", "30.306617", "https://chat.whatsapp.com/KcFakdDE2ucG8pIDZYwBB6", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Введенская", "16", "true"),
    PLAYGROUND_62("62", "Съезжинская, 33", "59.953874", "30.303722", "https://chat.whatsapp.com/53WXchNYxSR6HN56HmedbV", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Съезжинская", "33", "false"),
    PLAYGROUND_63("63", "Съезжинский пер", "59.955317", "30.290229", "https://chat.whatsapp.com/8u2gXQxTHnQCUFKROiF5gk", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Съезжинский пер", "", "false"),
    PLAYGROUND_64("64", "Школа №50", "59.957415", "30.291730", "https://chat.whatsapp.com/Jyc5Z9M5Y8D3uPUE5xlSVR", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Малая Разночинная", "2-4", "true"),
    PLAYGROUND_65("65", "Школа №51", "59.962838", "30.292081", "https://chat.whatsapp.com/7LLP6H1oMq21wxXIv1KhU5", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Чкаловский", "22А", "true"),
    PLAYGROUND_66("66", "Гатчинская, 22", "59.962529", "30.297638", "https://chat.whatsapp.com/1870FZvuLS76iS4xE0MgUl", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Гатчинская", "22", "false"),
    PLAYGROUND_67("67", "Школа №18", "59.953692", "30.247794", "https://chat.whatsapp.com/J1Q7z08h0KjI7aNNpp7LON", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. КИМа", "11Б", "true"),
    PLAYGROUND_68("68", "Железноводская, 60", "59.948821", "30.238703", "https://chat.whatsapp.com/CMjLokQEBEg2XUm5gotYmL", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Железноводская", "60", "false"),
    PLAYGROUND_69("69", "Железноводская, 29", "59.951155", "30.239611", "https://chat.whatsapp.com/1k3iQC3UjOb0RX77rh3eDy", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Железноводская", "29", "false"),
    PLAYGROUND_70("70", "Академ. Гимназия СПбГУ", "59.952043", "30.236676", "https://chat.whatsapp.com/7pmfn01CbDA2XgHdLh2r1M", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пер. Каховского", "9", "true"),
    PLAYGROUND_71("71", "Школа №16", "59.952950", "30.226081", "https://chat.whatsapp.com/DwdmZMTzZ9k9s3KoFNWDFe", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "44к5", "true"),
    PLAYGROUND_72("72", "Наличная, 40к5 ", "59.951271", "30.228115", "https://chat.whatsapp.com/AC0oPxZPkat2aPd4aWHogt", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "40к5", "false"),
    PLAYGROUND_73("73", "Кораблестроителей, 29к2 ", "59.952208", "30.221667", "https://chat.whatsapp.com/CioDOPEANZrCoxk5Qk6bwH", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "29к2", "false"),
    PLAYGROUND_74("74", "Кораблестроителей, 37г ", "59.955401", "30.228391", "https://chat.whatsapp.com/KHGpkwTbdD6AeBYUEv1SGa", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "37г", "false"),
    PLAYGROUND_75("75", "Кораблестроителей, 39", "59.954433", "30.231831", "https://chat.whatsapp.com/E21wyGPYprMKWFBCdvjy2t", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "39", "false"),
    PLAYGROUND_76("76", "Кораблестроителей, 46к1", "59.957007", "30.232481", "https://chat.whatsapp.com/9EO9c2qzi2k08zLR3Qz3Se", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "46к1", "false"),
    PLAYGROUND_77("77", "Школа №10", "59.958606", "30.226107", "https://chat.whatsapp.com/FW2p8moZEnw2QKBzqQUMBj", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "44к2", "true"),
    PLAYGROUND_78("78", "Школа №31", "59.956568", "30.217847", "https://chat.whatsapp.com/Ku7dhpDUuoBDvBekx1HrWd", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "38к2", "true"),
    PLAYGROUND_79("79", "Кораблестроителей, 38к3", "59.956421", "30.215587", "https://chat.whatsapp.com/80EhEf7Fjwk5A8UIxttc8n", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кораблестроителей", "38к3", "false"),
    PLAYGROUND_80("80", "Школа №515", "59.945405", "30.417181", "https://chat.whatsapp.com/2F0xQcNjo8hK6MiH7zwbms", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Шепетовская", "5А", "true"),
    PLAYGROUND_81("81", "Школа №562", "59.953627", "30.464966", "https://chat.whatsapp.com/CH30JRfb51A6fR4JkUEOcP", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Ириновский", "17к5", "true"),
    PLAYGROUND_82("82", "Гимназия №664", "59.947781", "30.467306", "https://chat.whatsapp.com/7aEmsdx3cr6CLTqcKwQiVP", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Ударников", "17к2", "true"),
    PLAYGROUND_83("83", "Школа №187", "59.954427", "30.489086", "https://chat.whatsapp.com/KIFEN0RwOsIJWZaEZrvebP", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Энтузиастов", "46к3А", "true"),
    PLAYGROUND_84("84", "Школа №134", "59.958039", "30.488941", "https://chat.whatsapp.com/6eUpJuScfZa3T56LPtBtCx", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Отечественная", "5А", "true"),
    PLAYGROUND_85("85", "Школа №323", "59.927365", "30.480541", "https://chat.whatsapp.com/DyI3qePTI0JG7eAwnTpvhE", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Солидарности", "1к2А", "true"),
    PLAYGROUND_86("86", "Школа №625", "59.921826", "30.449133", "https://chat.whatsapp.com/2rffJTfZJOb0xqpkmzL9VW", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Джона Рида", "6А", "true"),
    PLAYGROUND_87("87", "Школа №333", "59.912367", "30.457286", "https://chat.whatsapp.com/JkNuvc7lYwfHc4Zh34Lj6V", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Белышева", "6А", "true"),
    PLAYGROUND_88("88", "Школа №346", "59.913391", "30.468178", "https://chat.whatsapp.com/JSPGw4ZdUvh2Ro56K9rebX", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Подвойского", "18к3", "true"),
    PLAYGROUND_89("89", "Школа №268", "59.917019", "30.477640", "https://chat.whatsapp.com/64rJprWFm34JwhWidrSjfs", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Большевиков", "4к2А", "true"),
    PLAYGROUND_90("90", "Школа №332", "59.918796", "30.486423", "https://chat.whatsapp.com/8afeVoDy5T887nI5Sq31Io", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Товарищеский ", "10к2", "true"),
    PLAYGROUND_91("91", "Школа №593", "59.920277", "30.489296", "https://chat.whatsapp.com/7kIjsihMSEgKmRJKdioLiT", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Солидарности", "11к2", "true"),
    PLAYGROUND_92("92", "Школа №341", "59.908514", "30.477926", "https://chat.whatsapp.com/DmxgomrG1NhFx5W37R4oLD", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Дыбенко", "24к4", "true"),
    PLAYGROUND_93("93", "Школа №26", "59.913289", "30.493316", "https://chat.whatsapp.com/H7LNCl3TJ9s4LJgkFMeqeD", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Товарищеский", "28к2А", "true"),
    PLAYGROUND_94("94", "Школа №23", "59.906891", "30.470872", "https://chat.whatsapp.com/CDGoiXSRw7aLf0rz1UKKs6", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Дыбенко", "20к4", "true"),
    PLAYGROUND_95("95", "Школа №339", "59.903466", "30.461811", "https://chat.whatsapp.com/FzAFBv3sA0w0VjruqIXyoe", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Дыбенко", "12к2", "true"),
    PLAYGROUND_96("96", "Школа №34", "59.901822", "30.479862", "https://chat.whatsapp.com/JuscaXhDunJBuCFyJbos9p", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Шотмана", "12к3", "true"),
    PLAYGROUND_97("97", "Школа №163", "59.943565", "30.380501", "https://chat.whatsapp.com/7SE1sCCsaOl4ZdGQbvRGCV", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кирочная", "54", "true"),
    PLAYGROUND_98("98", "Гимназия №166", "59.936831", "30.366883", "https://chat.whatsapp.com/ADRNlIGeDbz1XZw0Z7Q49e", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. 8-я Советская", "3А", "true"),
    PLAYGROUND_99("99", "Гимназия №171", "59.938074", "30.354427", "https://chat.whatsapp.com/BGmXUgx0EKYDHQVtpDBvdA", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Маяковского", "26", "true"),
    PLAYGROUND_100("100", "Школа №222", "59.937228", "30.324145", "https://chat.whatsapp.com/6mTyYaNwcD29AR28ko9pnN", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Невский", "22-24Б", "true"),
    PLAYGROUND_101("101", "Бол. Подьяческая, 13", "59.924991", "30.304921", "https://chat.whatsapp.com/EgVH7p1H7wuAwnrzvKueNh", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Бол. Подьяческая", "13", "false"),
    PLAYGROUND_102("102", "Гимназия №168", "59.923683", "30.381796", "https://chat.whatsapp.com/H7IzHT2vBoP2IvYwgAvQf2", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Невский", "169А", "true"),
    PLAYGROUND_103("103", "Школа №308", "59.924647", "30.334675", "https://chat.whatsapp.com/Hb37284Y6yxLLR767yh7Kg", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Бородинская ", "8/10", "true"),
    PLAYGROUND_104("104", "Лицей №281", "59.913359", "30.303166", "https://chat.whatsapp.com/BCmnVOBhP48GqqUHmzGQen", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. 10-я Красноармейская", "5А", "true"),
    PLAYGROUND_105("105", "ул. Тамбовская, 78", "59.907781", "30.352074", "https://chat.whatsapp.com/8g3iLYWFSDSAw3PikiSPNw", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Тамбовская", "78", "false"),
    PLAYGROUND_106("106", "Школа №360", "59.889261", "30.357625", "https://chat.whatsapp.com/GiFAybEPHJg0f5cmIeAibl", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Бухарестская", "5А", "true"),
    PLAYGROUND_107("107", "Школа №371", "59.876971", "30.329678", "https://chat.whatsapp.com/Aa0ZV1nFFKeCffinf2ytxQ", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Благодатная", "36", "true"),
    PLAYGROUND_108("108", "Школа №388", "59.885493", "30.271298", "https://chat.whatsapp.com/AXHcMRWPjHq2zviI2XcA4p", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пер. Огородный", "9", "true"),
    PLAYGROUND_109("109", "Лицей №384", "59.897358", "30.274288", "https://chat.whatsapp.com/7vGP7AN5632GVAa2nAXwLu", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Стачек", "5", "true"),
    PLAYGROUND_110("110", "Школа №608", "59.898114", "30.268281", "https://chat.whatsapp.com/KkCj28sSNtI2LVoogEHlKt", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Промышленная", "18", "true"),
    PLAYGROUND_111("111", "Школа № 1", "59.873912", "30.315009", "https://chat.whatsapp.com/G9vcVt9IDbM9uip303dNPM", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Варшавская", "30А", "true"),
    PLAYGROUND_112("112", "Школа №358", "59.872977", "30.309448", "https://chat.whatsapp.com/4p0OGDItzS08HzWY3dGsXy", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кузнецовская", "20к2А", "true"),
    PLAYGROUND_113("113", "Школа №370", "59.873356", "30.301461", "https://chat.whatsapp.com/ItSAWe1ljWKLWzQ97H8DT8", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Благодатная", "11А", "true"),
    PLAYGROUND_114("114", "Школа №501", "59.871538", "30.269490", "https://chat.whatsapp.com/A6M8dTqeUdi8mgSWcTLIQa", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Краснопутиловская", "22А", "true"),
    PLAYGROUND_115("115", "Школа №480", "59.867707", "30.264840", "https://chat.whatsapp.com/3reQB39WlMkI8JGKiDvo8h", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Маринеско", "7А", "true"),
    PLAYGROUND_116("116", "Пражская, 7", "59.878059", "30.382628", "https://chat.whatsapp.com/FUz7vk9ob543ZS7wnvsEx4", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Пражская ", "7", "false"),
    PLAYGROUND_117("117", "Школа №305", "59.872956", "30.372167", "https://chat.whatsapp.com/Gmru6DubQeC2fwJHJxgrl0", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Будапештская ", "10", "true"),
    PLAYGROUND_118("118", "Школа №303", "59.865069", "30.409253", "https://chat.whatsapp.com/JtczweetKLmLS6IaWbT1pG", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Турку ", "29к2", "true"),
    PLAYGROUND_119("119", "Школа №201", "59.864201", "30.395575", "https://chat.whatsapp.com/JtczweetKLmLS6IaWbT1pG", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Турку ", "21к2", "true"),
    PLAYGROUND_120("120", "Лицей №299", "59.857672", "30.370860", "https://chat.whatsapp.com/16J3E42yxUWIMVI4hlwubD", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Славы ", "6к2", "true"),
    PLAYGROUND_121("121", "Школа №310", "59.856127", "30.388936", "https://chat.whatsapp.com/9cWfqEQYIrW92vjI19fAAk", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Славы ", "35к2", "true"),
    PLAYGROUND_122("122", "Школа №594", "59.860590", "30.315866", "https://chat.whatsapp.com/Fy3YR1QSeTKFjCSZv0HnEh", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Победы", "10", "true"),
    PLAYGROUND_123("123", "Школа №495", "59.861495", "30.310647", "https://chat.whatsapp.com/13Fzb1ji3eBCMqvXJ9MBs7", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Варшавская", "33", "true"),
    PLAYGROUND_124("124", "Школа №510", "59.854319", "30.294880", "https://chat.whatsapp.com/BR5YN0WynECL7PTPgRjSQq", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Кубинская", "62", "true"),
    PLAYGROUND_125("125", "Школа №643", "59.850252", "30.311571", "https://chat.whatsapp.com/9QyCI2NW7pnHJPDRtVKboX", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Варшавская", "63к2", "true"),
    PLAYGROUND_126("126", "Школа №537", "59.847865", "30.305845", "https://chat.whatsapp.com/8JrpPbUSuIoKvImjGCI4Wm", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Костюшко", "34А", "true"),
    PLAYGROUND_127("127", "Школа №519", "59.835976", "30.340649", "https://chat.whatsapp.com/3nNUfRdljtALGFnP1MnD6L", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Ленсовета", "87к2", "true"),
    PLAYGROUND_128("128", "Школа №390", "59.827137", "30.161059", "https://chat.whatsapp.com/6icOosXs1C0AF4aXwbSAig", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Здоровцева", "33к2", "true"),
    PLAYGROUND_129("129", "Пионерстроя, 27", "59.837895", "30.126108", "https://chat.whatsapp.com/ClcbhxXNCEc4fXyp4nU6OT", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Пионерстроя", "27", "false"),
    PLAYGROUND_130("130", "Торгово-Экономический университет", "59.995307", "30.358362", "https://chat.whatsapp.com/KMiUf8X2Fm22KISkGjFm1z", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Новороссийская", "50", "true"),
    ;



    FootData(String id, String name, String lattitude, String longitude, String links, String creator, String city, String street, String house, String subject) {
        this.id = id;
        this.name = name;
        this.lattitude = lattitude;
        this.longitude = longitude;
        this.links = links;
        this.creator = creator;
        this.city = city;
        this.street = street;
        this.house = house;
        this.subject = subject;
    }

    private String id;
    private String name;
    private String lattitude;
    private String longitude;
    private String links;
    private String creator;
    private String city;
    private String street;
    private String house;
    private String subject;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLattitude() {
        return lattitude;
    }

    public void setLattitude(String lattitude) {
        this.lattitude = lattitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLinks() {
        return links;
    }

    public void setLinks(String links) {
        this.links = links;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getHouse() {
        return house;
    }

    public void setHouse(String house) {
        this.house = house;
    }


    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
}
