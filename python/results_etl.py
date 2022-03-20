import pandas as pd
import requests
from funcs import get_connection, exec_query

SCHEMA = 'f1_staging'
TABLE = 'results'

def etl_results(year: int, race: int):
    url = 'http://ergast.com/api/f1/{}/{}/results.json?limit=1000'.format(year, race)

    # Get race, quali data.
    r = requests.get(url)
    assert r.status_code == 200, 'Cannot connect to Ergast API. Check your inputs.'
    race_meta = r.json()['MRData']['RaceTable']['Races'][0]
    results = race_meta['Results']

    # Format db records.
    result_db_data = [
        {
            'year': year,
            'round': race,
            'driver_ref': result['Driver']['driverId'],
            'constructor_ref': result['Constructor']['constructorId'],
            'grid': result['grid'],
            'position': result['position'],
            'position_text': result['positionText'],
            'position_order': position_order + 1,
            'points': result['points'],
            'laps': result['laps'],
            'time': result['Time']['time'] if 'Time' in result else None,
            'milliseconds': result['Time']['millis'] if 'Time' in result else None,
            'fastest_lap': result['FastestLap']['lap'] if 'FastestLap' in result else None,
            'rank': result['FastestLap']['rank'] if 'FastestLap' in result else None,
            'fastest_lap_time': result['FastestLap']['Time']['time'] if 'FastestLap' in result else None,
            'fastest_lap_speed': result['FastestLap']['AverageSpeed']['speed'] if 'FastestLap' in result else None,
            'status': result['status']
        }
        for position_order, result in enumerate(results)
    ]

    # Load db.
    exec_query(f'truncate table {SCHEMA}.{TABLE};')
    pd.DataFrame(result_db_data).to_sql(
        con=get_connection(),
        schema=SCHEMA,
        name=TABLE,
        if_exists='append',
        index=False
    )
    exec_query('call f1.load_results();')

    print(f'Loaded {len(result_db_data)} records into f1.results for year={year} race={race}')


def get_new_races():
    query = """
        select distinct
        year, round
        from f1.races as r
        left join f1.results as rs on rs.race_id = r.race_id
        where date - 1 <= current_date
        and year = (select max(year) from f1.races)
        and rs.race_id is null
        order by year desc, round desc;    
    """
    races = exec_query(query)
    return races


def sync_results():
    for year, race_round in get_new_races():
        etl_results(year, race_round)


if __name__ == '__main__':
    sync_results()