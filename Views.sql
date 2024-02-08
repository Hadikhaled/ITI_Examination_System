---view display  for Questaion 
GO
CREATE VIEW V_DisplayQustation 
AS
(
SELECT QP.[Q_id] ,QT.[q_type] ,  QP.[content],
QT.[question_category] ,C.[c_name]
FROM [ExamQuestionSchema].[Question_pool] QP
JOIN [ExamQuestionSchema].[Questation_Type] QT
ON QP.[Q_id] = QT.[Q_id]
JOIN [CourseTrackSchema].[Course] C
ON C.[c_id] = QP.[c_id]
)


SELECT * FROM V_DisplayQustation

go
---------------------------------------------------------------------
--Display info about student 
GO
CREATE VIEW V_displayStudent
AS
(
SELECT  [st_name] ,[t_name] AS 'Track' ,[c_name] AS 'course' ,[b_name] 'Branch'
FROM [StudentManagementSchema].[Student] st
JOIN [StudentManagementSchema].[Student_course] sc ON st.[st_id] =st.[st_id]
JOIN [CourseTrackSchema].[Course] c ON c.[c_id] =sc.[c_id]
JOIN [CourseTrackSchema].[Track_courses] tc ON tc.[c_id] = c.[c_id] 
JOIN [CourseTrackSchema].[Track] t ON t.[t_id]= tc.[t_id]
JOIN [CourseTrackSchema].[Branch_track_intake] bti ON bti.[t_id] =t.[t_id]
JOIN [CourseTrackSchema].[Branch] b ON b.[b_id]=bti.[b_id]

)

SELECT * FROM V_displayStudent;



-----------------------------------------------------------------
---DISPLAY INFORMATION ABOUT CONSTRUCTORS
GO
CREATE VIEW V_instructor
AS
(
SELECT [c_name] AS 'Courses' ,[inst_name] AS 'Instructor'
from [CourseTrackSchema].[Course] C
join [StudentManagementSchema].[Instructor] INS
ON INS.[inst_id]=C.[inst_id]
)

select * from V_instructor




