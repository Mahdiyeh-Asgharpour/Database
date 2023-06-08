import mysql.connector
from mysql.connector import Error
import pandas as pd
con = pymysql.connect(
    food = 'food_name',
    cooker = 'cooker_name',
    instruction = 'instruction ',
   id = 'id')
cursor = con.cursor()
file = os.path.abspath("new.json")
json_data = open(file).read()
json_obj = json.loads(json_data)
cursor.execute("CREATE TABLE IF NOT EXISTS food (id int unique, FOREIGN KEY (id) REFERENCES main(id), cooker_name VARCHAR(255), instruction VARCHAR(255), food_name VARCHAR(255))")
for data_item in json_obj["items"]:
    id = data_item["id"]
    food  = data_item["food_name"]
    cooker = data_item["cooker_name"]
    instruction= data_item["instruction"]
    cursor.execute("INSERT INTO food (id, cooker_name,instruction,food_name) VALUES (%s, %s, %s, %s)", (id,  cooker, instruction,food))

con.commit()
cursor.execute("SHOW TABLES")
cursor.fetchall()
pd = pd.read_sql("SELECT * FROM food", con)
print(pd)
