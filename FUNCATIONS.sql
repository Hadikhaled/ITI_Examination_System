---------------function calculate degree for questation that have standard answer
CREATE FUNCTION FN_Mark_ANSWER_standard(@ST_ID INT, @EX_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @totaldegree INT;
    SET @totaldegree = 0; -- Initialize @degree to a default value

    DECLARE C1 CURSOR FOR
    SELECT DISTINCT  SA.[answer], QP.[correct_ans],EQ.[question_degree]
    FROM [StudentManagementSchema].[Student_answer] SA
    JOIN [ExamQuestionSchema].[Question_pool] QP ON SA.[Q_id] = QP.[Q_id]
    JOIN [ExamQuestionSchema].[Questation_Type] QT ON QP.[Q_id] = QT.[Q_id]
	JOIN  [ExamQuestionSchema].[Exam_question] EQ ON EQ.[q_id] = QP.[Q_id]
    WHERE SA.[st_id] = 3 AND [exam_id] = 200
    AND [q_type] IN ('True & False', 'Multiple choice');
	DECLARE @answer NVARCHAR(MAX), @Cor_answer NVARCHAR(MAX),@degree INT 
    OPEN C1;
    FETCH NEXT FROM C1 INTO @answer, @Cor_answer, @degree;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @answer = @Cor_answer
        BEGIN
            SET @totaldegree  = @totaldegree+ @degree; --  increment degree
        END
        FETCH NEXT FROM C1 INTO @answer, @Cor_answer, @degree;
    END

    CLOSE C1;
    DEALLOCATE C1;

    RETURN @totaldegree;
END

GO
---------mark text questation 
go
CREATE FUNCTION fn_MARK_ANSWER_Text(@ST_ID INT, @EX_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @totaldegree INT = 0;

    DECLARE C1 CURSOR FOR
    SELECT DISTINCT SA.[answer], QP.[correct_ans], EQ.[question_degree]
    FROM [StudentManagementSchema].[Student_answer] SA
    JOIN [ExamQuestionSchema].[Question_pool] QP ON SA.[Q_id] = QP.[Q_id]
    JOIN [ExamQuestionSchema].[Questation_Type] QT ON QP.[Q_id] = QT.[Q_id]
    JOIN [ExamQuestionSchema].[Exam_question] EQ ON EQ.[q_id] = QP.[Q_id]
    WHERE SA.[st_id] = @ST_ID AND [exam_id] = @EX_ID
    AND [q_type] = 'Text';
    OPEN C1;
    
    DECLARE @AnswerText NVARCHAR(MAX), @Cor_answer NVARCHAR(MAX), @degree INT;
    
    FETCH NEXT FROM C1 INTO @AnswerText, @Cor_answer, @degree;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @CounterFOREXIST INT = 0;
        DECLARE @CounterNOTEXIST INT = 0;
        
        DECLARE @Delimiter NVARCHAR(1) = ' '; -- Assuming space as the word delimiter

        WHILE LEN(@AnswerText) > 0
        BEGIN
            DECLARE @EndPosition INT = CHARINDEX(@Delimiter, @AnswerText);

            IF @EndPosition = 0
                SET @EndPosition = LEN(@AnswerText);

            DECLARE @Word NVARCHAR(MAX) = SUBSTRING(@AnswerText, 1, @EndPosition - 1);
            
            IF CHARINDEX(@Word, @Cor_answer) > 0
                SET @CounterFOREXIST = @CounterFOREXIST + 1;
            ELSE
                SET @CounterNOTEXIST = @CounterNOTEXIST + 1;

            SET @AnswerText = SUBSTRING(@AnswerText, @EndPosition + 1, LEN(@AnswerText));
        END

        IF @CounterFOREXIST > @CounterNOTEXIST
            SET @totaldegree += @degree;

        FETCH NEXT FROM C1 INTO @AnswerText, @Cor_answer, @degree;
    END

    CLOSE C1;
    DEALLOCATE C1;
    
    RETURN @totaldegree;
END
