PGDMP                          {            NewDB    12.14    12.14 @    x           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            z           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            {           1262    16399    NewDB    DATABASE     �   CREATE DATABASE "NewDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE "NewDB";
                postgres    false            |           0    0    DATABASE "NewDB"    ACL     �   REVOKE ALL ON DATABASE "NewDB" FROM postgres;
GRANT CREATE,CONNECT ON DATABASE "NewDB" TO postgres;
GRANT TEMPORARY ON DATABASE "NewDB" TO postgres WITH GRANT OPTION;
                   postgres    false    2939            }           0    0    NewDB    DATABASE PROPERTIES     G   ALTER ROLE postgres IN DATABASE "NewDB" SET application_name TO 'abc';
                     postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            ~           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    1            �            1259    17130 
   bus_models    TABLE     �  CREATE TABLE public.bus_models (
    model_code integer NOT NULL,
    fuel_type character varying(20) NOT NULL,
    name character varying(80) NOT NULL,
    manufacturer character varying(80) NOT NULL,
    capacity integer NOT NULL,
    country character varying(40) NOT NULL,
    CONSTRAINT bus_models_capacity_check CHECK ((capacity > 0)),
    CONSTRAINT bus_models_fuel_type_check CHECK (((fuel_type)::text = ANY ((ARRAY['gasoline'::character varying, 'oil'::character varying])::text[])))
);
    DROP TABLE public.bus_models;
       public         heap    postgres    false            �            1259    17139    buses    TABLE     �   CREATE TABLE public.buses (
    bus_id integer NOT NULL,
    model_code integer NOT NULL,
    release_year integer NOT NULL,
    CONSTRAINT buses_release_year_check CHECK (((release_year)::double precision < date_part('Year'::text, now())))
);
    DROP TABLE public.buses;
       public         heap    postgres    false            �            1259    17137    buses_bus_id_seq    SEQUENCE     �   ALTER TABLE public.buses ALTER COLUMN bus_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.buses_bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    17208    drive    TABLE     �   CREATE TABLE public.drive (
    trip_id integer NOT NULL,
    driver_id integer NOT NULL,
    admission_to_trip boolean DEFAULT false NOT NULL
);
    DROP TABLE public.drive;
       public         heap    postgres    false            �            1259    17152    drivers    TABLE     �   CREATE TABLE public.drivers (
    driver_id integer NOT NULL,
    phone_id character varying(12) NOT NULL,
    passport character varying(10) NOT NULL,
    driver_name character varying(40) NOT NULL
);
    DROP TABLE public.drivers;
       public         heap    postgres    false            �            1259    17150    drivers_driver_id_seq    SEQUENCE     �   ALTER TABLE public.drivers ALTER COLUMN driver_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.drivers_driver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    17159 
   passengers    TABLE     O  CREATE TABLE public.passengers (
    passport character varying(10) NOT NULL,
    phone_number character varying(12) NOT NULL,
    passenger_name character varying(40) NOT NULL,
    passenger_email character varying(40) NOT NULL,
    CONSTRAINT passengers_passenger_email_check CHECK (((passenger_email)::text ~~ '%_@_%._%'::text))
);
    DROP TABLE public.passengers;
       public         heap    postgres    false            �            1259    17247    routes    TABLE     _  CREATE TABLE public.routes (
    arrival_point character varying(200) NOT NULL,
    address character varying(200) NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    stop_type character varying(10) NOT NULL,
    stop_time time without time zone NOT NULL,
    CONSTRAINT routes_check CHECK ((departure_time < arrival_time)),
    CONSTRAINT routes_check1 CHECK ((departure_time < arrival_time)),
    CONSTRAINT routes_stop_type_check CHECK (((stop_type)::text = ANY ((ARRAY['short'::character varying, 'long'::character varying])::text[])))
);
    DROP TABLE public.routes;
       public         heap    postgres    false            �            1259    17183 	   schedules    TABLE       CREATE TABLE public.schedules (
    arrival_point character varying(200) NOT NULL,
    distance integer NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    departure_point character varying(200) NOT NULL
);
    DROP TABLE public.schedules;
       public         heap    postgres    false            �            1259    17177    seats    TABLE     E  CREATE TABLE public.seats (
    seat_code integer NOT NULL,
    seat_id integer NOT NULL,
    book_status character varying(20) NOT NULL,
    CONSTRAINT seats_book_status_check CHECK (((book_status)::text = ANY ((ARRAY['booked'::character varying, 'empty'::character varying, '‘canceled'::character varying])::text[])))
);
    DROP TABLE public.seats;
       public         heap    postgres    false            �            1259    17175    seats_seat_code_seq    SEQUENCE     �   ALTER TABLE public.seats ALTER COLUMN seat_code ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.seats_seat_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    17167    stops    TABLE     S  CREATE TABLE public.stops (
    address character varying(200) NOT NULL,
    stop_type character varying(10) NOT NULL,
    city character varying(40) NOT NULL,
    stop_code integer NOT NULL,
    CONSTRAINT stops_stop_type_check CHECK (((stop_type)::text = ANY ((ARRAY['short'::character varying, 'long'::character varying])::text[])))
);
    DROP TABLE public.stops;
       public         heap    postgres    false            �            1259    17165    stops_stop_code_seq    SEQUENCE     �   ALTER TABLE public.stops ALTER COLUMN stop_code ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stops_stop_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            �            1259    17228    tickets    TABLE     �  CREATE TABLE public.tickets (
    passport character varying(12) NOT NULL,
    seat_code integer NOT NULL,
    ticket_price integer NOT NULL,
    landing_point character varying(200) NOT NULL,
    drop_point character varying(200) NOT NULL,
    payment_type character varying(10) NOT NULL,
    status character varying(10) NOT NULL,
    sale_type character varying(30) NOT NULL,
    CONSTRAINT tickets_payment_type_check CHECK (((payment_type)::text = ANY ((ARRAY['card'::character varying, 'cash'::character varying])::text[]))),
    CONSTRAINT tickets_sale_type_check CHECK (((sale_type)::text = ANY ((ARRAY['sell directly'::character varying, 'sell by phone'::character varying, 'sell through a kiosk'::character varying])::text[]))),
    CONSTRAINT tickets_status_check CHECK (((status)::text = ANY ((ARRAY['payed'::character varying, 'waiting'::character varying, 'refund'::character varying])::text[]))),
    CONSTRAINT tickets_ticket_price_check CHECK ((ticket_price >= 0))
);
    DROP TABLE public.tickets;
       public         heap    postgres    false            �            1259    17190    trips    TABLE     c  CREATE TABLE public.trips (
    trip_id integer NOT NULL,
    arrival_point character varying(80) NOT NULL,
    bus_id integer NOT NULL,
    actual_departure_time time without time zone NOT NULL,
    actual_arrival_time time without time zone NOT NULL,
    status character varying(10) NOT NULL,
    CONSTRAINT trips_check CHECK ((actual_departure_time < actual_arrival_time)),
    CONSTRAINT trips_check1 CHECK ((actual_departure_time < actual_arrival_time)),
    CONSTRAINT trips_status_check CHECK (((status)::text = ANY ((ARRAY['arrived'::character varying, 'not arrived'::character varying])::text[])))
);
    DROP TABLE public.trips;
       public         heap    postgres    false            �            1259    17188    trips_trip_id_seq    SEQUENCE     �   ALTER TABLE public.trips ALTER COLUMN trip_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            f          0    17130 
   bus_models 
   TABLE DATA           b   COPY public.bus_models (model_code, fuel_type, name, manufacturer, capacity, country) FROM stdin;
    public          postgres    false    203   �T       h          0    17139    buses 
   TABLE DATA           A   COPY public.buses (bus_id, model_code, release_year) FROM stdin;
    public          postgres    false    205   �T       s          0    17208    drive 
   TABLE DATA           F   COPY public.drive (trip_id, driver_id, admission_to_trip) FROM stdin;
    public          postgres    false    216   U       j          0    17152    drivers 
   TABLE DATA           M   COPY public.drivers (driver_id, phone_id, passport, driver_name) FROM stdin;
    public          postgres    false    207   #U       k          0    17159 
   passengers 
   TABLE DATA           ]   COPY public.passengers (passport, phone_number, passenger_name, passenger_email) FROM stdin;
    public          postgres    false    208   @U       u          0    17247    routes 
   TABLE DATA           l   COPY public.routes (arrival_point, address, departure_time, arrival_time, stop_type, stop_time) FROM stdin;
    public          postgres    false    218   ]U       p          0    17183 	   schedules 
   TABLE DATA           k   COPY public.schedules (arrival_point, distance, departure_time, arrival_time, departure_point) FROM stdin;
    public          postgres    false    213   zU       o          0    17177    seats 
   TABLE DATA           @   COPY public.seats (seat_code, seat_id, book_status) FROM stdin;
    public          postgres    false    212   �U       m          0    17167    stops 
   TABLE DATA           D   COPY public.stops (address, stop_type, city, stop_code) FROM stdin;
    public          postgres    false    210   �U       t          0    17228    tickets 
   TABLE DATA           �   COPY public.tickets (passport, seat_code, ticket_price, landing_point, drop_point, payment_type, status, sale_type) FROM stdin;
    public          postgres    false    217   �U       r          0    17190    trips 
   TABLE DATA           s   COPY public.trips (trip_id, arrival_point, bus_id, actual_departure_time, actual_arrival_time, status) FROM stdin;
    public          postgres    false    215   �U                  0    0    buses_bus_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.buses_bus_id_seq', 1, false);
          public          postgres    false    204            �           0    0    drivers_driver_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.drivers_driver_id_seq', 1, false);
          public          postgres    false    206            �           0    0    seats_seat_code_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.seats_seat_code_seq', 1, false);
          public          postgres    false    211            �           0    0    stops_stop_code_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.stops_stop_code_seq', 1, false);
          public          postgres    false    209            �           0    0    trips_trip_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.trips_trip_id_seq', 1, false);
          public          postgres    false    214            �
           2606    17136    bus_models bus_models_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.bus_models
    ADD CONSTRAINT bus_models_pkey PRIMARY KEY (model_code);
 D   ALTER TABLE ONLY public.bus_models DROP CONSTRAINT bus_models_pkey;
       public            postgres    false    203            �
           2606    17144    buses buses_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_pkey PRIMARY KEY (bus_id);
 :   ALTER TABLE ONLY public.buses DROP CONSTRAINT buses_pkey;
       public            postgres    false    205            �
           2606    17217    drive drive_driver_id_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.drive
    ADD CONSTRAINT drive_driver_id_key UNIQUE (driver_id);
 C   ALTER TABLE ONLY public.drive DROP CONSTRAINT drive_driver_id_key;
       public            postgres    false    216            �
           2606    17213    drive drive_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.drive
    ADD CONSTRAINT drive_pkey PRIMARY KEY (trip_id, driver_id);
 :   ALTER TABLE ONLY public.drive DROP CONSTRAINT drive_pkey;
       public            postgres    false    216    216            �
           2606    17215    drive drive_trip_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.drive
    ADD CONSTRAINT drive_trip_id_key UNIQUE (trip_id);
 A   ALTER TABLE ONLY public.drive DROP CONSTRAINT drive_trip_id_key;
       public            postgres    false    216            �
           2606    17158    drivers drivers_passport_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_passport_key UNIQUE (passport);
 F   ALTER TABLE ONLY public.drivers DROP CONSTRAINT drivers_passport_key;
       public            postgres    false    207            �
           2606    17156    drivers drivers_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (driver_id);
 >   ALTER TABLE ONLY public.drivers DROP CONSTRAINT drivers_pkey;
       public            postgres    false    207            �
           2606    17164    passengers passengers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.passengers
    ADD CONSTRAINT passengers_pkey PRIMARY KEY (passport);
 D   ALTER TABLE ONLY public.passengers DROP CONSTRAINT passengers_pkey;
       public            postgres    false    208            �
           2606    17254    routes routes_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (arrival_point, address);
 <   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_pkey;
       public            postgres    false    218    218            �
           2606    17187    schedules schedules_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (arrival_point);
 B   ALTER TABLE ONLY public.schedules DROP CONSTRAINT schedules_pkey;
       public            postgres    false    213            �
           2606    17182    seats seats_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (seat_code);
 :   ALTER TABLE ONLY public.seats DROP CONSTRAINT seats_pkey;
       public            postgres    false    212            �
           2606    17172    stops stops_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (address);
 :   ALTER TABLE ONLY public.stops DROP CONSTRAINT stops_pkey;
       public            postgres    false    210            �
           2606    17174    stops stops_stop_code_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_stop_code_key UNIQUE (stop_code);
 C   ALTER TABLE ONLY public.stops DROP CONSTRAINT stops_stop_code_key;
       public            postgres    false    210            �
           2606    17236    tickets tickets_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (passport, seat_code);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public            postgres    false    217    217            �
           2606    17197    trips trips_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (trip_id);
 :   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_pkey;
       public            postgres    false    215            �
           2606    17145    buses buses_model_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_model_code_fkey FOREIGN KEY (model_code) REFERENCES public.bus_models(model_code);
 E   ALTER TABLE ONLY public.buses DROP CONSTRAINT buses_model_code_fkey;
       public          postgres    false    205    2754    203            �
           2606    17223    drive drive_driver_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.drive
    ADD CONSTRAINT drive_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.drivers(driver_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.drive DROP CONSTRAINT drive_driver_id_fkey;
       public          postgres    false    216    2760    207            �
           2606    17218    drive drive_trip_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.drive
    ADD CONSTRAINT drive_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trips(trip_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.drive DROP CONSTRAINT drive_trip_id_fkey;
       public          postgres    false    216    215    2772            �
           2606    17260    routes routes_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_address_fkey FOREIGN KEY (address) REFERENCES public.stops(address) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_address_fkey;
       public          postgres    false    210    218    2764            �
           2606    17255     routes routes_arrival_point_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_arrival_point_fkey FOREIGN KEY (arrival_point) REFERENCES public.schedules(arrival_point) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_arrival_point_fkey;
       public          postgres    false    213    2770    218            �
           2606    17237    tickets tickets_passport_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_passport_fkey FOREIGN KEY (passport) REFERENCES public.passengers(passport) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_passport_fkey;
       public          postgres    false    217    208    2762            �
           2606    17242    tickets tickets_seat_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_code_fkey FOREIGN KEY (seat_code) REFERENCES public.seats(seat_code) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_seat_code_fkey;
       public          postgres    false    217    212    2768            �
           2606    17198    trips trips_arrival_point_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_arrival_point_fkey FOREIGN KEY (arrival_point) REFERENCES public.schedules(arrival_point);
 H   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_arrival_point_fkey;
       public          postgres    false    213    215    2770            �
           2606    17203    trips trips_bus_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_bus_id_fkey FOREIGN KEY (bus_id) REFERENCES public.buses(bus_id);
 A   ALTER TABLE ONLY public.trips DROP CONSTRAINT trips_bus_id_fkey;
       public          postgres    false    2756    205    215            f      x������ � �      h      x������ � �      s      x������ � �      j      x������ � �      k      x������ � �      u      x������ � �      p      x������ � �      o      x������ � �      m      x������ � �      t      x������ � �      r      x������ � �     