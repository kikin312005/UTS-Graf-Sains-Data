from neo4j import GraphDatabase
from getpass import getpass
# 1.2.2 cek koneksi
URI = "neo4j://127.0.0.1:7687"
USER = "neo4j"
# PW = getpass("Masukkan password Neo4j: ")
PW = "24031554098"
DB = "uts"

auth =(USER,PW)
# driver = GraphDatabase.driver(URI,auth=auth)

# try:
#     driver.verify_connectivity()
#     print("koneksi neo4j berhasil")
    
#     with driver.session(database=DB) as session:
#         result = session.run(
#             "RETURN 'Koneksi ke database uts berhasil!' AS pesan"
#         )
#         record = result.single()
#         print(record["pesan"])
        
# except Exception as e:
#     print("koneksi gagal",e)
    
# finally:
#     driver.close()
    

# 1.2.3 pembuatan sebuah Node berikut dengan relationship-nya.
def add_friends(driver,name,friends):
    with driver.session(database=DB) as session:
        session.run(
            "MERGE (n:Person {name: $name}) "
            "MERGE (f:Person {name: $friends}) "
            "MERGE (n)-[:KNOWS]->(f) ",
            name=name,friends=friends
        ).consume()
    print(f"Relasi {name} -> {friends} berhasil dibuat.")
# 1.2.4 mencetak dan menjalankan keseluruhan
def print_friends(driver, name):
    with driver.session(database=DB) as session:
        result= session.run(
            "MATCH (n:Person)-[:KNOWS]->(f) "
            "WHERE n.name = $name "
            "RETURN f.name as friends " 
            "ORDER BY friends",
            name=name
        )
        records = result
        print(f"daftra teman {name} :")
        for record in records:
            print(f'- {record["friends"]}')

with GraphDatabase.driver(URI,auth=auth, ) as driver:
    add_friends(driver,"Arthur", "Guinevere")
    add_friends(driver,"Arthur", "Lancelot")
    add_friends(driver,"Arthur", "Merlin")
    print_friends(driver, "Arthur")