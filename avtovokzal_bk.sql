PGDMP     &    ;                {            NewDB    12.14    12.14 >    r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            s           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            t           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            u           1262    16399    NewDB    DATABASE     �   CREATE DATABASE "NewDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE "NewDB";
                postgres    false            v           0    0    DATABASE "NewDB"    ACL     �   REVOKE ALL ON DATABASE "NewDB" FROM postgres;
GRANT CREATE,CONNECT ON DATABASE "NewDB" TO postgres;
GRANT TEMPORARY ON DATABASE "NewDB" TO postgres WITH GRANT OPTION;
                   postgres    false    2933            w           0    0    NewDB    DATABASE PROPERTIES     G   ALTER ROLE postgres IN DATABASE "NewDB" SET application_name TO 'abc';
                     postgres    false            x           0    0    SCHEMA public    ACL     &   GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    8                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            y           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    1            �            1259    16766    автобус    TABLE     K  CREATE TABLE public."автобус" (
    "номер_автобуса" integer NOT NULL,
    "код_модели" integer NOT NULL,
    "год_выпуска" integer NOT NULL,
    CONSTRAINT "автобус_год_выпуска_check" CHECK ((("год_выпуска")::double precision < date_part('Year'::text, now())))
);
 $   DROP TABLE public."автобус";
       public         heap    postgres    false            �            1259    16764 .   автобус_номер_автобуса_seq    SEQUENCE       ALTER TABLE public."автобус" ALTER COLUMN "номер_автобуса" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."автобус_номер_автобуса_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    16853 
   билет    TABLE       CREATE TABLE public."билет" (
    "паспортные_данные" character varying(12) NOT NULL,
    "код_места" integer NOT NULL,
    "цена_билета" integer NOT NULL,
    "пункт_подсадки" character varying(200) NOT NULL,
    "пункт_высадки" character varying(200) NOT NULL,
    "тип_оплата" character varying(10) NOT NULL,
    "статус" character varying(10) NOT NULL,
    "вид_продажи" character varying(30) NOT NULL,
    CONSTRAINT "билет_вид_продажи_check" CHECK ((("вид_продажи")::text = ANY ((ARRAY['продавать напрямую'::character varying, 'продавать по телефону'::character varying, 'продавать через киоск'::character varying])::text[]))),
    CONSTRAINT "билет_статус_check" CHECK ((("статус")::text = ANY ((ARRAY['оплачен'::character varying, 'бронь'::character varying, 'возврат'::character varying])::text[]))),
    CONSTRAINT "билет_тип_оплата_check" CHECK ((("тип_оплата")::text = ANY ((ARRAY['карта'::character varying, 'наличные'::character varying])::text[]))),
    CONSTRAINT "билет_цена_билета_check" CHECK (("цена_билета" >= 0))
);
     DROP TABLE public."билет";
       public         heap    postgres    false            �            1259    16779    водитель    TABLE     '  CREATE TABLE public."водитель" (
    "номер_водителя" integer NOT NULL,
    "номер_телефона" character varying(12) NOT NULL,
    "паспортные_данные" character varying(10) NOT NULL,
    "имя_водителя" character varying(40) NOT NULL
);
 &   DROP TABLE public."водитель";
       public         heap    postgres    false            �            1259    16777 0   водитель_номер_водителя_seq    SEQUENCE       ALTER TABLE public."водитель" ALTER COLUMN "номер_водителя" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."водитель_номер_водителя_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    16835    водить    TABLE     D  CREATE TABLE public."водить" (
    "номер_рейса" integer NOT NULL,
    "номер_водителя" integer NOT NULL,
    "дата_медосмотра" time without time zone NOT NULL,
    "допуск_к_рейсу" boolean DEFAULT false NOT NULL,
    "причина" character varying(40) NOT NULL
);
 "   DROP TABLE public."водить";
       public         heap    postgres    false            �            1259    16870    маршут    TABLE     '  CREATE TABLE public."маршут" (
    "пункт_прибытия" character varying(200) NOT NULL,
    "адрес" character varying(200) NOT NULL,
    "время_отпр" time without time zone NOT NULL,
    "время_приб" time without time zone NOT NULL,
    "тип_остановки" character varying(10) NOT NULL,
    "время_остановки" time without time zone NOT NULL,
    CONSTRAINT "маршут_check" CHECK (("время_отпр" < "время_приб")),
    CONSTRAINT "маршут_check1" CHECK (("время_отпр" < "время_приб")),
    CONSTRAINT "маршут_тип_остановки_check" CHECK ((("тип_остановки")::text = ANY ((ARRAY['быстрый'::character varying, 'длительный'::character varying])::text[])))
);
 "   DROP TABLE public."маршут";
       public         heap    postgres    false            �            1259    16804 
   место    TABLE     �  CREATE TABLE public."место" (
    "код_места" integer NOT NULL,
    "номер_места" integer NOT NULL,
    "статус_занятности" character varying(20) NOT NULL,
    CONSTRAINT "место_статус_занятности_check" CHECK ((("статус_занятности")::text = ANY ((ARRAY['Заброниров
ано'::character varying, 'пусто'::character varying, '‘отменено'::character varying])::text[])))
);
     DROP TABLE public."место";
       public         heap    postgres    false            �            1259    16802     место_код_места_seq    SEQUENCE     �   ALTER TABLE public."место" ALTER COLUMN "код_места" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."место_код_места_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    16757    модел_автобуса    TABLE     �  CREATE TABLE public."модел_автобуса" (
    "код_модели" integer NOT NULL,
    "тип_топлива" character varying(20) NOT NULL,
    "название" character varying(80) NOT NULL,
    "производитель" character varying(80) NOT NULL,
    "вместимость" integer NOT NULL,
    "страна" character varying(40) NOT NULL,
    CONSTRAINT "модел_автобуса_вместимость_check" CHECK (("вместимость" > 0)),
    CONSTRAINT "модел_автобуса_тип_топлива_check" CHECK ((("тип_топлива")::text = ANY ((ARRAY['бензин'::character varying, 'мазут'::character varying])::text[])))
);
 1   DROP TABLE public."модел_автобуса";
       public         heap    postgres    false            �            1259    16794    остановка    TABLE     �  CREATE TABLE public."остановка" (
    "адрес" character varying(200) NOT NULL,
    "тип_остановки" character varying(10) NOT NULL,
    "город" character varying(40) NOT NULL,
    "код_останови" integer NOT NULL,
    CONSTRAINT "остановка_тип_остановки_check" CHECK ((("тип_остановки")::text = ANY ((ARRAY['быстрый'::character varying, 'длительный'::character varying])::text[])))
);
 (   DROP TABLE public."остановка";
       public         heap    postgres    false            �            1259    16792 .   остановка_код_останови_seq    SEQUENCE       ALTER TABLE public."остановка" ALTER COLUMN "код_останови" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."остановка_код_останови_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            �            1259    16786    пассажир    TABLE     �  CREATE TABLE public."пассажир" (
    "паспортные_данные" character varying(10) NOT NULL,
    "номер_телефона" character varying(12) NOT NULL,
    "имя_пассажира" character varying(40) NOT NULL,
    "почта_пассажира" character varying(40) NOT NULL,
    CONSTRAINT "пассажир_почта_пассажира_check" CHECK ((("почта_пассажира")::text ~~ '%_@_%._%'::text))
);
 &   DROP TABLE public."пассажир";
       public         heap    postgres    false            �            1259    16810    расписание    TABLE     \  CREATE TABLE public."расписание" (
    "пункт_прибытия" character varying(200) NOT NULL,
    "расстояние" integer NOT NULL,
    "время_отпр" time without time zone NOT NULL,
    "время_приб" time without time zone NOT NULL,
    "пункт_отправленя" character varying(200) NOT NULL
);
 *   DROP TABLE public."расписание";
       public         heap    postgres    false            �            1259    16817    рейс    TABLE     N  CREATE TABLE public."рейс" (
    "номер_рейса" integer NOT NULL,
    "пункт_прибытия" character varying(80) NOT NULL,
    "номер_автобуса" integer NOT NULL,
    "время_отпр_факт" time without time zone NOT NULL,
    "время_приб_факт" time without time zone NOT NULL,
    "статус_выполнения" character varying(10) NOT NULL,
    CONSTRAINT "рейс_check" CHECK (("время_отпр_факт" < "время_приб_факт")),
    CONSTRAINT "рейс_check1" CHECK (("время_отпр_факт" < "время_приб_факт")),
    CONSTRAINT "рейс_статус_выполнения_check" CHECK ((("статус_выполнения")::text = ANY ((ARRAY['прибыли'::character varying, 'не прибыли'::character varying])::text[])))
);
    DROP TABLE public."рейс";
       public         heap    postgres    false            �            1259    16815 "   рейс_номер_рейса_seq    SEQUENCE     �   ALTER TABLE public."рейс" ALTER COLUMN "номер_рейса" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."рейс_номер_рейса_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            b          0    16766    автобус 
   TABLE DATA           y   COPY public."автобус" ("номер_автобуса", "код_модели", "год_выпуска") FROM stdin;
    public          postgres    false    205   'g       n          0    16853 
   билет 
   TABLE DATA           �   COPY public."билет" ("паспортные_данные", "код_места", "цена_билета", "пункт_подсадки", "пункт_высадки", "тип_оплата", "статус", "вид_продажи") FROM stdin;
    public          postgres    false    217   Dg       d          0    16779    водитель 
   TABLE DATA           �   COPY public."водитель" ("номер_водителя", "номер_телефона", "паспортные_данные", "имя_водителя") FROM stdin;
    public          postgres    false    207   ag       m          0    16835    водить 
   TABLE DATA           �   COPY public."водить" ("номер_рейса", "номер_водителя", "дата_медосмотра", "допуск_к_рейсу", "причина") FROM stdin;
    public          postgres    false    216   ~g       o          0    16870    маршут 
   TABLE DATA           �   COPY public."маршут" ("пункт_прибытия", "адрес", "время_отпр", "время_приб", "тип_остановки", "время_остановки") FROM stdin;
    public          postgres    false    218   �g       i          0    16804 
   место 
   TABLE DATA           y   COPY public."место" ("код_места", "номер_места", "статус_занятности") FROM stdin;
    public          postgres    false    212   �g       `          0    16757    модел_автобуса 
   TABLE DATA           �   COPY public."модел_автобуса" ("код_модели", "тип_топлива", "название", "производитель", "вместимость", "страна") FROM stdin;
    public          postgres    false    203   �g       g          0    16794    остановка 
   TABLE DATA           �   COPY public."остановка" ("адрес", "тип_остановки", "город", "код_останови") FROM stdin;
    public          postgres    false    210   �g       e          0    16786    пассажир 
   TABLE DATA           �   COPY public."пассажир" ("паспортные_данные", "номер_телефона", "имя_пассажира", "почта_пассажира") FROM stdin;
    public          postgres    false    208   h       j          0    16810    расписание 
   TABLE DATA           �   COPY public."расписание" ("пункт_прибытия", "расстояние", "время_отпр", "время_приб", "пункт_отправленя") FROM stdin;
    public          postgres    false    213   ,h       l          0    16817    рейс 
   TABLE DATA           �   COPY public."рейс" ("номер_рейса", "пункт_прибытия", "номер_автобуса", "время_отпр_факт", "время_приб_факт", "статус_выполнения") FROM stdin;
    public          postgres    false    215   Ih       z           0    0 .   автобус_номер_автобуса_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public."автобус_номер_автобуса_seq"', 1, false);
          public          postgres    false    204            {           0    0 0   водитель_номер_водителя_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public."водитель_номер_водителя_seq"', 1, false);
          public          postgres    false    206            |           0    0     место_код_места_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."место_код_места_seq"', 1, false);
          public          postgres    false    211            }           0    0 .   остановка_код_останови_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public."остановка_код_останови_seq"', 1, false);
          public          postgres    false    209            ~           0    0 "   рейс_номер_рейса_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public."рейс_номер_рейса_seq"', 1, false);
          public          postgres    false    214            �
           2606    16771 "   автобус автобус_pkey 
   CONSTRAINT        ALTER TABLE ONLY public."автобус"
    ADD CONSTRAINT "автобус_pkey" PRIMARY KEY ("номер_автобуса");
 P   ALTER TABLE ONLY public."автобус" DROP CONSTRAINT "автобус_pkey";
       public            postgres    false    205            �
           2606    16783 &   водитель водитель_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."водитель"
    ADD CONSTRAINT "водитель_pkey" PRIMARY KEY ("номер_водителя");
 T   ALTER TABLE ONLY public."водитель" DROP CONSTRAINT "водитель_pkey";
       public            postgres    false    207            �
           2606    16785 G   водитель водитель_паспортные_данные_key 
   CONSTRAINT     �   ALTER TABLE ONLY public."водитель"
    ADD CONSTRAINT "водитель_паспортные_данные_key" UNIQUE ("паспортные_данные");
 u   ALTER TABLE ONLY public."водитель" DROP CONSTRAINT "водитель_паспортные_данные_key";
       public            postgres    false    207            �
           2606    16842 9   водить водить_номер_водителя_key 
   CONSTRAINT     �   ALTER TABLE ONLY public."водить"
    ADD CONSTRAINT "водить_номер_водителя_key" UNIQUE ("номер_водителя");
 g   ALTER TABLE ONLY public."водить" DROP CONSTRAINT "водить_номер_водителя_key";
       public            postgres    false    216            �
           2606    16840 3   водить водить_номер_рейса_key 
   CONSTRAINT     �   ALTER TABLE ONLY public."водить"
    ADD CONSTRAINT "водить_номер_рейса_key" UNIQUE ("номер_рейса");
 a   ALTER TABLE ONLY public."водить" DROP CONSTRAINT "водить_номер_рейса_key";
       public            postgres    false    216            �
           2606    16809    место место_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."место"
    ADD CONSTRAINT "место_pkey" PRIMARY KEY ("код_места");
 H   ALTER TABLE ONLY public."место" DROP CONSTRAINT "место_pkey";
       public            postgres    false    212            �
           2606    16763 <   модел_автобуса модел_автобуса_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."модел_автобуса"
    ADD CONSTRAINT "модел_автобуса_pkey" PRIMARY KEY ("код_модели");
 j   ALTER TABLE ONLY public."модел_автобуса" DROP CONSTRAINT "модел_автобуса_pkey";
       public            postgres    false    203            �
           2606    16799 *   остановка остановка_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."остановка"
    ADD CONSTRAINT "остановка_pkey" PRIMARY KEY ("адрес");
 X   ALTER TABLE ONLY public."остановка" DROP CONSTRAINT "остановка_pkey";
       public            postgres    false    210            �
           2606    16801 A   остановка остановка_код_останови_key 
   CONSTRAINT     �   ALTER TABLE ONLY public."остановка"
    ADD CONSTRAINT "остановка_код_останови_key" UNIQUE ("код_останови");
 o   ALTER TABLE ONLY public."остановка" DROP CONSTRAINT "остановка_код_останови_key";
       public            postgres    false    210            �
           2606    16791 &   пассажир пассажир_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."пассажир"
    ADD CONSTRAINT "пассажир_pkey" PRIMARY KEY ("паспортные_данные");
 T   ALTER TABLE ONLY public."пассажир" DROP CONSTRAINT "пассажир_pkey";
       public            postgres    false    208            �
           2606    16814 .   расписание расписание_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."расписание"
    ADD CONSTRAINT "расписание_pkey" PRIMARY KEY ("пункт_прибытия");
 \   ALTER TABLE ONLY public."расписание" DROP CONSTRAINT "расписание_pkey";
       public            postgres    false    213            �
           2606    16824    рейс рейс_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."рейс"
    ADD CONSTRAINT "рейс_pkey" PRIMARY KEY ("номер_рейса");
 D   ALTER TABLE ONLY public."рейс" DROP CONSTRAINT "рейс_pkey";
       public            postgres    false    215            �
           2606    16881    маршут fk_адрес    FK CONSTRAINT     �   ALTER TABLE ONLY public."маршут"
    ADD CONSTRAINT "fk_адрес" FOREIGN KEY ("адрес") REFERENCES public."остановка"("адрес");
 H   ALTER TABLE ONLY public."маршут" DROP CONSTRAINT "fk_адрес";
       public          postgres    false    218    210    2764            �
           2606    16865    билет fk_код_места    FK CONSTRAINT     �   ALTER TABLE ONLY public."билет"
    ADD CONSTRAINT "fk_код_места" FOREIGN KEY ("код_места") REFERENCES public."место"("код_места");
 M   ALTER TABLE ONLY public."билет" DROP CONSTRAINT "fk_код_места";
       public          postgres    false    217    212    2768            �
           2606    16830 '   рейс fk_номер_автобуса    FK CONSTRAINT     �   ALTER TABLE ONLY public."рейс"
    ADD CONSTRAINT "fk_номер_автобуса" FOREIGN KEY ("номер_автобуса") REFERENCES public."автобус"("номер_автобуса");
 U   ALTER TABLE ONLY public."рейс" DROP CONSTRAINT "fk_номер_автобуса";
       public          postgres    false    2756    215    205            �
           2606    16848 +   водить fk_номер_водителя    FK CONSTRAINT     �   ALTER TABLE ONLY public."водить"
    ADD CONSTRAINT "fk_номер_водителя" FOREIGN KEY ("номер_водителя") REFERENCES public."водитель"("номер_водителя");
 Y   ALTER TABLE ONLY public."водить" DROP CONSTRAINT "fk_номер_водителя";
       public          postgres    false    207    216    2758            �
           2606    16843 %   водить fk_номер_рейса    FK CONSTRAINT     �   ALTER TABLE ONLY public."водить"
    ADD CONSTRAINT "fk_номер_рейса" FOREIGN KEY ("номер_рейса") REFERENCES public."рейс"("номер_рейса");
 S   ALTER TABLE ONLY public."водить" DROP CONSTRAINT "fk_номер_рейса";
       public          postgres    false    216    215    2772            �
           2606    16860 /   билет fk_паспортные_данные    FK CONSTRAINT     �   ALTER TABLE ONLY public."билет"
    ADD CONSTRAINT "fk_паспортные_данные" FOREIGN KEY ("паспортные_данные") REFERENCES public."пассажир"("паспортные_данные");
 ]   ALTER TABLE ONLY public."билет" DROP CONSTRAINT "fk_паспортные_данные";
       public          postgres    false    2762    208    217            �
           2606    16825 '   рейс fk_пункт_прибытия    FK CONSTRAINT     �   ALTER TABLE ONLY public."рейс"
    ADD CONSTRAINT "fk_пункт_прибытия" FOREIGN KEY ("пункт_прибытия") REFERENCES public."расписание"("пункт_прибытия");
 U   ALTER TABLE ONLY public."рейс" DROP CONSTRAINT "fk_пункт_прибытия";
       public          postgres    false    215    213    2770            �
           2606    16876 +   маршут fk_пункт_прибытия    FK CONSTRAINT     �   ALTER TABLE ONLY public."маршут"
    ADD CONSTRAINT "fk_пункт_прибытия" FOREIGN KEY ("пункт_прибытия") REFERENCES public."расписание"("пункт_прибытия");
 Y   ALTER TABLE ONLY public."маршут" DROP CONSTRAINT "fk_пункт_прибытия";
       public          postgres    false    218    2770    213            �
           2606    16772 6   автобус автобус_код_модели_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."автобус"
    ADD CONSTRAINT "автобус_код_модели_fkey" FOREIGN KEY ("код_модели") REFERENCES public."модел_автобуса"("код_модели");
 d   ALTER TABLE ONLY public."автобус" DROP CONSTRAINT "автобус_код_модели_fkey";
       public          postgres    false    205    203    2754            b      x������ � �      n      x������ � �      d      x������ � �      m      x������ � �      o      x������ � �      i      x������ � �      `      x������ � �      g      x������ � �      e      x������ � �      j      x������ � �      l      x������ � �     