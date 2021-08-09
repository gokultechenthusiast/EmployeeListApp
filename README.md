# employ_list

An application to fetch employee list from api and save in local database

## Task given

It took me 2 day's to complete this task.
1. Fetch the employee’s JSON data from the following URL
https://run.mocky.io/v3/3440c30c-8872-4d73-bef5-1a5d33e2ad87
2. Store the data in the database. Once the data is stored, it should always use the data from the database without calling the webservice.
3. Fetch the list of employee’s from the database and display in a list (Profile Image, Name, Company Name)
4. The app should have an option to search the employee using the name or email address.
5. On taping the employee information from the list, The app should navigate to the employee details screen and display the full details (Profile Image, Name, User Name, Email address, Address, Phone, Website, Company Details

## Getting Started

I started with calling api from the given api.

then used sqlite in flutter to save api data in local base.

so what I have done is when the app runs initially it checks for employee list in database.

If no data then will fetch from api and save to database, then will fetch from database and will show the list.

Detailed view of employee is available.

A search to find the employee based in name and email is also implemented.
