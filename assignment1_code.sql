PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Graduate;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Enrolls;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department(
       Code VARCHAR primary key NOT NULL,
       Name VARCHAR NOT NULL,
       Chairman VARCHAR UNIQUE DEFAULT NULL,
       FOREIGN KEY (Chairman) REFERENCES Professor(NetID)
       );

DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
       NetID VARCHAR primary key NOT NULL,
       First_Name VARCHAR NOT NULL,
       Last_Name  VARCHAR NOT NULL,
       Major VARCHAR,
       IsGraduate INT NOT NULL,       
       foreign key (Major) references Department(Code)
       );

DROP TABLE IF EXISTS Graduate;
CREATE TABLE Graduate(
    NetID VARCHAR primary key NOT NULL,
    Advisor VARCHAR NOT NULL, 
    foreign key (NetID) references Student(NetID)
    foreign key (Advisor) references Professor(NetID)
);

--Ensuring that a student can have an adviser only if the student is graduate 
DROP TRIGGER IF EXISTS Student_Not_Graduate;
CREATE TRIGGER Student_Not_Graduate
AFTER INSERT ON Graduate
WHEN (SELECT Isgraduate FROM Graduate join Student on Graduate.NetID=Student.NetID)=0
BEGIN
    SELECT RAISE(ABORT, "The Student is not Graduate");
END;


DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor(
       NetID VARCHAR primary key NOT NULL,
       First_Name VARCHAR NOT NULL, 
       Last_Name  VARCHAR NOT NULL,
       Rank VARCHAR,
       Department VARCHAR DEFAULT NULL,
       foreign key (Department) references Department(Code));


DROP TABLE IF EXISTS Course;
CREATE TABLE Course(
      Course_ID VARCHAR primary key NOT NULL,
      Course_Name VARCHAR NOT NULL,
      OfferBy VARCHAR,
      TeachBy VARCHAR,
      foreign key (OfferBy) references Department(Code)
      foreign key (TeachBy) references Professor(NetID)     
      );       

DROP TABLE IF EXISTS Enrolls;
CREATE TABLE Enrolls(
    Course_ID VARCHAR NOT NULL,
    NetID VARCHAR NOT NULL,
    Semester VARCHAR,
    Year INT,
    PRIMARY KEY(Course_ID, NetID),
    FOREIGN KEY (Course_ID) REFERENCES Course,
    FOREIGN KEY (NetID) REFERENCES Student);


INSERT INTO Department VALUES('CS','Computer Science',NULL);
INSERT INTO Department VALUES('STAT','Statistics',NULL);

INSERT INTO Professor VALUES('jxc694678','Jose','Carlos','Senior','CS');
INSERT INTO Professor VALUES('lxs725089','Luis','Salomon','Proctor','STAT');
INSERT INTO Professor VALUES('sxn850670','Sanchez','Noriega','Proctor','CS');

       
INSERT INTO Student VALUES('pxg158054','Paul', 'Gulliard','STAT',1);
INSERT INTO Student VALUES('gxm732896','Guido', 'Mista','CS', 0);

INSERT INTO Graduate VALUES('pxg158054','lxs725089');

select * from Graduate;

select * from Student;
select * from Professor;
select * from Department;

UPDATE Professor
SET Last_Name = 'Luis'
WHERE NetID = 'jxc694678';

UPDATE Department
SET Chairman = 'jxc694678'
WHERE Code = 'STAT';

UPDATE Department
SET Chairman = 'sxn850670'
WHERE Code = 'CS';

select * from Department;