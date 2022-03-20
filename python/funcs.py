from pathlib import Path
from sqlalchemy import create_engine
from secrets import conn_url

def get_connection():
    return create_engine(conn_url).connect().execution_options(autocommit=True)

def exec_query(qrystr: str) -> None:
    db = create_engine(conn_url)
    with db.connect().execution_options(autocommit=True) as conn:
        return conn.execute(qrystr)
