import numpy as np
import pandas as pd
from funcs import get_connection

SCHEMA = 'fantasy'
TABLE = 'optimal_picks'

def sync_optimal_picks():
    # Pull current standings.
    df = (
        pd.read_sql('select * from fantasy.current_driver_standings', con=get_connection())
        .sort_values(by='points', ascending=False)
        .assign(standing=lambda df: np.arange(len(df)) + 1)
    )

    # Simulate optimal picks.
    picked_drivers = []
    sim_df = df.copy().iloc[0:0]
    for _, row in df.sort_values(by='draft_order')[['manager', 'draft_order']].iterrows():
        manager, pick_no = row
        next_driver = (
            df[~df['driver'].isin(picked_drivers)]
            .assign(min_standing=lambda df: df['standing'].min())
            .query("standing == min_standing")
            .drop(columns=['min_standing'])
            .assign(
                manager=manager,
                draft_order=pick_no
            )
        )
        picked_drivers.append(next_driver['driver'].to_list()[0])
        sim_df = sim_df.append(next_driver)
    sim_df.drop(columns=['standing'], inplace=True)

    # Send to PG.
    sim_df.to_sql(
        name=TABLE,
        schema=SCHEMA,
        con=get_connection(),
        if_exists='replace',
        index=False
    )

    print(f'Loaded {len(sim_df)} records into {SCHEMA}.{TABLE}.')