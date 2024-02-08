-- Create Exams with Different Types
-- Exam with ID 200 is a Normal Exam
INSERT INTO ExamQuestionSchema.Exam (Exam_id, israndom, Ex_type, c_id, inst_id, branch_name, intake_name, track_name)
VALUES (4000, 1, 'Normal', 102, 4, 'minia', 'intake44', 'BI');

-- Exam with ID 201 is a Corrective Exam
INSERT INTO ExamQuestionSchema.Exam (Exam_id, israndom, Ex_type, c_id, inst_id, branch_name, intake_name, track_name)
VALUES (201, 1, 'CORRECTIVE', 102, 4, 'minia', 'intake44', 'BI');

-- Exam with ID 300 is another Normal Exam
INSERT INTO ExamQuestionSchema.Exam (Exam_id, israndom, Ex_type, c_id, inst_id, branch_name, intake_name, track_name)
VALUES (300, 1, 'Normal', 102, 4, 'minia', 'intake44', 'BI');


-- Trigger Verification Type
-- Failed to assign exam ID 201 to student ID 3 as corrective exams are not allowed for this student.
INSERT INTO StudentManagementSchema.Student_exam (st_id, inst_id, exam_id, start_time, end_time, [date])
VALUES (3, 4, 4000, '09:00:00', '10:30:00', '2024-01-26');

-- Successfully assigned exam ID 200 to student ID 3 as it is a normal exam and the first time for this student.
INSERT INTO StudentManagementSchema.Student_exam (st_id, inst_id, exam_id, start_time, end_time, [date])
VALUES (3, 4, 200, '09:00:00', '10:30:00', '2024-01-26');

-- Successfully assigned exam ID 300 to student ID 4.
INSERT INTO StudentManagementSchema.Student_exam (st_id, inst_id, exam_id, start_time, end_time, [date])
VALUES (2, 4, 300, '09:00:00', '10:30:00', '2024-02-26')


-- Procedure: Check Date of Exam
-- Output: Exam ID 200 not available for student ID 3
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 200, @Q_ID = 2, @Answer = 'True'
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 200, @Q_ID = 3, @Answer = 'cairo'
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 200, @Q_ID = 4, @Answer = 'False'

-- Output: Exam ID 300 available for student ID 4
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 300, @Q_ID = 1, @Answer = 'A structured collection of data'
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 300, @Q_ID = 2, @Answer = 'True'
EXEC PR_checktimeExam @ST_ID = 3, @EXAM_ID = 300, @Q_ID = 3, @Answer = 'cairo'


-- Procedure: Calculate Result
-- Output: Exam ID 200, mark is 10 because there exists 1 question with a wrong answer
EXEC PR_RESULT @StudentID = 3, @ExamID = 200

-- Output: Exam ID 300, mark is 15 (full marks)
EXEC PR_RESULT @StudentID = 2, @ExamID = 300


-- View: V_DisplayQustation
-- Purpose: Displays a list of questions for instructors to choose from when creating exams.
-- Usage: 
SELECT * FROM V_DisplayQustation;

-- Call the procedure for manually choosing a question for an exam

-- Step 1: Define the question_id and Exam_id for the manual exam creation
DECLARE @question_id INT = 3; 
DECLARE @Exam_id INT = 200;   

-- variable to capture the result message 
DECLARE @ResultMessage NVARCHAR(100);

-- Step 3: Call the stored procedure [ExamQuestionSchema].choose_QU_Manually
EXEC [ExamQuestionSchema].choose_QU_Manually
    @question_id = @question_id,
    @Exam_id = @Exam_id,
    @result_message = @ResultMessage OUTPUT;

-- Step 4: Display the result message
PRINT @ResultMessage;

-----------------------------------------
-- View: V_displayStudent
-- Purpose: Displays comprehensive information about students.
-- Provides an overview of student records for administrative and informational purposes.
-- Usage:
SELECT * FROM V_displayStudent;

----------------------------------------------
-- View: V_instructor
-- Purpose: Displays detailed information about instructors.
-- Provides a comprehensive overview of instructor records for administrative and informational purposes.
-- Usage:
SELECT * FROM V_instructor;
---------------------------------------------------
