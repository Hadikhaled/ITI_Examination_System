----PROC to get random questation 
CREATE PROCEDURE [ExamQuestionSchema].GettRandomQuestions
    @course_id INT
AS
BEGIN
    SELECT TOP 3 Q_id
    INTO #RandomQuestions
    FROM ExamQuestionSchema.Question_pool
    WHERE c_id = @course_id
    ORDER BY NEWID();            
    SELECT Q_id FROM #RandomQuestions;
END;
GO

-------------------------PROC TO  CREATE QUESTATION MANUALLY
GO
CREATE PROCEDURE [ExamQuestionSchema].choose_QU_Manually
    @question_id INT,
    @Exam_id INT,
    @result_message NVARCHAR(100) OUTPUT
AS
BEGIN
    BEGIN TRY
        INSERT INTO [ExamQuestionSchema].[Exam_question] ([e_id],[q_id] ,question_degree )
        VALUES (@Exam_id, @question_id ,5);

        SET @result_message = 'Question inserted successfully.';
    END TRY
    BEGIN CATCH
        SET @result_message = ERROR_MESSAGE();
    END CATCH
END;
GO

----Procedure to insert answer untill The exam time is not over
GO
CREATE PROCEDURE PR_checktimeExam
    @ST_ID INT,
    @EXAM_ID INT,
    @Q_ID INT,
    @Answer NVARCHAR(MAX)
AS
BEGIN
    DECLARE @ExamDate DATE, @EndTime TIME, @StartTime TIME
	
    SELECT @ExamDate = [date], @EndTime = [End_time], @StartTime = [Start_time]
    FROM StudentManagementSchema.Student_exam
    WHERE exam_id = @EXAM_ID;

    DECLARE @currentDateTime DATETIME = GETDATE()
    DECLARE @currentDateFormatted NVARCHAR(10) = FORMAT(@currentDateTime, 'yyyy-MM-dd')
    DECLARE @currentTimeFormatted NVARCHAR(8) = FORMAT(@currentDateTime, 'HH:mm:ss')

    IF @ExamDate = @currentDateFormatted AND @EndTime > @currentTimeFormatted AND @StartTime <= @currentTimeFormatted
    BEGIN
        PRINT 'GOOD LUCK, EXAM IS STARTING.'
        INSERT INTO StudentManagementSchema.Student_answer (st_id, exam_id, Q_id, answer)
        VALUES (@ST_ID, @EXAM_ID, @Q_ID, @Answer)
    END
    ELSE
    BEGIN
        PRINT 'Exam is not available.'
    END
END

GO
-----------------PRO CALCULATE calculate result
GO
CREATE PROCEDURE PR_RESULT
    @StudentID INT,
    @ExamID INT
AS
BEGIN
    DECLARE @Result INT;

    -- Call the functions and store the result in a variable
    SET @Result = ISNULL([dbo].[FN_Mark_ANSWER_standard](@StudentID, @ExamID), 0)
                 + ISNULL(dbo.fn_MARK_ANSWER_Text(3, @ExamID), 0);
  
    -- Update the result
    UPDATE [StudentManagementSchema].[Student_exam]
    SET [Result] = @Result
    WHERE [st_id] = @StudentID AND [exam_id] = @ExamID;
END

SELECT LEN(REPLACE(string, ' ', ','))   AS word_count
FROM (SELECT 'This is a sample string' AS string) AS t
