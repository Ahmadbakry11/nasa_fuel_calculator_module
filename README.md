# Nasa Flights Fuel calculator module


### Here I am providing 2 points to make it easier for the reviewer.
  - The stack I am using.
  - How to run the application.

  #
  1. Stack
      * It is a CLI app.The app is simple and no need to use ROR.I think it s kind of overengineering
      * I am using Ruby version 3.1.2
      * I am using Highline for CLI purpose.
      * I am using RSpec as a testing framework

  2. How to run the app:

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

      * For testing, in the same directory, run

         ```
         rspec
         ```
         OR

         ```
         bundle exec rspec
         ```
  Thanks
     

