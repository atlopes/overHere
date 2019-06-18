# overHere
## Introduction
overHere is an SDK that wraps access to [Here.com](https://www.here.com "Here.com") location platform resources for VFP applications. Functionalities like map imagery and enrichment, route calculation, and geocoding, are already available, with others to follow as the SDK keeps growing.

Invoking the services and fetching their responses is done through a set of classes that encapsulate the REST calls to Here.com servers.

Developers using overHere must refer to the Here.com API documentation for implementation details. The overHere documentation will focus on how to set the calls and on how results are structured.

## Getting started

Access to Here.com resources requires registration and, at least, the setting up of a project. See the [Here.com](https://www.here.com "Here.com") website for details.

In the examples folder, a few forms illustrate the use of the SDK.

- `MapViewer.scx`, to display maps of a region
- `Statistics.scx`, to display geolocalized visual data
- `Geocoder.scx`, to search geo coordinate locations
- `Itineraries.scx`, to calculate routes and to display their steps

`Geocoder.scx` may provide information for `MapViewer.scx` and `Itineraries.scx` forms, so it may desirable to keep them open at the same time.

In each one of these forms, the call to Here.com resources can be found in self-contained methods. A developer should read the code in `GetImage()`, `GetLocation()`, and `GetRoute()` methods to get a first understanding of the operation of overHere, and to take them as examples of how a VFP application can integrate Here.com resources.

## Screenshots

A map view centered in 10 Downing St., London. Satellite and traffic displays are combined into a single image. A VFP Image control is used to display the map in the form after it's fetched from Here.com servers.

![Map view of 10 Downing St, London](docs/10downing.png "Map view of 10 Downing St, London")

A route calculated from Lisbon to Paris,

![From Lisbon to Paris](docs/lisbon-paris.png "From Lisbon to Paris")

and a segment of the route, when it reaches the Portuguese-Spanish border. The overall distance of the journey is about 1735 km, while this segment has a length of 35 km, approximately.

![At the Portuguese-Spanish border.](docs/lisbon-paris-segment.png "At the Portuguese-Spanish border.")

## Status

In development. Unsuited for production. [Unlicensed](docs/UNLICENSE.md "Unlicense").
