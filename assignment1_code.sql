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
       Major VARCHAR,
       IsGraduate INT NOT NULL,  --Enter 1 for Graduate 0 for not Graduate
       foreign key (Major) references Department(Code)
       );
       
DROP TABLE IF EXISTS Graduate;
CREATE TABLE Graduate(
    NetID VARCHAR primary key NOT NULL,
    Advisor VARCHAR NOT NULL,    
    foreign key (NetID) references Student(NetID)    
);

--Ensuring that a student can have an adviser only if the student is graduate 
DROP TRIGGER IF EXISTS Student_Not_Graduate;
CREATE TRIGGER Student_Not_Graduate
BEFORE INSERT ON Graduate
WHEN ((SELECT IsGraduate FROM Student where New.NetID=Student.NetID)=0)
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
       IsChairman INT,
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
      TeachBy VARCHAR,      
      foreign key (TeachBy) references Professor(NetID)     
      );      
       
DROP TABLE IF EXISTS Enrolls;
CREATE TABLE Enrolls(
    Course_ID VARCHAR NOT NULL,
    NetID VARCHAR NOT NULL,
    Semester VARCHAR,
    Year INT,
    PRIMARY KEY(Course_ID, NetID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (NetID) REFERENCES Student(NetID)
    );
    
INSERT INTO Department VALUES('CS','Computer Science');
INSERT INTO Department VALUES('STAT','Statistics');

INSERT INTO Professor VALUES('jxc694678','Jose','Carlos','Full','STAT',1);
INSERT INTO Professor VALUES('lxs725089','Luis','Salomon','Full','STAT',0);
INSERT INTO Professor VALUES('sxn850670','Sanchez','Noriega','Full','CS',0);
INSERT INTO Professor VALUES('txm456931','Tom','Mitchell','Emeritus','CS',1);
INSERT INTO Professor VALUES('pxd967815','Pedro','Domingos','Distinguished','CS',0);

--INSERT INTO Professor VALUES('axp456897','Alex','Perez','Distinguished','CS',1);--this will call the trigger

INSERT INTO Student VALUES('pxg158054','Paul', 'Gulliard','STAT',1);
INSERT INTO Student VALUES('gxm732896','Guido', 'Mista','CS', 0);
INSERT INTO Student VALUES('kkkkkk','Paul', 'Gulliard','STAT',1);
INSERT INTO Student VALUES('aaaaa','Guido', 'Mista','CS', 0);
INSERT INTO Student VALUES('b','Guido', 'Mista','CS', 0);

INSERT INTO Graduate VALUES('kkkkkk','lxs725089');
--INSERT INTO Graduate VALUES('b','lxs725089'); --this will call the trigger

select * from Graduate;
select * from Student;
select * from Professor;
select * from Department;



INSERT INTO Department VALUES('MATH','Statistics');

select * from Department;
select * from Professor;


SELECT SUM(IsChairman) FROM Professor group by Department;
select COUNT(*) FROM Department;
SELECT COUNT(DISTINCT Department) FROM Professor;
SELECT COUNT(*) FROM (SELECT Department,Ischairman FROM Professor where Ischairman = 1);
SELECT COUNT(IsChairman) FROM Professor group by Department;

UPDATE Professor
SET Last_Name = 'Luis'
WHERE NetID = 'jxc694678';

INSERT INTO course VALUES('md','Discreta', 'jxc694678');
INSERT INTO course VALUES('STAt','stat 101', 'lxs725089');
INSERT INTO course VALUES('opt','Optimizacion', 'lxs725089');
INSERT INTO course VALUES('eda','EDA', 'sxn850670');

select * from course;



select * from Graduate;
INSERT INTO Student VALUES('pxg158088','Andrea', 'Perez','CS',0);
INSERT INTO Student VALUES('gxm732866','Lucas', 'Vaszquez','STAT', 1);
select * from Student;
--INSERT INTO Graduate VALUES('pxg158088','jxc694678'); --trigger
INSERT INTO Graduate VALUES('gxm732866','lxs725089'); 

select Course_Name from Course join Professor on TeachBy = NetID where First_Name = 'Luis';
INSERT INTO enrolls VALUES('md','pxg158088', 'winter', 2020);
INSERT INTO enrolls VALUES('STAt','gxm732866', 'spring', 2018);
INSERT INTO enrolls VALUES('opt','gxm732866', 'fall', 2020);
INSERT INTO enrolls VALUES('eda','pxg158088', 'spring', 2019);
select * from enrolls;
Select professor.First_Name from (select * from (select * from student join enrolls on student.Netid = enrolls.NetID where student.First_Name = 'Andrea') h join course on h.Course_ID = course.Course_ID) k join professor on professor.Netid = k.TeachBy;

select professor.First_Name from professor where professor.IsChairman=1;
select student.First_Name from student join graduate on student.NetID = graduate.NetID;
select * from Professor join (select TeachBy from Course join (select Course_ID from student join enrolls on student.netid=enrolls.NetID where student.First_Name='Andrea') Q on course.Course_ID=Q.Course_ID) W on Professor.NetID=W.TeachBy;

select professor.First_Name from professor where professor.IsChairman=1;
select student.First_Name from student join graduate on student.NetID = graduate.NetID;