from qualifying_etl import sync_qualifying
from results_etl import sync_results

def run(*args, **kwargs):
    sync_qualifying()
    sync_results()

if __name__ == '__main__':
    run()