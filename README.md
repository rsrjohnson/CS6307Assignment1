# CS6307Assignment1
Repo for CS6307 Project 1 - Design of a Relational Data Model for a University Enrollment System

## ER-Diagram

![](https://github.com/rsrjohnson/CS6307Assignment1/blob/main/ERpic_Final.png)

## Relational Model ##
```
  Department (Code: PK, Name)
  Student (NetID: PK, First_Name, Last_Name, Major(Department Code), IsGraduate)
  Professor (NetID: PK, First_Name, Last_Name, Rank, Department (Department Code), Is-Chairman)
  Graduate (NetID (Student): PK, Advisor (Professor NetID))
  Course (Course_ID: PK, Course_Name, TeachBy (Professor NetID))
  Enrolls (Course_ID: PK, NetID (Student): PK, Semester, Year)
```
## [Database](https://github.com/rsrjohnson/CS6307Assignment1/blob/main/Enrollment%20System.db)  and [SQL_code](https://github.com/rsrjohnson/CS6307Assignment1/blob/main/assignment1_code.sql)

