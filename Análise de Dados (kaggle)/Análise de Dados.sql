-- Análise de dados do Kaggle com PlpgSQL

CREATE TABLE student(
	student_ID VARCHAR(100) PRIMARY KEY,
	AGE SMALLINT,
	GENDER SMALLINT, -- 1 female, 2 male
	SALARY SMALLINT,
	PREP_EXAM SMALLINT,
	NOTES SMALLINT,
	GRADE SMALLINT
);

/* 

COLLUMNS IMPORTED:
1- Student Age (1: 18-21, 2: 22-25, 3: above 26)
2- Sex (1: female, 2: male)
8- Total salary if available (1: USD 135-200, 2: USD 201-270, 3: USD 271-340, 
	4: USD 341-410, 5: above 410)
24- Preparation to midterm exams 2: (1: closest date to the exam, 2: regularly during the 			semester, 3: never)
25- Taking notes in classes: (1: never, 2: sometimes, 3: always)
29- Cumulative grade point average in the last semester (/4.00): (1: <2.00, 2: 2.00-2.49, 3: 		2.50-2.99, 4: 3.00-3.49, 5: above 3.49)

*/


SELECT * FROM student;




