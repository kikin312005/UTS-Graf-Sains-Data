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


// tampikan graph
MATCH (n)
RETURN n;

MATCH (n)-[r]-(m)
RETURN n, r, m
LIMIT 500;

MATCH (v:Visitor)-[d:VIEWED]->(i:Item)
RETURN v,d,i;

//hapus data
MATCH (n)
DETACH DELETE n;

//cek node
MATCH (n)
RETURN count(n) AS jumlah_node;

//cek edge
MATCH ()-[r]->()
RETURN count(r) AS jumlah_relasi;

//hapus 2

MATCH (n)
WITH n
LIMIT 50000
DETACH DELETE n
RETURN count(*) AS jumlah_dihapus;

// cek duplikasi
MATCH (v:Visitor {visitorId: 361387})-[r]->(i:Item {itemId: 43485})
RETURN
    type(r) AS jenis_interaksi,
    r.timestamp AS timestamp,
    r.transactionId AS transactionId,
    count(r) AS jumlah
ORDER BY jenis_interaksi, timestamp;

// cek edge
match (v:Visitor) -[r]->(i:Item)
    where type(r) In ['VIEWED', 'ADDED_TO_CART','BOUGHT']
RETURN
    v.visitorId as visitor_id,
    i.itemId as item_id,
    type(r) as jenis_interaksi,
    count(r) as jumlah_interaksi;
// tampilkan rekomendasi item 
MATCH (a:Item {itemId: 222422})
      -[r:SIMILAR_TO]->(b:Item)
RETURN
    a.itemId AS item_acuan,
    b.itemId AS item_mirip,
    r.cosine_similarity AS similarity
ORDER BY similarity DESC
LIMIT 5;

// tampilkan graf rekomendasi
MATCH (a:Item {itemId: 222422})
      -[r:SIMILAR_TO]->(b:Item)
WITH a, r, b
ORDER BY r.cosine_similarity DESC
LIMIT 5
RETURN a, r, b;