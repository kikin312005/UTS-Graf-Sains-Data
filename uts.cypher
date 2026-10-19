CALL dbms.components()
YIELD name, versions, edition
RETURN name, versions, edition;

SHOW DATABASES;

USE uts
RETURN 'Berhasil menggunakan database uts' AS pesan;

USE uts
MATCH (n)
RETURN COUNT(n) as jumlah_node;

CREATE DATABASE test2;

USE test
RETURN 'Berhasil menggunakan database test' AS pesan;

USE test
MATCH (n)
RETURN COUNT(n) as jumlah_node;

DROP DATABASE test2;