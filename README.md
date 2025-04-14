
# 📱 HueMood – Deine smarte Lichtstimmungen-App

**HueMood** ist eine SwiftUI-App zur Steuerung smarter Lichtstimmungen über eine Philips Hue Bridge.  
Die App erlaubt es, aus vordefinierten oder benutzerdefinierten Moods zu wählen, diese anzuwenden oder sogar zeitgesteuert zu aktivieren – inklusive Benachrichtigung.

---

## 🔥 Features

- 🎨 Auswahl aus vorgegebenen Lichtstimmungen (Farbe, Helligkeit)
- 🖌 Benutzerdefinierte Moods mit Hex-Farbcode & Helligkeit
- ✅ Anwendung von Moods mit Übergangseffekten & Feedback
- ⏰ Zeitgesteuertes Planen von Stimmungen mit Benachrichtigungen
- 💾 Persistente Speicherung über `UserDefaults`
- 🔁 Dynamischer UI-Gradient je nach Stimmung
- 🧠 Trennung von Logik (ViewModel) und UI (View)

---

## 🧱 Architektur

- **MVVM-Pattern** (Model - View - ViewModel)
- **HueAPIService**: Mock-API-Anbindung zur Philips Hue Bridge
- **NotificationManager**: Lokale Benachrichtigungen
- **MoodViewModel & ScheduledMoodViewModel**: Business-Logik
- **Color+Hex.swift**: Custom Color-Initializer für HEX-Werte

---

## 📲 Screens (Beispielhaft)

| Mood-Auswahl | Mood-Detail | Stimmung planen |
|--------------|-------------|------------------|
| (preview1.png) | (preview2.png) | (preview3.png) |

---

## 🛠 Technologien

- **Swift 5.9+**
- **SwiftUI**
- **Combine / ObservableObject**
- **UNUserNotificationCenter**
- **URLSession** (für Netzwerk-Calls zur Bridge)

---

## 🚀 Getting Started

```bash
git clone https://github.com/deinname/MoodLight.git
open MoodLight.xcodeproj
```

> 💡 Für die Steuerung echter Hue-Lichter muss die lokale IP & dein Hue-API-Username eingetragen werden in `HueAPIService.swift`.

---

## 🧪 Testen im Preview-Modus

- Keine Hue-Bridge erforderlich – alle Funktionen nutzbar
- Lokale Vorschau mit animiertem UI & Lichtverläufen
- Einstellungen können direkt im Preview ausprobiert werden

---

## 📂 Dateistruktur (Auszug)

```
MoodLight/
├── Models/
│   ├── Mood.swift
│   └── ScheduledMood.swift
├── ViewModels/
│   ├── MoodViewModel.swift
│   └── ScheduledMoodViewModel.swift
├── Services/
│   ├── HueAPIService.swift
│   └── NotificationManager.swift
├── Views/
│   ├── ContentView.swift
│   ├── SettingsView.swift
│   └── MoodDetailView.swift
├── Extensions/
│   └── Color+Hex.swift
└── Assets/
    └── AppIcon, Farben, etc.
```

---

## 👤 Autor

> 📧 **Kevin Schubert**  
> 📍 Monschau / 01.07.2025 / Remote (wenn möglich auch vor Ort) 
> 💼 GitHub: (https://github.com/KevinSchubert98)  


---

## 📌 Hinweis

> Diese App ist aktuell mit einem **Mock-Server** verbunden (`localhost:3001`).  
> Für den Livebetrieb mit einer echten Hue-Bridge kann die URL & dein API-User in `HueAPIService.swift` angepasst werden.
