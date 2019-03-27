# yama
Yet Another Mobile App

## Capas de la app:


### Data Models:

Data models represent different aspects of the app's business logic on a higher-level. They are loosely based on the proposed structures by TMDB, but with some adjustments.

- Show: Model representing a show
- Genre: Model representing any available genre
- APIShowResults: This is a model representing a direct response for a shows request.
- APIGenresResults: response of a shows genres request.
- VideoResults: This is unused, but it can be used for potentially representing video resources from TMDB.

### Network:

Network models are rather simple, given the scope of the app.
 
- API: Is the access point for remote requests. This is where public methods will be exposed for usage throughout the app. We use Coder for the model mapping.
- GenreAPI/ShowAPI: These are the different available endpoint targets. Targets are a higher level abstraction of HTTP requests, which allows for a higher degree of expressiveness and, with Moya, we can typify requests, for a more robust networking system.

### Views / ViewControllers

The app is basically two screens: Popular shows listing and a Show details screen.

- Popular Shows listing: We fetch the most popular shows from TMDB and we display them in a collection view. There's a search bar on top for show-title-based filtering of results. This is done through a quick `.filter` call on the original response. This allows for very simple filtering, while mantaining data integrity.

- Show Details: This screen displays some available info for the passed show. The VC uses a DI approach to data management, receiving a `Show` object from which we display the data. It fetches the poster and backdrop image using Kingfisher, a popular image caching library, and then applies a noir filter using CoreImage. It also uses `UIImageColors` to calculate the main colors, which we use on the tintView. Image animation is done through a simple validation of scroll offset in relationship to the posters standarized sizes (based on TMDB available sizes).
