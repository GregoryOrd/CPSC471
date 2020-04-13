# CPSC MySQL Database API

## Team Members

- Matthew Allwright
- Swth Campbell
- Gregory Ord

## Requirements

- Visual Studio 2019
- MySQL Server
	- Configure connection in `DatabaseModel.Get_PuBConnectionString()`

## Setup

Two MySQL scripts have been provided to help setup your MySQL server:
- `CREATE_SCHEMA.sql`
	- Creates the basic database schema
	- Adds sample entries
	- Run this first
- `CREATE_STORED_PROCEDURES.sql`
	- Creates all of the required stored procedures
	- Run this second

Import the Visual Studio project (`API/CPSC471_RentalSystemAPI.sln`),
let it configure itself, and run!

## Documentation

The documentation is provided via a Postman JSON collection.
Simply import `471 Docs - T05 Group 3.postman_collection.json` into Postman,
and all of the endpoints will be displayed displayed with example info
matching up with the test data provided in `CREATE_SCHEMA.sql`.

[A simple talk-through demonstration of the API is available here.](https://youtu.be/-XViRa3ldv0)