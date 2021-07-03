# How to deploy app to Heroku
### Create app on Heroku
- `heroku create` in your app directory
### Conduct asset precompile
- `rails assets:precompile RAILS_ENV=production`
### Push to heroku repo
- `git push heroku master`
- You may need to run below before pushing codes
  - `bundle lock --add-platform x86_64-linux`
  - `git add .`
  - `git commit -m "some message"`
### Database migraiton
- `heroku run rails db:migrate`
### You should be able to access your app link!

<br><br>

# Table schema
### `User` model
- id
- email: string
- name: string
- password_digest: string
### `Task` model
- id
- user_id
- label_id
- title: string
- description: text
- due_date: date
- priority: integer
- status: string
## `Label` model
- id
- task_id
- label_name: string
