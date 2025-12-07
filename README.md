# PrimefitTask – Project README

## 📌 Project Overview

PrimefitTask is a SwiftUI app demonstrating **API pagination**, **local
caching**, and **offline support** using **SwiftData**.  
The app loads characters from an external API, caches them locally, and
supports smooth pagination.

The architecture is kept simple: **SwiftUI + MVVM + Service Layer +
Local DB Manager**.

------------------------------------------------------------------------

## 🏛 Architecture Diagram

     ┌─────────────┐
     │    View     │
     │ Characters  │
     └──────┬──────┘
            │ observes @Published state
     ┌──────▼──────┐
     │ ViewModel   │
     │ (business   │
     │  logic)     │
     └──────┬──────┘
            │ calls
     ┌──────▼────────┐       ┌───────────────┐
     │ NetworkManager │       │   DBManager   │
     │ (Remote fetch) │       │ (Local cache) │
     └──────┬────────┘       └──────┬────────┘
            │                        │
            └──────────┬────────────┘
                       ▼
                   Characters

------------------------------------------------------------------------

## 📦 Module Breakdown & Responsibilities

### **1. CharactersListViewModel**

-   Controls pagination logic  
-   Decides when to load from API vs database  
-   Updates UI state (`@Published`)  
-   Stores characters in SwiftData  
-   Handles loading + error states

### **2. NetworkManager**

-   Makes API requests  
-   Decodes JSON  
-   Conforms to `CharacterServiceProtocol`  
-   Throws meaningful `APIError`s

### **3. DBManager**

-   Stores & retrieves characters using SwiftData  
-   Loads saved characters for offline usage  
-   Clears/enforces page resets

### **4. View (CharactersListView)**

-   Shows characters  

-   Calls:

    ``` swift
    await viewModel.loadFirstPage()
    await viewModel.loadCharacters()
    ```

------------------------------------------------------------------------

## 🧠 Caching Strategy (SwiftData)

The flow:

1.  On app open → ViewModel calls:

    ``` swift
    let saved = dbManager.loadCharacters()
    ```

2.  If saved data exists → show immediately (offline-friendly)

3.  Else → fetch first page from API

4.  After each successful page load:

    ``` swift
    dbManager.saveCharacters(newData)
    ```

This gives: - Instant loading  
- No unnecessary API calls  
- Data persistence across app restarts

### **Why SwiftData?**

-   Built-in persistence  
-   Minimal boilerplate  
-   Easy offline loading

------------------------------------------------------------------------

## 🔄 Pagination Flow

1.  First screen opens → `loadFirstPage()`  

2.  If DB has data → show  

3.  Otherwise:

    -   Reset states  
    -   Fetch from API  

4.  For next pages:

    ``` swift
    loadCharacters()
    ```

5.  ViewModel ensures:

    -   No double calls  
    -   No loading beyond maxPages  
    -   No loading if already loading  

6.  Appends new data to list  

7.  Saves to DB

------------------------------------------------------------------------

## ⚖️ Architecture Decisions & Trade-offs

### **Why no Repository layer?**

A repository adds: - Caching orchestration  
- Local + remote merging  
- Data mapping

But this project is small and already handles caching in ViewModel +
DBManager.  
So **removing repository keeps architecture simple**.

### **Why use protocols (for services)?**

Even though NetworkManager is a singleton, the protocol allows: -
Mocking in tests  
- Flexible dependency injection  
- Future ability to replace entire service layer

------------------------------------------------------------------------

## 🧪 Testing Strategy

### **ViewModel Test**

Mock dependencies: - MockNetworkManager - MockDBManager

Test: - First page load  
- Pagination logic  
- Error handling  
- DB save calls

### **Service Test**

Test: - NetworkManager.decode  
- API failures  
- Invalid URL

------------------------------------------------------------------------

## ⚙️ Setup Instructions

### **Requirements**

-   macOS Ventura+
-   Xcode 15+
-   iOS 17+
-   Swift 5.9+

### **Installation**

1.  Clone project  
2.  Open `PrimefitTask.xcodeproj`  
3.  Run the app

### **SwiftData Setup**

Model containers are initialized in:

``` swift
.modelContainer(for: [CharacterModel.self])
```

------------------------------------------------------------------------

## 📁 Folder Structure Recommendation

    PrimefitTask
     ├── Models
     ├── ViewModels
     ├── Views
     ├── Services
     │     ├── NetworkManager.swift
     │     └── APIError.swift
     ├── Database
     │     └── DBManager.swift
     ├── Utilities
     └── PrimefitTaskApp.swift

------------------------------------------------------------------------
