# CS 3200 Final Project - NUHire

My product is a re-imagined version of Northeastern's current co-op/job searching platform, NUWorks. It allows employers to post open jobs at their company, students to apply to them, and co-op advisors to keep track of students in their class and their job search progress (among other things).

The SQL file containing all the create table and insert statements is located in the db folder (more detail on the entities below). Get and post requests relevant to each major persona (student, advisor, employer) are located in their respective folders in src. Each has a comment above it describing the data it is retreiving/working with.

# Database Entities

College: Sub-colleges of Northeastern University -- Khoury, COE, D'Amore-McKim, Bouve, CSSH
Advisor: Represents the co-op advisor persona; teaches co-op classes and advises students' job search
Company: A company that would post open jobs on NUHire
Recruiter: A representative employee of a company; the go-to contact person for a posted job
Term: The season and year for a posted job
PositionType: The type of job -- Co-op, Internship, Full-time, Part-time
CoopClass: A class that every student in the database must be enrolled in, to be eligible to use NUHire
Student: Represents the student persona; attends Northeastern University and is job-searching
Job: A specific job posted by a particular company
Reference: A weak entity dependent on Student; represents that Student's job reference
PreviousCoop: A position previously held by a particular student at a particular company
Application: Bridge relation between Student and Job; represents a job application

# AppSmith Pages

Student Job Hub: Where students can browse all posted jobs and apply to ones they are interested in
1. Browse all available jobs using the table widget.
2. Apply to a job using the form widget to the right.
    - NUID must be an integer between 1 and 80 (inclusive)
    - JobID can be any JobID found in the table; between 1 and 99 (inclusive)
    - Resume Link, Transcript Link, and Cover Letter Link can all be any series of characters

Student Profile: Where students can view their submitted job applications as well as information about their advisor and co-op class
1. Type an NUID in the input widget at the top right and hit enter.
    - Must be an integer between 1 and 80 (inclusive)
2. You should now be able to view information about the student associated with the NUID you entered; their name, submitted applications, advisor information, and co-op class grace.

Advisor Profile: Where advisors can view their students' information and class grade averages
1. Type an AdvisorID in the input widget at the top right and hit enter.
    - Must be an integer between 1 and 30 (inclusive)
2. You should now be able to view information about the advisor associated with the ID you entered; their name, students in the classes they teach, and those classes' average grades.

Employer Job View: Where employers can see all submitted applications for a job they posted
1. Type a TickerSymbol in the input widget at the top left and hit enter.
    - Valid TickerSymbols can be found in the insert statement of the bootstrap SQL file. Some examples: YAH, KRP, AAJ
2. Select a JobID from the drop-down menu select widget.
3. You should now be able to view information about the job associated with the ID you selected; its applicants, title, hourly wage, location, duration, and type.

# Links

Relational diagram for the SQL database: https://tinyurl.com/nuhirediagram
Demo of application: https://youtu.be/CB_q947FjYI 
