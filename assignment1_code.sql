PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
       Code VARCHAR primary key,
       Name VARCHAR,
       Chairman  VARCHAR DEFAULT NULL,
       FOREIGN KEY (Chairman) REFERENCES Professor(NetID)
       );

DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
       Netid VARCHAR primary key,
       First_Name VARCHAR NOT NULL,
       Last_Name  VARCHAR NOT NULL,
       Major VARCHAR,
       IsGraduate INT,
       Advise VARCHAR, 
       foreign key (Major) references Department(Code),
       foreign key (Advise) references Professor(NetID)       
);


DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor(
       Netid VARCHAR primary key,
       First_Name VARCHAR,
       Last_Name  VARCHAR,
       Rank VARCHAR,
       Department VARCHAR,
       foreign key (Department) references Department(Code));



DROP TABLE IF EXISTS Course;
CREATE TABLE Course(
      Course_ID VARCHAR primary key,
      Course_Name VARCHAR,
      Department VARCHAR,
      foreign key (Department) references Department(Code));       

DROP TABLE IF EXISTS Enrolls;
CREATE TABLE Enrolls(
    Course_ID VARCHAR,
    NetID VARCHAR,
    Semester VARCHAR,
    Year INT,
    PRIMARY KEY(Course_ID,NetID),
    FOREIGN KEY (Course_ID) REFERENCES Course,
    FOREIGN KEY (NetID) REFERENCES Student);


INSERT INTO Department VALUES('CS','Computer Science',NULL);
INSERT INTO Department VALUES('STAT','Statistics',NULL);

INSERT INTO Professor VALUES('jxc694678','Jose','Carlos','Senior','CS');
INSERT INTO Professor VALUES('lxs725089','Luis','Salomon','Proctor','STAT');
INSERT INTO Professor VALUES('sxn850670','Sanchez','Noriega','Proctor','CS');

       
INSERT INTO Student VALUES('pxg158054','Paul', 'Gulliard','STAT', 1,'jxc694678');
INSERT INTO Student VALUES('gxm732896','Guido', 'Mista','CS', 0, NULL);



select * from Student;
select * from Professor;
select * from Department;

UPDATE Professor
SET Last_Name = 'Luis'
WHERE NetID = 'jxc694678';

UPDATE Department
SET Chairman = 'sxn850670'
WHERE Code = 'CS';


select * from Department;

