import ballerinax/salesforce;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function get contacts(string email) returns SWaveContact[]|error {

        salesforce:Client salesforceEp = check new (config = {
            baseUrl: baseUrl,
            auth: {
                refreshUrl: refreshUrl,
                refreshToken: refreshToken,
                clientId: clientId,
                clientSecret: clientSecret
            }
        });
        stream<SFContact, error?> queryResponse = check salesforceEp->query(soql = string `SELECT Id,FirstName,LastName,Email,Phone FROM Contact WHERE (Email = '${email}')`);

        SWaveContact[] contacts = [];
        check queryResponse.forEach(function (SFContact contact) {
            contacts.push(transform(contact));
        });

        return contacts;
    }
}


configurable string baseUrl = ?;
configurable string refreshUrl = ?;
configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;


type SFContact record {
    record {
        string 'type;
        string url;
    } attributes;
    string Id;
    string FirstName;
    string LastName;
    string Email;
    string Phone;
};

type SWaveContact record {
    string fullName;
    string phoneNumber;
    string email;
    string id;
};

function transform(SFContact sfContact) returns SWaveContact => {
    id: sfContact.Id,
    fullName: sfContact.FirstName + " " + sfContact.LastName,
    email: sfContact.Email,
    phoneNumber: sfContact.Phone
};
