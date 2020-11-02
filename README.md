# weatherconditions
Weather conditions app with data from openweathermap.org

L'app e' molto semplice da usare, non prevede nessun tipo di installazione se la si vuole lanciare su simulatore.
Occorre soltanto aprire il file di progetto weatherconditions.xcodeproj, e premere il tasto run. 

Nella ricerca di una città, si puo effettuare ricerca della singola città oppure specificare la nazione, aggiungendo una ' , ' seguita dal codice nazione. Ad esempio " Roma,IT ".

Nella root di progetto, e' presente anche un video dimostrativo dell'app.


Come struttura dell'app si e' scelto il modello MVVM, strutturando il progetto con i relativi view controllers e models. 
Per la gestione dei model e la visualizzazione di dati si e' ricorsi all'utilizzo del Framework Combine di apple.
