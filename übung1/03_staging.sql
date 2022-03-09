insert
into staging.kunde (kunde_id , vorname , nachname , anrede, geschlecht , geburtsdatum , wohnort, quelle)
values
(171999, 'Jane', 'Doe', 'Frau', 'weiblich', to_date ('04.02.1969', 'DD.MM.YYYY'), 7, 'CRM');

insert
into staging.fahrzeug (fin , kunde_id , baujahr , modell , quelle)
values
('SNTU411STM9032259', 171999, 1932, 'fiat 65', 'Fahrzeug DB');
insert
into staging.kfzzuordnung (fin , kfz_kennzeichen , quelle)
values
('SNTU411STM9032259', 'S-JD 123', 'Fahrzeug DB');