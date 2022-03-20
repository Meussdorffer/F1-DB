import pandas as pd
from typing import List, Tuple
import requests
from funcs import get_connection, exec_query

SCHEMA = 'f1_staging'
TABLE = 'qualifying'

def qualifying_etl(year: int, race: int):
    if year and race:
        assert year >= 1996, 'Qualifying data only available starting from 1996'
        url = 'http://ergast.com/api/f1/{}/{}/qualifying.json?limit=1000'.format(year, race)
    else:
        url = 'http://ergast.com/api/f1/current/last/qualifying.json?limit=1000'

    # Get race, quali data.
    r = requests.get(url)
    assert r.status_code == 200, 'Cannot connect to Ergast API. Check your inputs.'
    race = r.json()["MRData"]['RaceTable']['Races'][0]
    quali = r.json()["MRData"]['RaceTable']['Races'][0]['QualifyingResults']

    # Format DB records.
    result_db_data = [
        {
            'year': race['season'],
            'round': race['round'],
            'driver_ref': quali_result['Driver']['driverId'],
            'constructor_ref': quali_result['Constructor']['constructorId'],
            'position': quali_result['position'],
            'q1': quali_result.get('Q1'),
            'q2': quali_result.get('Q2'),
            'q3': quali_result.get('Q3')
        }
        for quali_result in quali
    ]

    # Load DB.
    exec_query(f'truncate table {SCHEMA}.{TABLE};')
    pd.DataFrame(result_db_data).to_sql(
        con=get_connection(),
        schema=SCHEMA,
        name=TABLE,
        if_exists='append',
        index=False
    )
    exec_query('call f1.load_qualifying();')

if __name__ == '__main__':
    qualifying_etl(2022, 1)
