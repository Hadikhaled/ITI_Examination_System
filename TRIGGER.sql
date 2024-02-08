-----trig for selectIONquestion 
CREATE   TRIGGER tr_selectIONquestion
ON [ExamQuestionSchema].[Exam]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @exam_id INT, @course_id INT, @israndom BIT;

    SELECT @exam_id = Exam_id, @course_id = c_id, @israndom = israndom
    FROM inserted;

    IF @israndom = 1
    BEGIN
        DECLARE @question_id INT;
		DECLARE @RESULT_RANDOM TABLE (Q_ID INT);
		INSERT INTO @RESULT_RANDOM (Q_ID)
		EXEC [ExamQuestionSchema].GettRandomQuestions @course_id = @course_id;

        declare question_cursor CURSOR FOR
		SELECT * FROM @RESULT_RANDOM;

        OPEN question_cursor;
        FETCH NEXT FROM question_cursor INTO @question_id;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO [ExamQuestionSchema].[Exam_question] ([e_id],[q_id] ,[question_degree] )
            VALUES (@exam_id, @question_id, 5);

            FETCH NEXT FROM question_cursor INTO @question_id;
        END

        CLOSE question_cursor;
        DEALLOCATE question_cursor;
    END
    ELSE
    BEGIN
      DECLARE @QuestionID INT = 1 -- Provide the question ID here;
	  DECLARE @ResultMessage NVARCHAR(100);

      EXEC[ExamQuestionSchema].choose_QU_Manually
			@question_id = @QuestionID,
			@Exam_id = @exam_id,
			@result_message = @ResultMessage OUTPUT;

	  PRINT @ResultMessage;
    END
END;
---------------------------------------------

----------------------------------------------------

-----TriGgher --VerificationTypeOfExam 
GO
CREATE TRIGGER TR_VerificationTypeOfExam 
ON [StudentManagementSchema].[Student_exam]
after INSERT   
AS
BEGIN

    DECLARE @EX_TYPE VARCHAR(255);
    DECLARE @EX_ID INT;
    DECLARE @ST_ID INT;
    DECLARE @Date DATE; 
    DECLARE @RESULT INT;

    SELECT 
        @ST_ID = [st_id],
        @EX_ID = [exam_id],
        @Date = [date],
        @RESULT = [Result]
    FROM INSERTED;

    SELECT @EX_TYPE = [Ex_type] FROM [ExamQuestionSchema].[Exam]
    WHERE [Exam_id] = @EX_ID;

    -- Check conditions and perform the insertion
    IF (@EX_TYPE = 'normal')
        OR (@EX_TYPE = 'corrective' AND @RESULT < 50 AND @RESULT IS NOT NULL)
    BEGIN
        
        
            print('You have an exam on: ' + CONVERT(NVARCHAR, @Date));
        
    END
    ELSE
    BEGIN
	   Delete from [StudentManagementSchema].[Student_exam]
	   where [st_id]=@ST_ID and [exam_id]=@EX_ID
        print('NOT HAVE ACCESS TO THIS EXAM');
    END

END


