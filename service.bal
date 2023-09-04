import ballerina/http;

configurable string zeroBounceApi = ?;

service / on new http:Listener(9090) {
    resource function get greeting() returns string|error {
  
        return zeroBounceApi;
    }
}
