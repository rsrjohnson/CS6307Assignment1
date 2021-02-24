PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Graduate;
DROP TABLE IF EXISTS Enrolls;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Professor;


DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
       Code VARCHAR primary key NOT NULL,
       Name VARCHAR NOT NULL      
       );
       
       
DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
       NetID VARCHAR primary key NOT NULL,
       First_Name VARCHAR NOT NULL,
       Last_Name  VARCHAR NOT NULL,
       Major VARCHAR NOT NULL,
       IsGraduate INT NOT NULL,  --Enter 1 for Graduate, 0 for not Graduate
       foreign key (Major) references Department(Code)
       );
       

--Only Graduate students will have an Advisor
DROP TABLE IF EXISTS Graduate;
CREATE TABLE Graduate(
    NetID VARCHAR primary key NOT NULL,
    Advisor VARCHAR NOT NULL,    
    foreign key (NetID) references Student(NetID),
    foreign key (Advisor) references Professor(NetID)    
    );


--Ensuring that a student can have an adviser only if the student is graduate 
DROP TRIGGER IF EXISTS Student_Not_Graduate;
CREATE TRIGGER Student_Not_Graduate
BEFORE INSERT ON Graduate
WHEN ((SELECT IsGraduate FROM Student where New.NetID=Student.NetID)=0)
BEGIN
    SELECT RAISE(ABORT, "The Student is not Graduate");
END;


--A Professor can advise many graduate students
DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor(
       NetID VARCHAR primary key NOT NULL,
       First_Name VARCHAR NOT NULL, 
       Last_Name  VARCHAR NOT NULL,
       Rank VARCHAR NOT NULL,
       Department VARCHAR NOT NULL,
       IsChairman INT NOT NULL, --Enter 1 for Chairman, 0 for not Chairman
       foreign key (Department) references Department(Code));
       

--Ensuring that we have only one chairman per department
DROP TRIGGER IF EXISTS OnlyOneChairmanPerDept;
CREATE TRIGGER OnlyOneChairmanPerDept
AFTER INSERT ON Professor
WHEN ((SELECT SUM(IsChairman) FROM Professor WHERE New.Department=Professor.Department)>1)
BEGIN
    SELECT RAISE(ABORT, "You can only enter one Chairman per Department");
END;


DROP TABLE IF EXISTS Course;
CREATE TABLE Course(
      Course_ID VARCHAR primary key NOT NULL,
      Course_Name VARCHAR NOT NULL,     
      TeachBy VARCHAR NOT NULL,      
      foreign key (TeachBy) references Professor(NetID)     
      );      
      
       
DROP TABLE IF EXISTS Enrolls;
CREATE TABLE Enrolls(
    Course_ID VARCHAR NOT NULL,
    NetID VARCHAR NOT NULL,
    Semester VARCHAR NOT NULL,
    Year INT NOT NULL,
    PRIMARY KEY(Course_ID, NetID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (NetID) REFERENCES Student(NetID)
    );
    

--Some Examples
    
INSERT INTO Department VALUES('CS','Computer Science');
INSERT INTO Department VALUES('STAT','Statistics');

INSERT INTO Professor VALUES('jxc694678','Jose','Carlos','Full','STAT',1);
INSERT INTO Professor VALUES('lxs725089','Luis','Salomon','Full','STAT',0);
INSERT INTO Professor VALUES('sxn850670','Sanchez','Noriega','Full','CS',0);
INSERT INTO Professor VALUES('txm456931','Tom','Mitchell','Emeritus','CS',1);
INSERT INTO Professor VALUES('pxd967815','Pedro','Domingos','Distinguished','CS',0);

--INSERT INTO Professor VALUES('axp456897','Alex','Perez','Distinguished','CS',1);--this will call the trigger, since every department can have only one chairman

INSERT INTO Student VALUES('pxg158054','Paul', 'Gulliard','STAT',1);
INSERT INTO Student VALUES('gxm732896','Guido', 'Mista','CS', 0);
INSERT INTO Student VALUES('jxt125897','Joe', 'Tolvard','STAT',1);
INSERT INTO Student VALUES('bxp177689','Blaise', 'Pascal','CS', 0);
INSERT INTO Student VALUES('axp158088','Andrea', 'Perez','CS',0);
INSERT INTO Student VALUES('lxv732866','Lucas', 'Vazquez','STAT', 1);

INSERT INTO Graduate VALUES('pxg158054','lxs725089');
INSERT INTO Graduate VALUES('jxt125897','lxs725089');

--INSERT INTO Graduate VALUES('bxp177689','lxs725089'); --this will call the trigger, since the student is not graduate

INSERT INTO Course VALUES('md','Discrete', 'jxc694678');
INSERT INTO Course VALUES('St','Stat 101', 'lxs725089');
INSERT INTO Course VALUES('opt','Optimization', 'lxs725089');
INSERT INTO Course VALUES('eda','EDA1', 'sxn850670');


INSERT INTO Enrolls VALUES('md','axp158088', 'winter', 2020);
INSERT INTO Enrolls VALUES('St','gxm732896', 'spring', 2018);
INSERT INTO Enrolls VALUES('opt','lxv732866', 'fall', 2020);
INSERT INTO Enrolls VALUES('eda','lxv732866', 'spring', 2019);

--Common Queries
select * from Graduate;
select * from Student;
select * from Professor;
select * from Department;
select * from Course;
select * from Enrolls;

--Finding the chairmans
select Professor.First_Name, Professor.Last_Name from professor where professor.IsChairman=1;

--Finding the name of the department of a particular course
select Name from (select Department from Course join Professor on TeachBy = NetID where Course_Name='Optimization') h join Department d on h.Department=d.Code;

--Finding who teaches Andrea
Select Professor.First_Name, Professor.Last_Name from (select TeachBy from (select Course_ID from Student join Enrolls on Student.NetID = Enrolls.NetID where Student.First_Name = 'Andrea') h join Course on h.Course_ID = Course.Course_ID) k join Professor on Professor.Netid = k.TeachBy;