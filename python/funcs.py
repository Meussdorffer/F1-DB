from pathlib import Path
from sqlalchemy import create_engine, text
from secrets import conn_url

def get_connection():
    return create_engine(conn_url).connect().execution_options(autocommit=True)

def exec_query(qrystr: str) -> None:
    conn = get_connection()
    qry = conn.execute(text(qrystr))
    try:
        return qry.fetchall()
    except Exception as e:
        pass
