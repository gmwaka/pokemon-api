# README

Controlled Health website API built with [Ruby on Rails](https://rubyonrails.org/) as API and using [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth).

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      3.0.1
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.1.3.2
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      Sqlite3
    </td>
  </tr>
</table>

## Configuration

```bash
git clone git@github.com:gmwaka/pokemon-api.git
cd pokemon-api

# installation of dependencies
bundle install

# creation of database and tables
rails db:create
rails db:migrate

# load initial data
rails db:seed

# run the project
rails s
```
