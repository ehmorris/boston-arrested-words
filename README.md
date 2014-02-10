## What are the most commonly said words when being arrested, per neighborhood in Boston?

#### Setup
* run `bundle install && rake db:create && rake db:migrate`
* run `rake parse_csv:populateDatabase` to populate a database with the contents of `public/boston-crime-with-unusual-actions.csv`
* run the server with `rails s`

#### Resources
- [The data](https://data.cityofboston.gov/Public-Safety/Crime-Incident-Reports/7cdf-6fgx)
- [A neighborhood map](http://bostonography.com/2013/neighborhoods-as-seen-by-the-people/)
- [A race map](http://bostonography.com/2012/blue-and-bluer-massachusetts-and-boston-2012/)
- [A map of MA housing prices](http://www.bostonglobe.com/business/2013/08/31/buyers-beware/tBP1ddHScxftFeBL8TDvLP/igraphic.html)
- [NYTimes dialect heatmap](http://www.nytimes.com/interactive/2013/12/20/sunday-review/dialect-quiz-map.html)
- [Word stemming](http://en.wikipedia.org/wiki/Stemming)
