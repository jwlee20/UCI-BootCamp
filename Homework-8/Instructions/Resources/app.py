import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
import datetime as dt

from flask import Flask, jsonify

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/prcp<br/>"
        f"/api/v1.0/station<br/>"
        f"/api/v1.0/temp<br/>"
        f"/api/v1.0/<start><br/>"
        f"/api/v1.0/<start>/<end><br/>"
    )

@app.route("/api/v1.0/prcp")
def prcp():
    results = session.query(Measurement.date,Measurement.prcp).all()
    all_prcp = list(np.ravel(results))
    return jsonify(all_prcp)

@app.route("/api/v1.0/station")
def station():
    results = session.query(Measurement.station).all()
    all_stations = list(np.ravel(results))
    return jsonify(all_stations)

@app.route("/api/v1.0/temp")
def temp():
    results = session.query(Measurement.date,Measurement.tobs).all()
    all_temp = list(np.ravel(results))
    return jsonify(all_temp)

@app.route("/api/v1.0/<start>")
def start(start_date):
    results = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).filter(Measurement.date >= start_date).all()
    cool = list(np.ravel(results))
    return jsonify(cool)
   
@app.route("/api/v1.0/<start>/<end>")
def startend(start_date,end_date):
    results = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).filter(Measurement.date >= start_date).filter(Measurement.date <= end_date).all()
    cool = list(np.ravel(results))
    return jsonify(cool)

if __name__ == '__main__':
    app.run(debug=True)
