from flask import Blueprint, request, jsonify, make_response
import json
from src import db

advisors = Blueprint('advisors', __name__)

# Base route to get all the advisors
@advisors.route('/', methods=['GET'])
def get_advisors():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Advisor')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular advisor's name
@advisors.route('/name/<AdvisorID>', methods=['GET'])
def get_name(AdvisorID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT FirstName, LastName FROM Advisor WHERE AdvisorID={0}'.format(AdvisorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the students in a particular advisor's co-op classes and their relevant information
@advisors.route('/students/<AdvisorID>', methods=['GET'])
def get_students(AdvisorID):
    cursor = db.get_db().cursor()
    query = '''SELECT CRN, FirstName, LastName, Email, Status, Grade
            FROM Student
            WHERE CRN IN (SELECT CRN
                          FROM CoopClass
                          WHERE AdvisorID={0})
            ORDER BY CRN'''.format(AdvisorID)
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

# Get the average grades for a particular advisor's co-op classes
@advisors.route('/averages/<AdvisorID>', methods=['GET'])
def get_averages(AdvisorID):
    cursor = db.get_db().cursor()
    query = '''SELECT CRN, AVG(Grade) as ClassAverage
            FROM Student
            WHERE CRN IN (SELECT CRN
                          FROM CoopClass
                          WHERE AdvisorID={0})
            GROUP BY CRN;'''.format(AdvisorID)
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

# Get all available jobs and their relevant information
@advisors.route('/jobs', methods=['GET'])
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
