# README
## Pagination 

 Rails app with a single endpoint "/apps" that returns an array of apps paginated.
##  Solution Description
In order to build the application with a the single HTTP API endpoint that will return an array of "apps" in JSON format following the request data. First the controller (rails generate controller Apps) and the model (rails generate model App name:string) are created. Didn't add an id to the model because it is added by default in Ruby on Rails. To complete the setup, data was created within the **seeds.rb** file, and after that calls to migrate and seed to finish creating the table and adding the sample data (calling rails db:migrate, followed by rails db:seed).
In the controller, the POST call is received by convention in the **create** method of Ruby, and there the body is processed and based on that data coming as params in the POST body, the "apps" table can be filtered. I defined the parameters that are allowed in the range_params function, from there what I do is take the values that have been received and add check the missing ones to add default values. The values are validated and using the @error variable an error message would be returned.

 ## To create the application:

1. Started with Rails Application:
```
    rails new pagination
    cd pagination
```
 
2. Added the Model, View, Controller for the application:
```
   rails generate model App title:string 
   rails generate controller apps
 ```

3. Migration and Seeding the database
``` 
     rails db:migrate
     rails db:seed
```
 4. Created the endpoint to handle pagination requests.
 5. Added test cases, some boundary tests and tested the requirements provided in the instructions.


## Set up & Running

```
1. git clone https://github.com/Yani010712/pagination.git
2. cd pagination
3. bundler install
4. rails db:migrate
5. rails db:seed
6. rails s
```
``` Ruby
  Ruby 2.6.3
  Rails 6.0.2.1
```
## Testing
Run the test suite: ```rails test test/controllers/apps_controller_test.rb```

