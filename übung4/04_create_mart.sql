drop schema mart cascade;
create schema mart;

-- Load extension
--CREATE EXTENSION cstore_fdw;

-- create server object to access an external data resource
--CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;

create table mart.d_kunde (
     d_kunde_id bigint GENERATED ALWAYS AS IDENTITY
   , kunde_id integer not null
   , vorname varchar(200) not null
   , nachname varchar(200) not null
   , anrede varchar(20) 
   , geschlecht varchar(20) 
   , geburtsdatum date
   , wohnort_id integer not null
   , ort varchar(200) 
   , land varchar(200) 
   , constraint pk_d_kunde primary key (d_kunde_id)
);

create table mart.d_fahrzeug (
     d_fahrzeug_id bigint GENERATED ALWAYS AS IDENTITY
   , fin char(17) not null
   , kfz_kennzeichen varchar(20) not null
   , baujahr integer not null
   , modell varchar(200) not null
   , hersteller varchar(200) not null
   , constraint pk_d_fahrzeuge primary key (d_fahrzeug_id)
);

create table mart.d_ort (
     d_ort_id bigint GENERATED ALWAYS AS IDENTITY
   , ort varchar(200) not null
   , land varchar(200) 
   , constraint pk_d_ort primary key (d_ort_id)
);

create foreign table mart.f_fzg_messung (
     messung_erzeugt timestamp not null
   , empfang_eingetroffen timestamp not null
   , d_kunde_id bigint not null
   , d_fahrzeug_id bigint not null
   , d_ort_id bigint not null
   , geschwindigkeit numeric not null
)
SERVER cstore_server
;

