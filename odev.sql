--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bis(character, integer, integer, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bis(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, gram character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."biskuvi" ("barkodNo") VALUES (son);
update "public"."biskuvi"  SET "cesit"=ces where "biskuvi"."barkodNo"=son;
update "public"."biskuvi"  SET "gramaj"=gram where "biskuvi"."barkodNo"=son;

      
     
   
END
$$;


ALTER FUNCTION public.bis(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, gram character) OWNER TO postgres;

--
-- Name: biskuvidetay(character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.biskuvidetay(cesitt character, gram character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare


son int;
begin
son=currval('"public"."urun_barkodNo_seq"'::regclass);





update "public"."biskuvi"  SET "cesit"=cesitt where "biskuvi"."barkodNo"=son;
update "public"."biskuvi"  SET "gramaj"=gram where "biskuvi"."barkodNo"=son;

return 1;
end;

$$;


ALTER FUNCTION public.biskuvidetay(cesitt character, gram character) OWNER TO postgres;

--
-- Name: cikarilanlarkaydet(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cikarilanlarkaydet() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 
        INSERT INTO "cikarilanlarKayit"("personelNo", "personelAd","personelSoyad", "eskiMaas","degisiklikTarihi")
        VALUES(OLD."personelNo", OLD."adi", OLD."soyadi",OLD."maas",CURRENT_TIMESTAMP::TIMESTAMP);


    RETURN NEW;
END;
$$;


ALTER FUNCTION public.cikarilanlarkaydet() OWNER TO postgres;

--
-- Name: cikolata(character, integer, integer, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cikolata(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, markaa character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."cikolata" ("barkodNo") VALUES (son);
update "public"."cikolata"  SET "cesit"=ces where "cikolata"."barkodNo"=son;
update "public"."cikolata"  SET "marka"=markaa where "cikolata"."barkodNo"=son;

      
     
   
END
$$;


ALTER FUNCTION public.cikolata(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, markaa character) OWNER TO postgres;

--
-- Name: cips(character, integer, integer, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cips(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."cips" ("barkodNo") VALUES (son);
update "public"."cips"  SET "cesit"=ces where "cips"."barkodNo"=son;
update "public"."cips"  SET "gramaj"=agirlik where "cips"."barkodNo"=son;


      
     
   
END
$$;


ALTER FUNCTION public.cips(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character) OWNER TO postgres;

--
-- Name: depogorevlisi(integer, character, character, character, integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.depogorevlisi(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, vard character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."Calisanlar" ("adi","soyadi","bolum","maas") VALUES (personelAdi,soyadi,bolumu,maasi);
      
  son=currval('"public"."Calisanlar_personelNo_seq"'::regclass);



      INSERT INTO "public"."depoGorevlisi" ("personelNo") VALUES (son);

      update "public"."depoGorevlisi"  SET "vardiya"=vard where "depoGorevlisi"."personelNo"=son;

      

   
   
END
$$;


ALTER FUNCTION public.depogorevlisi(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, vard character) OWNER TO postgres;

--
-- Name: hesaplasil(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hesaplasil(urunid integer, teslimnum integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
urunFiyat integer;
eskiFatura int;
faturaTutar int;
son int;
begin

urunFiyat=(select "paketFiyati" from "public"."urun" where "barkodNo"=urunID);
eskiFatura=(select "fatura" from "public"."teslimat" where "teslimatNo"=teslimNum);

faturaTutar:=urunFiyat+eskiFatura;


update "public"."teslimat"  SET "fatura"=faturaTutar where "teslimat"."teslimatNo"=teslimNum;
delete from "public"."urun" as urun where "barkodNo"=urunID;
return 1;
end;

$$;


ALTER FUNCTION public.hesaplasil(urunid integer, teslimnum integer) OWNER TO postgres;

--
-- Name: kola(character, integer, integer, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kola(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, markaa character, litre character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."kola" ("barkodNo") VALUES (son);
update "public"."kola"  SET "marka"=markaa where "kola"."barkodNo"=son;
update "public"."kola"  SET "birimLitre"=litre where "kola"."barkodNo"=son;


      
     
   
END
$$;


ALTER FUNCTION public.kola(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, markaa character, litre character) OWNER TO postgres;

--
-- Name: login(character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.login(username character, password character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    if (select count(*) FROM yonetici WHERE "kullaniciAdi"="username" AND "sifre"="password") >0 then
return 1;
else
return 0;
    end if;
  END
  $$;


ALTER FUNCTION public.login(username character, password character) OWNER TO postgres;

--
-- Name: mercimek(character, integer, integer, integer, integer, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mercimek(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character, uretim character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."mercimek" ("barkodNo") VALUES (son);
update "public"."mercimek"  SET "cesidi"=ces where "mercimek"."barkodNo"=son;
update "public"."mercimek"  SET "paketAgirligi"=agirlik where "mercimek"."barkodNo"=son;
update "public"."mercimek"  SET "uretimYeri"=uretim where "mercimek"."barkodNo"=son;

      
     
   
END
$$;


ALTER FUNCTION public.mercimek(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character, uretim character) OWNER TO postgres;

--
-- Name: personelcikar(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personelcikar(personelid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
delete from "public"."Calisanlar"  where "personelNo"=personelID;
return 1;
end;

$$;


ALTER FUNCTION public.personelcikar(personelid integer) OWNER TO postgres;

--
-- Name: personelekle(integer, character, character, character, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personelekle(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."Calisanlar" ("adi","soyadi","bolum","maas") VALUES (personelAdi,soyadi,bolumu,maasi);
      
  son=currval('"public"."Calisanlar_personelNo_seq"'::regclass);


        if (  personelBolumID=1) then
      INSERT INTO "public"."depoGorevlisi" ("personelNo") VALUES (son);

      
      end if;
      
if (  personelBolumID) then
     INSERT INTO "public"."sevkiyatci" ("personelNo") VALUES (son);
   end if; 
   
   
   
END
$$;


ALTER FUNCTION public.personelekle(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer) OWNER TO postgres;

--
-- Name: pirinc(character, integer, integer, integer, integer, character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pirinc(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character, uretim character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."urun" ("urunİsmi","tedarikciNo","adet","birimFiyat") VALUES (urunNamee,tedarikciNoo,adett,birimFiyatt);
      
  son=currval('"public"."urun_barkodNo_seq"'::regclass);


       
      INSERT INTO "public"."pirinc" ("barkodNo") VALUES (son);
update "public"."pirinc"  SET "cesidi"=ces where "pirinc"."barkodNo"=son;
update "public"."pirinc"  SET "paketAgirligi"=agirlik where "pirinc"."barkodNo"=son;
update "public"."pirinc"  SET "uretimYeri"=uretim where "pirinc"."barkodNo"=son;

      
     
   
END
$$;


ALTER FUNCTION public.pirinc(urunnamee character, urunid integer, tedarikcinoo integer, adett integer, birimfiyatt integer, ces character, agirlik character, uretim character) OWNER TO postgres;

--
-- Name: satisYapildiginda(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."satisYapildiginda"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    
        INSERT INTO "satisKaydi"("barkodNo", "tedarikciNo","adet", "birimFiyat", "paketFiyati","urunIsmi","satisTarihi")
        VALUES(OLD."barkodNo", OLD."tedarikciNo", OLD."adet",OLD."birimFiyat",OLD."paketFiyati" ,OLD."urunİsmi",CURRENT_TIMESTAMP::TIMESTAMP);
 

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."satisYapildiginda"() OWNER TO postgres;

--
-- Name: sevkiyatci(integer, character, character, character, integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sevkiyatci(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, teslim character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."Calisanlar" ("adi","soyadi","bolum","maas") VALUES (personelAdi,soyadi,bolumu,maasi);
      
  son=currval('"public"."Calisanlar_personelNo_seq"'::regclass);



      INSERT INTO "public"."sevkiyatci" ("personelNo") VALUES (son);

      update "public"."sevkiyatci"  SET "teslimSehri"=teslim where "sevkiyatci"."personelNo"=son;

      

   
   
END
$$;


ALTER FUNCTION public.sevkiyatci(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, teslim character) OWNER TO postgres;

--
-- Name: tedarikciekle(character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tedarikciekle(firma character, sehir character, adres character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."tedarikciler" ("firmaİsmi","sehir","adres") VALUES (firma,sehir,adres);
      



   
END
$$;


ALTER FUNCTION public.tedarikciekle(firma character, sehir character, adres character) OWNER TO postgres;

--
-- Name: teslimatnoktaekle(character, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teslimatnoktaekle(teslimyer character, sehir character, adres character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."teslimatNoktalari" ("teslimYeri","sehir","adres") VALUES (teslimyer,sehir,adres);
      



   
END
$$;


ALTER FUNCTION public.teslimatnoktaekle(teslimyer character, sehir character, adres character) OWNER TO postgres;

--
-- Name: teslimatolustur(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teslimatolustur(teslimnumber integer, personelnum integer, noktanum integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE

BEGIN

    INSERT INTO "public"."teslimat" ("teslimatNo","noktaNo","personelNo") VALUES (teslimNumber,noktaNum,personelNum);
      



END
$$;


ALTER FUNCTION public.teslimatolustur(teslimnumber integer, personelnum integer, noktanum integer) OWNER TO postgres;

--
-- Name: toplamfiyat(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamfiyat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
toplam integer;
adett int;
fiyat int;
barkod int;
begin
adett=(select "adet" from urun order by "barkodNo" desc limit 1);
fiyat=(select "birimFiyat" from urun order by "barkodNo" desc limit 1);
barkod=(select "barkodNo" from urun order by "barkodNo" desc limit 1);
toplam:=adett*fiyat;

update "public"."urun" as urun  SET "paketFiyati"=toplam where "urun"."barkodNo"=NEW."barkodNo";
return new;
end;

$$;


ALTER FUNCTION public.toplamfiyat() OWNER TO postgres;

--
-- Name: urunbul(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.urunbul(urunno integer) RETURNS TABLE(barkod integer, tedarikci integer, "urunİsm" character, adeti integer, birimfiyati integer)
    LANGUAGE plpgsql
    AS $$
begin
return query
SELECT
"barkodNo","tedarikciNo",
"urunİsmi","adet","birimFiyat" from urun where "barkodNo"=urunNo;

end;
$$;


ALTER FUNCTION public.urunbul(urunno integer) OWNER TO postgres;

--
-- Name: yonetici(integer, character, character, character, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yonetici(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, kullanici character, sifree character) RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
son int;
BEGIN
    INSERT INTO "public"."Calisanlar" ("adi","soyadi","bolum","maas") VALUES (personelAdi,soyadi,bolumu,maasi);
      
  son=currval('"public"."Calisanlar_personelNo_seq"'::regclass);



      INSERT INTO "public"."yonetici" ("personelNo") VALUES (son);

      update "public"."yonetici"  SET "kullaniciAdi"=kullanici where "yonetici"."personelNo"=son;
            update "public"."yonetici"  SET "sifre"=sifree where "yonetici"."personelNo"=son;


      

   
   
END
$$;


ALTER FUNCTION public.yonetici(personelbolumid integer, personeladi character, soyadi character, bolumu character, maasi integer, kullanici character, sifree character) OWNER TO postgres;

--
-- Name: zamDegisikligi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."zamDegisikligi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."maas" <> OLD."maas" THEN
        INSERT INTO "zamKayit"("personelNo", "personelAd","personelSoyad", "eskiMaas", "yeniMaas","degisiklikTarihi")
        VALUES(OLD."personelNo", OLD."adi", OLD."soyadi",OLD."maas",NEW."maas" ,CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."zamDegisikligi"() OWNER TO postgres;

--
-- Name: zamyap(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.zamyap(personel integer, zamorani integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
zamliMaas integer;
eskiMaas int;

begin
eskiMaas=(select "maas" from "public"."Calisanlar" where "personelNo"=personel);
zamliMaas:=eskiMaas+(eskiMaas*zamOrani/100);



update "public"."Calisanlar"  SET "maas"=zamliMaas where "Calisanlar"."personelNo"=personel;
return 1;
end;

$$;


ALTER FUNCTION public.zamyap(personel integer, zamorani integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Calisanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Calisanlar" (
    "personelNo" integer NOT NULL,
    adi character(30) NOT NULL,
    soyadi character(30) NOT NULL,
    bolum character(30),
    maas integer
);


ALTER TABLE public."Calisanlar" OWNER TO postgres;

--
-- Name: Calisanlar_personelNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Calisanlar_personelNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Calisanlar_personelNo_seq" OWNER TO postgres;

--
-- Name: Calisanlar_personelNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Calisanlar_personelNo_seq" OWNED BY public."Calisanlar"."personelNo";


--
-- Name: biskuvi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biskuvi (
    "barkodNo" integer NOT NULL,
    cesit character(40),
    gramaj character(10)
);


ALTER TABLE public.biskuvi OWNER TO postgres;

--
-- Name: cikarilanlarKayit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."cikarilanlarKayit" (
    "kayitNo" integer NOT NULL,
    "personelNo" integer NOT NULL,
    "personelAd" character(40),
    "personelSoyad" character(40),
    "eskiMaas" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."cikarilanlarKayit" OWNER TO postgres;

--
-- Name: cikarilanlarKayit_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."cikarilanlarKayit_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."cikarilanlarKayit_kayitNo_seq" OWNER TO postgres;

--
-- Name: cikarilanlarKayit_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."cikarilanlarKayit_kayitNo_seq" OWNED BY public."cikarilanlarKayit"."kayitNo";


--
-- Name: cikolata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cikolata (
    "barkodNo" integer NOT NULL,
    cesit character(40),
    marka character(40)
);


ALTER TABLE public.cikolata OWNER TO postgres;

--
-- Name: cips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cips (
    "barkodNo" integer NOT NULL,
    gramaj character(40),
    cesit character(40)
);


ALTER TABLE public.cips OWNER TO postgres;

--
-- Name: depoGorevlisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."depoGorevlisi" (
    "personelNo" integer NOT NULL,
    vardiya character(40)
);


ALTER TABLE public."depoGorevlisi" OWNER TO postgres;

--
-- Name: kola; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kola (
    "barkodNo" integer NOT NULL,
    "birimLitre" character(40),
    marka character(40)
);


ALTER TABLE public.kola OWNER TO postgres;

--
-- Name: mercimek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mercimek (
    "barkodNo" integer NOT NULL,
    "paketAgirligi" character(40),
    "uretimYeri" character(40),
    cesidi character(40)
);


ALTER TABLE public.mercimek OWNER TO postgres;

--
-- Name: pirinc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pirinc (
    "barkodNo" integer NOT NULL,
    "paketAgirligi" character(40),
    "uretimYeri" character(40),
    cesidi character(40)
);


ALTER TABLE public.pirinc OWNER TO postgres;

--
-- Name: satisKaydi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."satisKaydi" (
    "kayitNo" integer NOT NULL,
    "barkodNo" integer NOT NULL,
    "tedarikciNo" integer,
    adet integer,
    "birimFiyat" integer,
    "paketFiyati" integer,
    "urunIsmi" character(50),
    "satisTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."satisKaydi" OWNER TO postgres;

--
-- Name: satisKaydi_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."satisKaydi_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."satisKaydi_kayitNo_seq" OWNER TO postgres;

--
-- Name: satisKaydi_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."satisKaydi_kayitNo_seq" OWNED BY public."satisKaydi"."kayitNo";


--
-- Name: sevkiyatci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sevkiyatci (
    "personelNo" integer NOT NULL,
    "teslimSehri" character(30)
);


ALTER TABLE public.sevkiyatci OWNER TO postgres;

--
-- Name: tedarikciler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikciler (
    "firmaNo" integer NOT NULL,
    "firmaİsmi" character(40),
    sehir character(30),
    adres character(100)
);


ALTER TABLE public.tedarikciler OWNER TO postgres;

--
-- Name: tedarikciler_firmaNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tedarikciler_firmaNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tedarikciler_firmaNo_seq" OWNER TO postgres;

--
-- Name: tedarikciler_firmaNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tedarikciler_firmaNo_seq" OWNED BY public.tedarikciler."firmaNo";


--
-- Name: teslimat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teslimat (
    "teslimatNo" integer NOT NULL,
    "noktaNo" integer,
    "personelNo" integer,
    fatura integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.teslimat OWNER TO postgres;

--
-- Name: teslimatNoktalari; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."teslimatNoktalari" (
    "noktaNo" integer NOT NULL,
    "teslimYeri" character(40),
    sehir character(30),
    adres character(100)
);


ALTER TABLE public."teslimatNoktalari" OWNER TO postgres;

--
-- Name: teslimatNoktalari_noktaNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."teslimatNoktalari_noktaNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."teslimatNoktalari_noktaNo_seq" OWNER TO postgres;

--
-- Name: teslimatNoktalari_noktaNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."teslimatNoktalari_noktaNo_seq" OWNED BY public."teslimatNoktalari"."noktaNo";


--
-- Name: teslimat_teslimatNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."teslimat_teslimatNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."teslimat_teslimatNo_seq" OWNER TO postgres;

--
-- Name: teslimat_teslimatNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."teslimat_teslimatNo_seq" OWNED BY public.teslimat."teslimatNo";


--
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    "barkodNo" integer NOT NULL,
    "tedarikciNo" integer,
    "urunİsmi" character(40) NOT NULL,
    adet integer NOT NULL,
    "birimFiyat" integer NOT NULL,
    "paketFiyati" integer
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- Name: urunKategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."urunKategori" (
    kategori character(40),
    id integer NOT NULL,
    "personelID" integer,
    "personelKategori" character(40)
);


ALTER TABLE public."urunKategori" OWNER TO postgres;

--
-- Name: urun_barkodNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."urun_barkodNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."urun_barkodNo_seq" OWNER TO postgres;

--
-- Name: urun_barkodNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."urun_barkodNo_seq" OWNED BY public.urun."barkodNo";


--
-- Name: yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yonetici (
    "personelNo" integer NOT NULL,
    "kullaniciAdi" character(30) DEFAULT 'A'::bpchar NOT NULL,
    sifre character(30) DEFAULT 'A'::bpchar NOT NULL
);


ALTER TABLE public.yonetici OWNER TO postgres;

--
-- Name: zamKayit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."zamKayit" (
    "kayitNo" integer NOT NULL,
    "personelNo" integer NOT NULL,
    "personelAd" character(40),
    "eskiMaas" real NOT NULL,
    "yeniMaas" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL,
    "personelSoyad" character(40)
);


ALTER TABLE public."zamKayit" OWNER TO postgres;

--
-- Name: zamKayit_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."zamKayit_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."zamKayit_kayitNo_seq" OWNER TO postgres;

--
-- Name: zamKayit_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."zamKayit_kayitNo_seq" OWNED BY public."zamKayit"."kayitNo";


--
-- Name: Calisanlar personelNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Calisanlar" ALTER COLUMN "personelNo" SET DEFAULT nextval('public."Calisanlar_personelNo_seq"'::regclass);


--
-- Name: cikarilanlarKayit kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."cikarilanlarKayit" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."cikarilanlarKayit_kayitNo_seq"'::regclass);


--
-- Name: satisKaydi kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."satisKaydi" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."satisKaydi_kayitNo_seq"'::regclass);


--
-- Name: tedarikciler firmaNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikciler ALTER COLUMN "firmaNo" SET DEFAULT nextval('public."tedarikciler_firmaNo_seq"'::regclass);


--
-- Name: teslimat teslimatNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat ALTER COLUMN "teslimatNo" SET DEFAULT nextval('public."teslimat_teslimatNo_seq"'::regclass);


--
-- Name: teslimatNoktalari noktaNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."teslimatNoktalari" ALTER COLUMN "noktaNo" SET DEFAULT nextval('public."teslimatNoktalari_noktaNo_seq"'::regclass);


--
-- Name: urun barkodNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun ALTER COLUMN "barkodNo" SET DEFAULT nextval('public."urun_barkodNo_seq"'::regclass);


--
-- Name: zamKayit kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."zamKayit" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."zamKayit_kayitNo_seq"'::regclass);


--
-- Data for Name: Calisanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Calisanlar" VALUES
	(17, 'A                             ', 'A                             ', 'Yönetici                      ', 12),
	(3, 'veli                          ', 'kartal                        ', 'sevkiyatçı                    ', 6721),
	(29, 'Ahmet                         ', 'Yılmaz                        ', 'Sevkiyatçı                    ', 5000);


--
-- Data for Name: biskuvi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.biskuvi VALUES
	(96, 'ÇIKOLATALI                              ', '80        ');


--
-- Data for Name: cikarilanlarKayit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."cikarilanlarKayit" VALUES
	(31, 1, 'ahmet                                   ', 'yıldız                                  ', 133, '2020-12-30 00:48:43.407786'),
	(34, 30, 'MEHMET                                  ', 'YILMAZ                                  ', 5000, '2020-12-30 16:44:37.367751'),
	(35, 32, 'YILMAZ                                  ', 'YILMAZ                                  ', 5000, '2020-12-30 17:28:02.731371'),
	(37, 31, 'MEHMET                                  ', 'ALBAYRAK                                ', 7200, '2021-12-14 12:32:37.555382'),
	(38, 33, 'X                                       ', 'X                                       ', 454, '2021-12-14 12:32:42.568248');


--
-- Data for Name: cikolata; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: cips; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: depoGorevlisi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kola; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: mercimek; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: pirinc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: satisKaydi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."satisKaydi" VALUES
	(70, 94, 2, 10, 3, 30, 'Bisküvi                                           ', '2020-12-30 17:29:40.80974'),
	(71, 95, 3, 10, 7, 70, 'Kola                                              ', '2020-12-30 17:29:50.686799');


--
-- Data for Name: sevkiyatci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sevkiyatci VALUES
	(3, 'A                             '),
	(29, 'ankara                        ');


--
-- Data for Name: tedarikciler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tedarikciler VALUES
	(1, 'A                                       ', 'ÇORUM                         ', NULL),
	(2, 'B                                       ', 'ANKARA                        ', NULL),
	(3, 'C                                       ', 'SAKARYA                       ', NULL),
	(4, 'D                                       ', 'ESKİŞEHİR                     ', NULL),
	(12, 'ETİ                                     ', 'ANKARA                        ', 'GÜL SOKAK                                                                                           ');


--
-- Data for Name: teslimat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teslimat VALUES
	(1, 1, 3, 15),
	(10, 11, 29, 100);


--
-- Data for Name: teslimatNoktalari; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."teslimatNoktalari" VALUES
	(1, 'Abc Market                              ', 'ÇORUM                         ', NULL),
	(11, 'X MARKET                                ', 'İSTANBUL                      ', 'A SOKAK                                                                                             ');


--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urun VALUES
	(96, 12, 'Bisküvi                                 ', 4, 2, 8);


--
-- Data for Name: urunKategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."urunKategori" VALUES
	('Bisküvi                                 ', 1, 1, 'Depo Görevlisi                          '),
	('Çikolata                                ', 2, 2, 'Sevkiyatçı                              '),
	('Kola                                    ', 6, 0, '                                        '),
	('Cips                                    ', 4, 0, '                                        '),
	('Mercimek                                ', 5, 0, '                                        '),
	('Pirinç                                  ', 3, 3, 'Yönetici                                ');


--
-- Data for Name: yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yonetici VALUES
	(17, 'b                             ', 'b                             ');


--
-- Data for Name: zamKayit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."zamKayit" VALUES
	(9, 1, 'ahmet                                   ', 121, 133, '2020-12-30 00:46:09.418213', 'yıldız                                  '),
	(10, 3, 'veli                                    ', 6110, 6721, '2020-12-30 16:34:32.510553', 'kartal                                  '),
	(11, 31, 'MEHMET                                  ', 5000, 6000, '2020-12-30 17:23:20.107106', 'ALBAYRAK                                '),
	(12, 31, 'MEHMET                                  ', 6000, 7200, '2020-12-30 17:27:30.982422', 'ALBAYRAK                                ');


--
-- Name: Calisanlar_personelNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Calisanlar_personelNo_seq"', 33, true);


--
-- Name: cikarilanlarKayit_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."cikarilanlarKayit_kayitNo_seq"', 38, true);


--
-- Name: satisKaydi_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."satisKaydi_kayitNo_seq"', 71, true);


--
-- Name: tedarikciler_firmaNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tedarikciler_firmaNo_seq"', 12, true);


--
-- Name: teslimatNoktalari_noktaNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."teslimatNoktalari_noktaNo_seq"', 11, true);


--
-- Name: teslimat_teslimatNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."teslimat_teslimatNo_seq"', 4, true);


--
-- Name: urun_barkodNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."urun_barkodNo_seq"', 96, true);


--
-- Name: zamKayit_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."zamKayit_kayitNo_seq"', 12, true);


--
-- Name: zamKayit PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."zamKayit"
    ADD CONSTRAINT "PK" PRIMARY KEY ("kayitNo");


--
-- Name: biskuvi biskuviPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biskuvi
    ADD CONSTRAINT "biskuviPK" PRIMARY KEY ("barkodNo");


--
-- Name: Calisanlar calisanPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Calisanlar"
    ADD CONSTRAINT "calisanPK" PRIMARY KEY ("personelNo");


--
-- Name: cikolata cikolataPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cikolata
    ADD CONSTRAINT "cikolataPK" PRIMARY KEY ("barkodNo");


--
-- Name: cips cipsPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cips
    ADD CONSTRAINT "cipsPK" PRIMARY KEY ("barkodNo");


--
-- Name: depoGorevlisi depoGorevlisiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."depoGorevlisi"
    ADD CONSTRAINT "depoGorevlisiPK" PRIMARY KEY ("personelNo");


--
-- Name: cikarilanlarKayit kayitPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."cikarilanlarKayit"
    ADD CONSTRAINT "kayitPK" PRIMARY KEY ("kayitNo");


--
-- Name: kola kolaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kola
    ADD CONSTRAINT "kolaPK" PRIMARY KEY ("barkodNo");


--
-- Name: mercimek mercimekPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mercimek
    ADD CONSTRAINT "mercimekPK" PRIMARY KEY ("barkodNo");


--
-- Name: pirinc pİRİNCPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pirinc
    ADD CONSTRAINT "pİRİNCPK" PRIMARY KEY ("barkodNo");


--
-- Name: satisKaydi satisPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."satisKaydi"
    ADD CONSTRAINT "satisPK" PRIMARY KEY ("kayitNo");


--
-- Name: sevkiyatci sevkiyatciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sevkiyatci
    ADD CONSTRAINT "sevkiyatciPK" PRIMARY KEY ("personelNo");


--
-- Name: tedarikciler tedarikciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikciler
    ADD CONSTRAINT "tedarikciPK" PRIMARY KEY ("firmaNo");


--
-- Name: teslimatNoktalari teslimatNoktaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."teslimatNoktalari"
    ADD CONSTRAINT "teslimatNoktaPK" PRIMARY KEY ("noktaNo");


--
-- Name: teslimat teslimatPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat
    ADD CONSTRAINT "teslimatPK" PRIMARY KEY ("teslimatNo");


--
-- Name: urun urunPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "urunPK" PRIMARY KEY ("barkodNo");


--
-- Name: yonetici yoneticiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT "yoneticiPK" PRIMARY KEY ("personelNo");


--
-- Name: Calisanlar cikarilanlarKayiit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "cikarilanlarKayiit" AFTER DELETE ON public."Calisanlar" FOR EACH ROW EXECUTE FUNCTION public.cikarilanlarkaydet();


--
-- Name: urun satisYapildiginda; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "satisYapildiginda" AFTER DELETE ON public.urun FOR EACH ROW EXECUTE FUNCTION public."satisYapildiginda"();


--
-- Name: urun toplamtrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplamtrigger AFTER INSERT ON public.urun FOR EACH ROW EXECUTE FUNCTION public.toplamfiyat();


--
-- Name: Calisanlar zamYapildiginda; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "zamYapildiginda" BEFORE UPDATE ON public."Calisanlar" FOR EACH ROW EXECUTE FUNCTION public."zamDegisikligi"();


--
-- Name: biskuvi biskuviFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biskuvi
    ADD CONSTRAINT "biskuviFK" FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cikolata cikolataFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cikolata
    ADD CONSTRAINT "cikolataFK" FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cips cipsFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cips
    ADD CONSTRAINT "cipsFK" FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kola kolafk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kola
    ADD CONSTRAINT kolafk FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mercimek mercimekFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mercimek
    ADD CONSTRAINT "mercimekFK" FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sevkiyatci personelNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sevkiyatci
    ADD CONSTRAINT "personelNo" FOREIGN KEY ("personelNo") REFERENCES public."Calisanlar"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yonetici personelNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT "personelNo" FOREIGN KEY ("personelNo") REFERENCES public."Calisanlar"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: depoGorevlisi personelNo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."depoGorevlisi"
    ADD CONSTRAINT "personelNo" FOREIGN KEY ("personelNo") REFERENCES public."Calisanlar"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pirinc pirincfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pirinc
    ADD CONSTRAINT pirincfk FOREIGN KEY ("barkodNo") REFERENCES public.urun("barkodNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: teslimat teslimatFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat
    ADD CONSTRAINT "teslimatFK" FOREIGN KEY ("noktaNo") REFERENCES public."teslimatNoktalari"("noktaNo");


--
-- Name: teslimat teslimatFKK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teslimat
    ADD CONSTRAINT "teslimatFKK" FOREIGN KEY ("personelNo") REFERENCES public.sevkiyatci("personelNo");


--
-- Name: urun urunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "urunFK" FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikciler("firmaNo");


--
-- PostgreSQL database dump complete
--

