f = open("table_main.csv")

rows = f.readlines()
no_rows = len(rows)
no_tables = len(rows)/3

print("There are {} tables".format(no_tables))

'''
create table if not exists <table_name>(<column_name> <data_type>)
'''

commands = []

for i in range(0, no_rows, 3):
    command = ""
    columns_current = []

    table_name = rows[i].split(",")[0]

    command += "create table if not exists {} (".format(table_name)

    columns = rows[i+1].split(",")
    datatypes = rows[i+2].split(",")

    # Ignore empty columns and \n
    i = 0
    for column in columns:
        if(column=='' or column=='\n'):
            pass
        else:
            c_name = column
            c_type = datatypes[i]

            columns_current.append(c_name)

            command += "{} {}, ".format(c_name, c_type)
        i+=1
    command += ")"

    command.replace(", )", ");")

    commands.append(command)

    # var list = await db.query('my_table', columns: ['name', 'type']);
    print("await db.query('{}', columns: {});".format(table_name, columns_current))

print()
print(commands)
