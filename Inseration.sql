-- Insert data into CourseTrackSchema.Department
INSERT INTO CourseTrackSchema.Department (d_name)
VALUES ('Computer Science');

INSERT INTO CourseTrackSchema.Department (d_name)
VALUES ('Electrical Engineering');

-- Insert data into CourseTrackSchema.Track
INSERT INTO CourseTrackSchema.Track (t_name, dep_id)
VALUES ('Software Engineering', 1);

INSERT INTO CourseTrackSchema.Track (t_name, dep_id)
VALUES ('Data Science', 2);

-- Insert data into CourseTrackSchema.Course
INSERT INTO CourseTrackSchema.Course (c_id,c_name, max_degree, min_degree, inst_id)
VALUES (102,'Database Management', 100, 50, 4),(101,'Data Mining', 90, 35, 4);



-- Insert data into CourseTrackSchema.Track_courses
INSERT INTO CourseTrackSchema.Track_courses (t_id, c_id)
VALUES (3, 101);

INSERT INTO CourseTrackSchema.Track_courses (t_id, c_id)
VALUES (4, 102);

-- RUN TRIGGER
INSERT INTO ExamQuestionSchema.Exam (Exam_id, israndom, Ex_type, c_id, inst_id)
VALUES (122, 1, 'CORRECTIVE', 102, 4);



-- Insert data into ExamQuestionSchema.Question_pool
INSERT INTO ExamQuestionSchema.Question_pool (Q_id, content, correct_ans, c_id)
VALUES (1, 'What is a database?', 'A structured collection of data', 102);

INSERT INTO ExamQuestionSchema.Question_pool (Q_id, content, correct_ans, c_id)
VALUES (2, 'relational db is structure data   ?', 'True', 102);
INSERT INTO ExamQuestionSchema.Question_pool (Q_id, content, correct_ans, c_id)
VALUES (3, 'what is the capital of egypt?', 'cairo', 102);
INSERT INTO ExamQuestionSchema.Question_pool (Q_id, content, correct_ans, c_id)
VALUES (4, 'Cairo in egypt ', 'True', 102);

-- Insert data into ExamQuestionSchema.Questation_Type
INSERT INTO ExamQuestionSchema.Questation_Type (Type_id, Q_id, q_type, question_category)
VALUES (1, 1, 'Text', 'write answer'),
       (2, 2, 'True & False', 'True'),
       (3, 2, 'True & False', 'False'),
       (4, 3, 'Multiple choice', 'Mansoura'),
       (5, 3, 'Multiple choice', 'Cairo'),
       (6, 3, 'Multiple choice', 'Minia'),
	   (7, 4, 'True & False', 'True'),
	   (8, 4, 'True & False', 'False')







-- Insert data into StudentManagementSchema.Intake
INSERT INTO StudentManagementSchema.Intake (intake_name)
VALUES ('Intake 43'),('Intake 42'),('Intake 44');



-- Insert data into StudentManagementSchema.Account
INSERT INTO StudentManagementSchema.Account (username, [password])
VALUES ('Prof. Sara', '12345678') ,('Dr.Ahmed ', '12345678') ,('Hadi', '123456789') ,('Eslam',' 123456789');


-- Insert data into StudentManagementSchema.Student
INSERT INTO StudentManagementSchema.Student (st_name, acc_id)
VALUES ('Hadi', 6);

INSERT INTO StudentManagementSchema.Student (st_name, acc_id)
VALUES ('Eslam', 7);

-- Insert data into StudentManagementSchema.Instructor
INSERT INTO StudentManagementSchema.Instructor (inst_name, acc_id)
VALUES ('Dr. AHMED', 4);

INSERT INTO StudentManagementSchema.Instructor (inst_name, acc_id)
VALUES ('Prof. Sara', 5);

-- Insert data into StudentManagementSchema.Student_exam
INSERT INTO StudentManagementSchema.Student_exam (st_id, inst_id, exam_id, start_time, end_time, [date])
VALUES (3, 4, 10, '09:00:00', '10:30:00', '2024-01-26');




 ----------Student_answer
INSERT INTO StudentManagementSchema.Student_answer (st_id, exam_id, Q_id, answer)
VALUES (3, 10, 2, 'True');



-- Insert data into StudentManagementSchema.Student_course
INSERT INTO StudentManagementSchema.Student_course (st_id, c_id)
VALUES (2, 101);

INSERT INTO StudentManagementSchema.Student_course (st_id, c_id)
VALUES (3, 102);
