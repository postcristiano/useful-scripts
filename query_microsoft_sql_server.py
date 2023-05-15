import pyodbc

# Set up the database connection
server = 'your_server_name'
database = 'your_database_name'
username = 'your_username'
password = 'your_password'
cnxn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}')

# Set up the cursor
cursor = cnxn.cursor()

# Define the list of keywords to search for
keywords = ['keyword1', 'keyword2', 'keyword3']

# Loop over all tables in the database
for table_info in cursor.tables():
    table_name = table_info.table_name

    # Skip system tables
    if table_name.startswith('sys'):
        continue

    # Loop over all columns in the table
    for column_info in cursor.columns(table=table_name):
        column_name = column_info.column_name

        # Build the SQL query to search for the keywords
        query = f"SELECT * FROM [{table_name}] WHERE [{column_name}] LIKE ?"
        params = ['%' + keyword + '%' for keyword in keywords]

        # Execute the query and print the results
        cursor.execute(query, params)
        rows = cursor.fetchall()
        if len(rows) > 0:
            print(f"Found {len(rows)} matches in table [{table_name}], column [{column_name}]:")
            for row in rows:
                print(row)

