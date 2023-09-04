import ballerina/http;

configurable string zerobounceApi = ?;

service / on new http:Listener(9090) {
    resource function get greeting() returns string|error {
  
        return zerobounceApi;
    }
}
