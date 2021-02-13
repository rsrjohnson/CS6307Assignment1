PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
       Code VARCHAR primary key,
       Name VARCHAR,
       Chairman  VARCHAR,
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


INSERT INTO Department VALUES('CS','Computer Science','jxc694678');
INSERT INTO Department VALUES('STAT','Statistics','lxs725089');

INSERT INTO Professor VALUES('jxc694678','Jose','Carlos','Senior','CS');
INSERT INTO Professor VALUES('lxs725089','Luis','Salomon','Proctor','STAT');
INSERT INTO Professor VALUES('sxn850670','Sanchez','Noriega','Proctor','CS');

       
INSERT INTO Student VALUES('pxg158054','Paul', 'Gulliard','STAT', 1,'jxc694678');
INSERT INTO Student VALUES('gxm732896','Guido', 'MISTA','CS', 0, 'sxn850670');

select * from Student;

PRAGMA foreign_keys = OFF;
ALTER TABLE Department ADD FOREIGN KEY (Chairman) REFERENCES Professor(NetID);

DROP TABLE IF EXISTS Enrolls;
CREATE TABLE ENROLLS(
     Semester VARCHAR,
     Year INT
);




