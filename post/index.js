
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient({ region: "us-east-2" });

exports.handler = function (event, context, callback) {
  console.log("processing event data: " + JSON.stringify(event.body, null, 2));
  let data;
  if(event.body != undefined){
    data = event.body;
  }else{
    data = event;
  }
  
  let params = {
    Item: {
      contact_id: data.contact_id,
      name: data.name,
      phones: data.phones,
      dob: data.dob,
      emails: data.emails,
      primary_phones: data.primary_phones,
      primary_email: data.primary_email
    },

    TableName: "contact_table",
  };

  console.log("Putting item in database : " + JSON.stringify(params.Item));
  docClient.put(params, function (err, data) {
    if (err) {
      callback(err, null);
    } else {
      console.log(JSON.stringify(data));
      let response = {
        statusCode: 200,
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      };
      callback(null, response);
    }
  });
};
