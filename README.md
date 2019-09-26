# Henle Verlag Commentor

The Henle Verlag Commentor is a sinatra application that allows Users to Comment on and Favorite works held in Henle Verlag’s online catalog.

Users must sign-up to access most of the site. Signing-up requires input of a username, email address, and a password.

Once signed up or logged in, users are able to browse the online catalog via composer’s last name>>list of composers>>list of works.  Users are able to comment on and favorite individual works, which then present on the user’s dashboard.  From their dashboard, users are also able to edit/delete their comments, or remove favorited works from their favorites list.  Users are also able to see comments made, and favorites collected, by other users, which will also give them passiveaccess their respective dashboards.  

Flash error/success messages are given for erroneous log-in attempts, and successful signups.  

## Installation

To use this application locally, clone this repository onto your computer and run ```bundle install```, followed by ```shotgun``` to get a local server running the application.

## Usage

This application allows guests to submit data, including a unique username, favorites declarations and individual comments. It uses ActiveRecord validations in the User model to prevent users from having the same username, which is used to log-in after sign-up.

Users can view any other user’s dashboard, as well as see other user’s inputs within lists of various works, but may not alter any other user’s comments or favorites

lists.

The nokogiri gem is used to systematically scrape the [henle verlag](https://www.henle.de/en/) website as needed by the user’s browsing behavior.  All data scraped from the website is instantiated via dedicated models and persisted into the application database, including some peripheral elements for potential future functionality.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Acknowledgements

This project was inspired by my admiration for the work and legacy of Henle Verlag publishing —one of the pre-eminent publishers of sheet music in the world⁠— created with the skills learned through the [flatironschool](http://flatironschool.com/), and submitted as my Sinatra Project.

## License

[MIT](https://choosealicense.com/licenses/mit/)
