f = open("table_main.csv")

rows = f.readlines()
no_rows = len(rows)
no_tables = len(rows)/3

print("There are {} tables".format(no_tables))

'''
create table if not exists <table_name>(<column_name> <data_type>)
'''

for i in range(0, no_rows, 3):
    command = ""
    table_name = rows[i].split(",")[0]

    print(table_name)

