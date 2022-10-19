# Nasa Flights Fuel calculator module

### Here I am providing 2 points to make it easier for the reviewer.
  - The stack I am using.
  - Assumptions
  - How to run the application.

  #
  1. Stack
      * It is a CLI app.The app is simple and my .I think using Ruby On Rails framework
        will be a kind of over enginnering.
      * I am using Ruby version 3.1.2
      * I am using Highline for CLI purpose.
      * I am using RSpec as a testing framework

  2. Assumptions I made.
      * I am assuming that, each route has to start by a launching
     mission from any planet and end with landing.

      * I am assuming that the mass of the equipment has to be
        positive.Just positive number.I did not found any constraints against the equipment weight.

  3. How to run the app:

      *  ```
          cd /your/project/directory
         ```
      * 
        ```
        bundle install
        ```
      *  
         ```
          ./cli.rb
         ```
      *  You will find command prompts to enter equipment mass first and then to enter the route
         ```
          ./cli.rb
         ```

         ```
           Enter the weight of the equipment?  28801

         ```

         ```
           Enter the whole flight route. Example: [[:mission1, gravity1], [:mission2, gravity2]]?  

         ```
      * An example for the results with valid input:
        ![valid input](/public/success_case.png)

      * An example for the results with invalid input:
        ![Invalid input](/public/failure_case.png)

      * For testing, in the same directory, run

         ```
         rspec
         ```
         OR

         ```
         bundle exec rspec
         ```
  Thanks
     

