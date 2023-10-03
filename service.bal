
import ballerina/http;
import ballerina/constraint;
import ballerina/time;

type TimeAndDayOfWeek record {|
 @constraint:Int {

 minValue: 0,

 maxValue: 23

 }

 int hour;

 # Minute of the day (UTC)

 @constraint:Int {

 minValue: 0,

 maxValue: 59

 }

 int minute;

 # Days of the week

 time:DayOfWeek[] daysOfWeek;

|};



# Configuration for a scheduled task triggered via an HTTP endpoint.

type ScheduledTask record {|

 # Task name

 string name;

 # Task trigger endpoint

// @constraint:String {

//  pattern: {

//  value: re `^http[s]?://.*`,

//  message: "Endpoint should be a valid HTTP URL"

//  }

//  }

 string endpoint;

 # Scheduled period 

 # - `decimal` (in seconds): Scheduled to trigger after passing the set amount of time

 # - `TimeAndDayOfWeek`: Scheduled to trigger at the exact time and date of the week

 decimal|TimeAndDayOfWeek schedule;

|};
service / on new http:Listener(9090) {

    resource function get greeting() returns string|error {
        return "";
    }

    // Health check endpoint
    resource function get healthz() returns string {
        return "Service is healthy";
    }
}
