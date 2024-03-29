import os
from pathlib import Path
from sqlalchemy import text
from funcs import get_connection
from secrets import *

if __name__ == '__main__':

    db_ddl_dir = Path(__file__).parent.parent / 'db'
    schema_order = ['f1_staging', 'f1', 'analytics', 'fantasy']
    object_type_order = ['tables', 'views', 'routines']

    # Walk through the db directory and execute the DDL files
    with get_connection() as conn:
        for schema in schema_order:

            # Dump/create schema first
            schema_ddl_path = db_ddl_dir / schema / 'schema.sql'
            with open(schema_ddl_path) as schema_f:
                conn.execute(schema_f.read())
                print(f'Executed {schema_ddl_path}.')

            # Create objects in order
            for object_type in object_type_order:
                obj_dir = db_ddl_dir / schema / object_type
                if obj_dir.exists():
                    for obj_ddl in obj_dir.iterdir():
                        print(f'Executing {obj_ddl}.')
                        with open(obj_ddl) as obj_f:
                            conn.execute(text(obj_f.read()))

        # Populate the DB.
        if 's3_bucket' in locals():
            query = f"call f1.init_population('{s3_bucket}', '{s3_stem}', '{aws_region}');"
        else:
            query = f"call f1.init_population('{local_csv_path}');"

        conn.execute(text(query))
