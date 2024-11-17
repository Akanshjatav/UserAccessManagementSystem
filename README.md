# User Access Management System

## Overview

The **User Access Management System (UAMS)** is a web-based solution to manage software access within an organization. It enables users with different roles—**Admin**, **Manager**, and **Employee**—to perform role-specific operations efficiently. The application includes features such as access request handling, transaction management, and role-based permissions.

---

## Features

1. **Role-Based User Access**:
    - **Admin**: Add new software and set access levels.
    - **Manager**: Approve or reject software access requests from employees.
    - **Employee**: Request software access with specific permissions.

2. **Access Levels**:
    - `Read`, `Write`, `Admin` permissions can be assigned to software.

3. **Data Persistence**:
    - All changes are stored in a PostgreSQL database.

---

## Prerequisites

To set up and run the application, you need:

1. **Java Development Kit (JDK)**: Version 8 or higher.
2. **Apache Maven**: For building the project.
3. **Apache Tomcat**: Version 9 or higher for running the web application.
4. **PostgreSQL**: For database management.
---

## How to run

1. Clone the Repository
```bash
git clone https://github.com/Akanshjatav/UserAccessManagementSystem.git
cd UserAccessManagementSystem
```
2. Setup the database: run the create_db file
3. Build 
```bash
mvn clean package 
```
4. Put the generated war file of the project int the webapps subfolder of the tomcat directory
5. Start the tomcat server manually or using commandline
```bash
catalina.bat start 
```
6. Type http://localhost:8080/UserAccessManagementSystem/ in your browser


