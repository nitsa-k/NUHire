from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

students = Blueprint('students', __name__)

# Base route to get all the students
@students.route('/', methods=['GET'])
def get_students():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Student')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's name
@students.route('/name/<NUID>', methods=['GET'])
def get_name(NUID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT FirstName, LastName FROM Student WHERE NUID={0}'.format(NUID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's job applications
@students.route('/applications/<NUID>', methods=['GET'])
def get_applications(NUID):
    cursor = db.get_db().cursor()
    query = '''
        SELECT JobID, Title, Season, Year, Type
        FROM Job NATURAL JOIN PositionType
        WHERE JobID IN 
            (SELECT JobID
            FROM Application
            WHERE NUID = {0});
    '''.format(NUID)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's advisor's contact information
@students.route('/advisor/<NUID>', methods=['GET'])
def get_advisor(NUID):
    cursor = db.get_db().cursor()
    query = '''
        SELECT FirstName, LastName, Email, PhoneNumber
        FROM Advisor
        WHERE AdvisorID IN (SELECT AdvisorID
                            FROM CoopClass
                            WHERE CRN = (SELECT CRN
                                        FROM Student
                                        WHERE NUID = {0}));
    '''.format(NUID)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's grade in their co-op class
@students.route('/grade/<NUID>', methods=['GET'])
def get_grade(NUID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT Grade FROM Student WHERE NUID = {0}'.format(NUID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's resume link
@students.route('/resume/<NUID>', methods=['GET'])
def get_resume(NUID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT DISTINCT Resume FROM Application WHERE NUID={0}'.format(NUID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular student's transcript link
@students.route('/transcript/<NUID>', methods=['GET'])
def get_transcript(NUID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT DISTINCT Transcript FROM Application WHERE NUID={0}'.format(NUID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get all available jobs and their relevant information
@students.route('/jobs', methods=['GET'])
def get_jobs():
    cursor = db.get_db().cursor()
    query = '''SELECT JobID, Title, HourlyWage, City, State, Country, Season, Year, Type
            FROM Job NATURAL JOIN PositionType'''
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Post request for applying to a job
@students.route('/apply', methods=['POST'])
def apply():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    nuid = request.form['nuid']
    jobid = request.form['jobid']
    resume = request.form['resume']
    transcript = request.form['transcript']
    cletter = request.form['cletter']
    query = f'''insert into Application (CoverLetter, Resume, Transcript, Status, NUID, JobID) 
                values(\"{cletter}\", \"{resume}\", \"{transcript}\", null, \"{nuid}\", \"{jobid}\")'''
    cursor.execute(query)
    db.get_db().commit()
    return "Application sent!"