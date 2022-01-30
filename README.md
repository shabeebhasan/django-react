- Baydot Django App Start

Installation
Install pipenv
Clone this repo and cd wild_breeze_26494
Run pip install --user --upgrade pipenv to get the latest pipenv version.
Run pipenv --python 3.6
Run pipenv install
Run cp .env.example .env
Update .env file DATABASE_URL with your database_name, database_user, database_password, if you use postgresql. Can alternatively set it to sqlite:////tmp/my-tmp-sqlite.db, if you want to use sqlite for local development.
Getting Started
Run pipenv shell
Run python manage.py makemigrations
Run python manage.py migrate
Run python manage.py runserver
