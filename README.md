# Beer box

iOS Developer - Exercise #1

**Purpose of the exercise**: to evaluate code organization and style, network management, ability to follow UI mockups.

**Request**: Develop an iOS application (preferably in Swift) that given a database of beers (provided by punkapi.com) allows the user to browse it as a list and to search beers by name (ex: "ipa").
Selecting a beer the user can view additional info about that beer, such as: ingredients, brewing method and so forth.
As a starting point you are provided with UI mockups of the beers list and beer detail.

**Note**: The list is paginated and shows a maximum of 25 items at a time. The maximum limit should not be changed, but you have to download the next page when you reach the bottom of the list.

**Optional**: Add the tag filtering using associated foods.

**Supplied material**:

* API documentation: https://punkapi.com/documentation/v2
* Vector resources (svg): https://drive.google.com/drive/folders/1cBjCOZP38Rq5IaPVI8WhmOUqdJu7iH6R
* Mockup: https://drive.google.com/drive/folders/1woFUsvI60Cx-zv0_OrStCG4trq-WMnGv
    * list (00.png or 00_optional.png)
    * detail (01.png)

### Sviluppo

Per la realizzazione dell'esercizio ho preferito utilizzare il pattern MVC al posto del pattern MVVM per evitare di allungare i tempi di sviluppo del progetto.

Per la gestione delle chiamate API ho utilizzato la libreria [**Alamofire**](https://github.com/Alamofire/Alamofire) e per il download delle immagini invece ho utilizzato la libreria [**Kingfisher**](https://github.com/onevcat/Kingfisher), due librerie che uso di frequente nei progetti che realizzo.

Per la gestione delle dipendenze ho utilizzato **Cocoapods**.

Non ho creato classi per la gestione delle chiamate di rete, avendo una sola chiamata da effettuare all'interno del progetto.

Per la paginazione non ho potuto utilizzare il protocol UITableViewDataSourcePrefetching poiché i servizi forniti non hanno una chiamata che consente di sapere quanti sono i risultati totali presenti. Per questo motivo ho dovuto usare un metodo più artigianale che scarica dei nuovi dati quando l'utente arriva al termine della lista.

Per la parte grafica ho provato a mantenere lo stile quanto più simile a quello presenteto nei mockup forniti.

Il progetto **non** è stato ultimato poiché mi sono focalizzato sul secondo esercizio richiesto, quindi ci sono una serie di migliorie grafiche che possono essere effettuate in questo progetto.