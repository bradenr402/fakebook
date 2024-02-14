# Welcome to *fakebook*

## Overview

Welcome to my ***fakebook*** project! This is a personal project aimed at creating a text-based social media application with unique features and a user-friendly interface. While the design is currently only optimized for desktop, ***fakebook*** may eventually be updated to be mobile-friendly too. Stay tuned!
___
This project is part of the Final Project in [The Odin Project](https://www.theodinproject.com)’s [Ruby on Rails Curriculum](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails). You can find the requirements for this project at the [Project: Rails Final Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) page.

## Installation
***fakebook*** is temporarily unavailable on its hosting site, but will be made available again in due course. 

If you would like to try out ***fakebook*** on your own machine, please follow the steps below:
1. Open your terminal and navigate to your preferred directory for cloning the project.

2. Clone the repository:
```shell
git clone https://github.com/bradenr402/fakebook.git
```

3. Change directory to the cloned repository:
```shell
cd fakebook
```

4. Install dependencies:
```shell
bundle install
```

5. Create the database:
```shell
rails db:create
```

6. Migrate the database:
```shell
rails db:migrate
```

7. Start up the application:
```shell
bin/dev
```

You can now access the application by navigating to [localhost:3000](https://localhost:3000) in your web browser.

## Features

- **User Authentication:** Secure sign-up and login functionality to ensure user privacy.
- **Profile Management:** Users can customize their profiles, update information, and upload profile pictures.
- **Post Creation:** Share thoughts and ideas with friends through the app.
- **Friendship System:** Connect with new people, follow other users, and build your network.
- **News Feeds:** Stay updated with the latest posts from friends in your Home Feed, or find new content in your Discover Feed.
- **Connect:** Connect with new users through the Connect Feed.

## Tech Stack

- **Frontend:** [Tailwind CSS](https://tailwindcss.com), [Stimulus](https://stimulus.hotwired.dev/), [Turbo](https://turbo.hotwired.dev/)
- **Backend:** [Ruby on Rails](https://rubyonrails.org/)
- **Database:** [PostgreSQL](https://www.postgresql.org/)
- **Authentication:** [Devise](https://github.com/heartcombo/devise)
- **Deployment:** https://fakebook.fly.dev (hosted on [fly.io](https://fly.io))

## Issues

If you encounter any issues or have suggestions, please [open an issue](https://github.com/bradenr402/fakebook/issues).

## License

This project is licensed under the [MIT License](https://opensource.org/license/mit/). Feel free to use, modify, and distribute the code.
