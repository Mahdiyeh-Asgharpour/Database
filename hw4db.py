import psycopg2


def create():
    cur.execute(
        'CREATE TABLE books (book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR(255) NOT NULL,author VARCHAR(255) NOT NULL,publisher VARCHAR(255) NOT NULL,price DECIMAL(10,2) NOT NULL,available BOOLEAN NOT NULL DEFAULT true)')
    conn.commit()


def insert(data):
    cur.execute('INSERT INTO books (name, author,publisher,price) VALUES (%s,%s ,%s,%s);', data)
    conn.commit()


def read(query):
    cur.execute(query)
    rows = cur.fetchall()
    return rows


def update_available(data):
    cur.execute('UPDATE books SET available = false WHERE book_id = %s', data)
    conn.commit()


def delete(data):
    cur.execute('DELETE FROM books WHERE book_id =  %s', data)
    conn.commit()


if __name__ == '__main__':
    conn = psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password="admin",
        host="localhost",
        port="5432"
    )
    cur = conn.cursor()

    create()

    data = ('harrypotter', 'J. K. Rowling', 'Bloomsbury', 3.8)
    insert(data)

    data = ('The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 12.99)
    insert(data)

    query = 'SELECT * FROM books'
    print(read(query))
    
    data = (1,)
    update_available(data)

    query = 'SELECT * FROM books'
    print(read(query))

    data = (2,)
    delete(data)

    query = 'SELECT * FROM books'
    print(read(query))

    cur.close()
    conn.close()
