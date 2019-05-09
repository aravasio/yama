# yama
Yet Another Mobile App

## Capas de la app:

### Data Models:

Data models represent different aspects of the app's business logic on a higher-level. They are loosely based on the proposed structures by TMDB, but with some adjustments.

- Movie: Model representing a movie
- Genre: Model representing any available genre
- Video: Model representing any available video of a given movie (trailer, teaser, etc)
- APIShowResults: This is a model representing a direct response for a shows request.
- APIGenresResults: response of a shows genres request.
- APIVideoResults: Response format of the videos request.

### Network:

Network models are rather simple, given the scope of the app.
 
- API: Is the access point for remote requests. This is where public methods will be exposed for usage throughout the app. We use Coder for the model mapping.
- GenreAPI/MovieAPI/VideoAPI: These are the different available endpoint targets. Targets are a higher level abstraction of HTTP requests, which allows for a higher degree of expressiveness and, with Moya, we can typify requests, for a more robust networking system.

### Views / ViewControllers

The app is basically three screens: Popular movies listing and a Movie details screen. The VideoViewController screen is a placeholder for a feature without UI design... yet.

- Popular Movies listing: We fetch the most popular movies from TMDB and we display them in a collection view. There's a search bar on top for show-title-based filtering of results. This is done through a quick `.filter` call on the original response. This allows for very simple filtering, while mantaining data integrity.

- Show Details: This screen displays some available info for the passed show. The VC uses a DI approach to data management, receiving a `Show` object from which we display the data. It fetches the poster and backdrop image using Kingfisher, a popular image caching library, and then applies a noir filter using CoreImage. It also uses `UIImageColors` to calculate the main colors, which we use on the tintView. Image animation is done through a simple validation of scroll offset in relationship to the posters standarized sizes (based on TMDB available sizes).

- VideoViewController: This screen's sole purpose is to serve as a placeholder for future UI/UX improvements. Basically I wanted to support getting videos for a given movie, but I could not come up with some UI/UX idea that would make it fit in nicely, so I just put it in a separated place in the meantime. The functionality now exists, we just need to figure out where and how to present it.

### Caching

Caching was done using CoreData. We simply store the received, valid responses and use that in case something fails on the network side later on.

- DatabaseManager: In charge of providing an interface for easy store/load operations.

- DataProvider: Manager for determining where to get data from. If there's no internet access, it aims for the data in CoreData, otherwise makes remote requests through API. 

## What is the Single Responsibility Principle? What is its' purpose?
### The single responsibility principle is a computer programming principle that states that every module, class, or function should have responsibility over a single part of the functionality provided by the software, and that responsibility should be entirely encapsulated by the class.

### The idea behind it is that smaller-scope entities are inherently more rebust, are easier to test, matain and refactor/discard over time.

### To me, a good piece of code is one that's both clear and concise. It's as expressive as possible about its intent and scope, and tries to keep up with detailed documentation within the code itself about usability. It handles as little state as reasonably possible, and probably makes great use of stuff such as Dependency Injection or other "low mutability" strategies to keep data integrity across the board.

