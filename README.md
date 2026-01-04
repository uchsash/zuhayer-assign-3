# Vehicle Rental System - Database Design & SQL Queries

## Project Overview
This repository contains SQL solutions designed to solve specific data retrieval challenges within a Vehicle Rental Management context. The primary focus is on utilizing relational database concepts, including **Subqueries**, **Correlated Subqueries**, and **Logical Operators** (EXISTS/NOT EXISTS), to filter data effectively across multiple tables.

## Related Links
**ERD:** https://drawsql.app/teams/uchsash-tousif/diagrams/vehicle-rental-system

**Answer of Theoratical Questions as Video:** https://drive.google.com/drive/folders/1w1eoqaJW2JbGMIoq1BB6y6ELuA9E1zy1

## Database Schema
The queries are based on a standard relational schema consisting of three tables (ERD is shown in above link):

1.  **`Users`**: Contains users details (e.g., Id, Name, Email, Password, Role).
2.  **`Vehicles`**: Contains inventory details (e.g., Id, Model, Type, Registration Number, Rent Price etc.).
3.  **`Bookings`**: Contains transaction history (e.g., Booking_Id, User_Id, Vehicle_Id, Total Price, Date etc.).

## Query Logic & Explanation

### 1. Retrieving Complete Booking Details (INNER JOIN)

**Objective:**
To view booking records enriched with descriptive names for customers and vehicles, rather than just their numerical IDs.

**The Approach:**
Data is often normalized across multiple tables (`Bookings`, `Users`, `Vehicles`). To combine this distributed information, we use an **INNER JOIN**. This operation links rows from the `Bookings` table with matching rows in `Users` and `Vehicles` based on their common keys (`User_Id` and `Vehicle_Id`), creating a unified view of the transaction.

### 2. Finding Unbooked Vehicles (NOT EXISTS)

**Objective:**
To identify all vehicles in the fleet that have no record of ever being booked.

**The Approach:**
We filter the `Vehicles` table using a **Correlated Subquery** inside the `NOT EXISTS` operator. For every vehicle, the database checks the `Bookings` table. If no matching booking record is found for that specific vehicle ID, the `NOT EXISTS` condition becomes true, and the vehicle is included in the final result. This is a robust way to isolate data present in one table but missing in another.

### 3. Filtering Available Vehicles by Type (SELECT & WHERE)

**Objective:**
To list all vehicles that are currently available and match a specific category (e.g., 'Car').

**The Approach:**
This query utilizes the standard **WHERE** clause to apply row-level filtering. The database scans the `Vehicles` table and evaluates each row against two conditions: the status must be 'Available' AND the type must match the user's input. Only rows satisfying both criteria are returned.

### 4. High-Volume Vehicle Analysis (GROUP BY & HAVING)

**Objective:**
To find vehicles that are booked frequently, specifically those with more than 2 bookings.

**The Approach:**
This requires aggregation of data.
1.  **GROUP BY:** First, we group all booking records by `Vehicle_Id`, collapsing multiple rows for the same vehicle into a single group.
2.  **COUNT:** We calculate the total number of bookings within each group.
3.  **HAVING:** Finally, we filter these groups. Unlike `WHERE` (which filters raw rows), `HAVING` filters the aggregated results, keeping only those groups where the count exceeds 2.

**How it works:**
1.  **Outer Query:** Selects a vehicle from the `Vehicles` table.
2.  **Correlated Subquery:** Checks the `Bookings` table to see if a matching `Vehicle_Id` exists for the current vehicle.
3.  **Filter:** The `NOT EXISTS` operator filters the result, returning `TRUE` only if the subquery returns no rows (an empty set). This effectively isolates vehicles that appear in the inventory but not in the booking history.

---

## How to Run
1.  Ensure you have a PostgreSQL environment set up.
2.  Create Shcema as ERD.
3.  Execute the script found in `queries.sql`.
