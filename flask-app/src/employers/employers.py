from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

employers = Blueprint('employers', __name__)

# Base route to get all the companies
@employers.route('/', methods=['GET'])
def get_companies():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Company')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a particular employee/recruiter's name
@employers.route('/name/<EmployeeID>', methods=['GET'])
def get_name(EmployeeID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT FirstName, LastName FROM Recruiter WHERE EmployeeID={0}'.format(EmployeeID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the jobs posted by a specific company
@employers.route('/jobs/<TickerSymbol>', methods=['GET'])
def get_jobs(TickerSymbol):
    cursor = db.get_db().cursor()
    query = '''SELECT *
            FROM Recruiter NATURAL JOIN Job
            WHERE TickerSymbol=%s'''
    cursor.execute(query, (TickerSymbol,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the information of a particular company
@employers.route('/company/<TickerSymbol>', methods=['GET'])
def get_company_info(TickerSymbol):
    cursor = db.get_db().cursor()
    query = '''SELECT *
            FROM Company
            WHERE TickerSymbol=%s'''
    cursor.execute(query, (TickerSymbol,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all of the relevant information of a particular job
@employers.route('/job/<JobID>', methods=['GET'])
def get_job_info(JobID):
    cursor = db.get_db().cursor()
    query = '''SELECT Title, HourlyWage, City, State, Country, Season, Year, Type
            FROM Job NATURAL JOIN PositionType
            WHERE JobID=%s'''
    cursor.execute(query, (JobID,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all of the applicants' information for a particular job
@employers.route('/applicants/<JobID>', methods=['GET'])
def get_applicant_info(JobID):
    cursor = db.get_db().cursor()
    query = '''SELECT CoverLetter, Resume, Transcript
            FROM Application
            WHERE JobID={0}'''.format(JobID)
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

# Post request for posting a new job
@employers.route('/post', methods=['POST'])
def post():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    jobid = request.form['jobid']
    title = request.form['title']
    wage = request.form['wage']
    addy = request.form['addy']
    city = request.form['city']
    state = request.form['state']
    country = request.form['country']
    zip = request.form['zip']
    empid = request.form['empid']
    szn = request.form['szn']
    year = request.form['year']
    posid = request.form['posit']
    query = f'''insert into Job (JobID, Title, HourlyWage, Address, City, State, Country, ZIPCode, 
                EmployeeID, Season, Year, PositionID) 
                values(\"{jobid}\", \"{title}\", \"{wage}\", \"{addy}\", \"{city}\", \"{state}\", 
                \"{country}\", \"{zip}\", \"{empid}\", \"{szn}\", \"{year}\", \"{posid}\")'''
    cursor.execute(query)
    db.get_db().commit()
    return "Job posted!"