from sqlalchemy import create_engine, text
import pyodbc
from prettytable import PrettyTable
import configparser

def create_engine_connection():
    # Laddar konfigurationer från en .ini-fil
    config = configparser.ConfigParser()
    config.read('database.ini')

    # Hämtar anslutningsuppgifter från konfigurationsfilen
    database_type = config['DATABASE']['Type']
    server = config['DATABASE']['Server']
    database = config['DATABASE']['Database']
    driver = config['DATABASE']['Driver']
    trusted_connection = config['DATABASE']['Trusted_Connection']

    # Skapar en anslutningssträng baserat på ovanstående uppgifter och returnerar en SQLAlchemy "engine"
    connection_string = f'{database_type}://@{server}/{database}?driver={driver}&trusted_connection={trusted_connection}'
    return create_engine(connection_string)

def get_user_input():
    # Interagerar med användaren för att få söksträng eller visa hjälpinstruktioner
    print("Ange en boktitel att söka efter (eller skriv 'hjälp' för att lära dig mer): ")
    keyword = input("Sök efter boktitel: ")
    if keyword.lower() == 'hjälp':
        print("\nWildcard-sökning...")
        print("Använd '%' som wildcard för att ersätta en eller flera tecken.")
        print("Exempel: '%Harry' hittar alla titlar som slutar med 'Harry'.")
        print("'Potter%' hittar alla titlar som börjar med 'Potter'.")
        print("'%Harry Potter%' hittar alla titlar som innehåller 'Harry Potter'.\n")
        return None, None  # Returnerar None för att signalera att hjälp har visats
    exact_match = input("Sök på exakt matchning? (ja/nej): ").lower()
    exact_match = 'ja' in exact_match
    return keyword, exact_match

def execute_search_query(engine, keyword, exact_match):
    # Definierar SQL-fråga för att hitta böcker baserat på titel med möjlighet att ange exakt matchning
    query = """
    SELECT B.Titel, F.Förnamn + ' ' + F.Efternamn AS Författare, B.Språk, B.Pris, LS.ButikID, LS.Antal
    FROM Böcker B
    JOIN Författare F ON B.FörfattareID = F.ID
    JOIN LagerSaldo LS ON B.ISBN13 = LS.ISBN
    WHERE B.Titel LIKE :keyword
    """
    keyword = f"%{keyword}%" if not exact_match else keyword.replace('%', '')
    with engine.connect() as connection:
        result = connection.execute(text(query), {"keyword": keyword})
        books = result.mappings().all()
    return books

def print_books(books):
    # Visar sökresultat i en tabell för tydlig presentation
    if not books:
        print("Inga böcker matchar din sökning.")
        return

    book_table = PrettyTable()
    book_table.field_names = ["Titel", "Författare", "Språk", "Pris", "ButikID", "Antal i Lager"]

    for book in books:
        book_table.add_row([book['Titel'], book['Författare'], book['Språk'], f"{book['Pris']} kr", book['ButikID'], book['Antal']])

    print(book_table)

def main():
    # Huvudfunktion som styr programmets flöde
    engine = create_engine_connection()
    while True:
        keyword, exact_match = get_user_input()
        if keyword is None:
            continue  # Skip till nästa iteration om användaren begär hjälp
        books = execute_search_query(engine, keyword, exact_match)
        print_books(books)

        # Frågar användaren om att fortsätta eller avsluta
        while True:
            continue_search = input("Vill du göra en annan sökning? (ja/nej): ").lower().strip()
            if continue_search in ['ja', 'nej']:
                break
            print("Ange endast 'ja' eller 'nej'.")
        
        if continue_search == 'nej':
            break  # Avslutar loopen om användaren svarar 'nej'

if __name__ == "__main__":
    main()
