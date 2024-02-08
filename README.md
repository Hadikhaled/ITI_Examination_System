# ITI_Examination_System
## Overview
The examination system is designed to facilitate the creation, management, and assessment of exams for students across different institutions. It incorporates various components to ensure efficiency and accuracy throughout the examination process.
## ERD
![ERD Image](https://github.com/Hadikhaled/ITI_Examination_System/blob/main/ERDEXAMINATION.PNG)

# the key functions performed by the system:

 1)Exam Creation:
     Allows the creation of different types of exams (e.g., Normal, Corrective) with associated attributes such as ID, randomization status, course details, and institution information.
     
2)Student Exam Assignment:
  Facilitates the assignment of exams to students based on their enrollment in specific courses and institutions.
  Ensures compliance with institutional policies by enforcing rules regarding exam types and student eligibility.

3)Exam Availability Verification:
  Verifies the availability of exams for students at specific times and dates.
  Prevents students from attempting exams outside designated periods, ensuring fairness and adherence to scheduling constraints.

4)Result Calculation:
  Calculates exam results based on student responses.
  Generates marks or scores reflecting the accuracy of student answers, providing objective evaluation and feedback to instructors and students.

5)Question Management:
  Provides views for instructors to access and select questions for exam creation manually.
  Allows instructors to customize exams according to course objectives and student needs, enhancing the relevance and effectiveness of assessments.

6)Comprehensive Information Display
  Displays comprehensive information about students and instructors through dedicated views.
  Facilitates administrative tasks and informational purposes within the examination system, such as accessing student records and instructor details.

7)Trigger Enforcement:
  Enforces rules and constraints using triggers to ensure the integrity and consistency of exam assignments.



  
  For example, triggers prevent certain types of exams from being assigned to specific students based on predefined criteria.
  Stored Procedures:

Implements stored procedures for executing specific tasks, such as verifying exam availability and calculating exam results.
Enhances system functionality by providing reusable and efficient mechanisms for performing common operations.
