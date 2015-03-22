// Playground - noun: a place where people can play

import UIKit


/*

Das Ziel von dieser Übung ist eine kleine Wetter-App zu programmieren.

Gegeben ist ein App-Gerüst mit folgende Komponenten/Klassen:

- Ein Storyboard 'Main.storyboard' mit der UI-Definition der App (relativ einfach, nur 
  1 Screen).

- Ein Gerüst vom Hauptcontroller 'ViewController'. Dieser Controller wird im Rahmen dieser 
  Übung vervollständigt, damit unsere kleine Wetter-App korrekt funktionieren kann.

- Eine Klasse 'WeatherRequest', die die Abfrage zum Server von openweathermap.org übernimmt
  und ein Modellobjekt mit dem Resultat der Abfrage liefert.

- Das erwähnte Modellobjekt 'WeatherData'

Schauen Sie diese Komponenten, um Ihnen mit dem Projekt vertraut zu machen.


A) In Teil A wollen wir die UI-Elemente und Klassen vom Storyboard-File mit dem Code v
  erbinden:

- Verbinden Sie im Interface-Builder alle Labels, welche wir nach Erhalt der 
  Wetterinformationen vom Server ändern werden, mit deren Outlets in der Controller-Klasse 
  'ViewController'.

- Definieren Sie im Interface-Builder die Verbindung zw. Controller-Klasse und unserer 
  Klasse 'ViewController', damit eine Instanz von 'ViewController' erzeugt wird, wenn die 
  Storyboard-Datei geladen wird.


B) Die Standortabfrage mit CoreLocation ist schon implementiert. Nun müssen Sie in der
  passende Lifecycle-Methode von 'ViewController' den Prozess anstossen (Methode 
  'checkPermission' aufrufen).
  Tipp: wir wollen 'checkPermission' aufrufen, wenn der Controller erscheint.


C) Nach Erhalt vom Standort wird performServerRequest aufgerufen. Lokal sollte
  self.location gesetzt sein. Nun wollen wir diese Methode vervollständigen.

- In dieser Methode wollen wir eine Instanz von WeatherRequest erzeugen und in einer 
  Instanzvariablen von 'ViewController' speichern (dies ist wichtig, damit diese Instanz 
  nach Beendigung der Methode vom Speicher nicht geräumt wird).

- Zunächst wollen wir das Success-Block erzeugen und zuweisen. Dieser Code wird bei Erfolg 
  der Server-Abfrage mit einer Instanz vom Modell 'WeatherData' aufgerufen. 
  Tipp: Sie können dieses Success-Block folgendermassen zuweisen:

  weatherRequest?.successBlock = { weatherData in
    // etwas mit weatherData machen
  }

  Nun wollen wir die Daten aus weatherData lesen und die verschiedene Labels damit updaten 
  Tipp: die Property 'text' von UILabel enthält den Text vom Label, kann gelesen und 
  geschrieben werden.

- Am Ende von 'performServerRequest' können wir die Methode 'performRequest' von 
  'WeatherRequest' aufrufen, damit die Server-Abfrage abgesetzt wird.


D) Nun wollen wir ein Reload-Machanismus implementieren (Optional)

- Im Storyboard-File ist dafür ein Knopf 'Neu laden' definiert. Vom Interface-Builder 
  verbinden Sie nun dessen Aktion 'Touch up inside' mit der Methode 'reloadPressed' von
  'ViewController'.

- Jetzt können Sie die Methode 'reloadPressed' vervollständigen. Sie sollten zuerst 
  'self.location' zurücksetzen (damit die CoreLocation Abfrage nochmals ausgeführt werden 
  kann) und anschliessend 'startLocationRequest' aufrufen.


E) Nun wollen wir noch das Wetter-Icon korrekt setzen.

- Vom Wetter-Service kommt ein Icon-Identifier als Zeichenkette zurück,
  welches das aktuelle Wetter darstellen soll.

- Verbinden Sie im Interface-Builder das Image-View oben rechts mit dem
  Outlet 'iconImageView' von 'ViewController'.

- Nun können Sie die Hilfsklasse WeatherHelper verwenden, um das Bild zu
  laden (in der erwähnten Hilfsklasse ist nur eine Methode vorhanden). Der 
  Aufruf sollte irgendwo in 'performServerRequest' stattfinden (nach 
  Erhalt der Wetterinformation).


*/


