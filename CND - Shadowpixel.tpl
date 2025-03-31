___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CND - Shadowpixel",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Implement the shadowpixel from Cloud Nine Digital.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "endPoint",
    "displayName": "Enter the Endpoint URL",
    "simpleValueType": true,
    "defaultValue": "https://collect.cloudninedigital.nl"
  },
  {
    "type": "TEXT",
    "name": "section",
    "displayName": "Fill in the section",
    "simpleValueType": true,
    "help": "Enter a unique name for the section of the page. For example, use a descriptive label like \u0027page_type\u0027."
  },
  {
    "type": "TEXT",
    "name": "domain",
    "displayName": "Enter the predefined abbreviation for the domain",
    "simpleValueType": true,
    "help": "For example, \u0027www.cloudninedigital.nl\u0027 is abbreviated as \u0027CND\u0027. See the wiki for the overview list."
  },
  {
    "type": "TEXT",
    "name": "userAgent",
    "displayName": "Enter the userAgent Custom Javscript file",
    "simpleValueType": true,
    "help": "Create a custom Javascript variable that retrieves the user agent."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Required GTM functions and utilities
const log = require('logToConsole'); // Logs messages to GTM's console
const sendPixel = require('sendPixel'); // Sends a tracking pixel request
const copyFromWindow = require('copyFromWindow'); // Copies data from the browser window object
const copyFromDataLayer = require('copyFromDataLayer'); // Copies data from GTM's dataLayer
const encodeUriComponent = require('encodeUriComponent'); // Encodes URL components
const JSON = require('JSON'); // JSON object for parsing and stringifying
const getUrl = require('getUrl'); // Retrieves the current URL

// Extract values from GTM and window
const dataLayer = copyFromWindow('dataLayer'); // Retrieve the dataLayer array
const gtmId = copyFromDataLayer('gtm.uniqueEventId'); // Get the GTM event ID
const endPoint = data.endPoint; // Endpoint for data tracking
const domain = data.domain; // Current domain
const section = data.section; // Section of the website
const userAgent = data.userAgent; // User agent string

let latestEntry = {}; // Stores the latest matching dataLayer entry
let obj = [];

// 🔍 Find the latest entry in dataLayer matching the current GTM event ID
if (dataLayer && gtmId) {
  obj = dataLayer.map(o => {
    if (!o) return {}; // Skip undefined or null objects

    if (o['gtm.uniqueEventId']) return o; // If object has GTM event ID, return it

    o = JSON.parse(JSON.stringify(o)); // Clone the object to remove constructor
    log(o); // Log the cloned object for debugging

    // Iterate through object properties and return the first found
    for (let prop in o) {
      return o[prop];
    }
    return {}; // Ensure something is always returned
  }).filter(o => o && o['gtm.uniqueEventId'] === gtmId); // Filter for matching GTM event ID
}

// Use the first matching entry if available; otherwise, return an empty object
latestEntry = obj.length ? obj[0] : {};
log('Latest dataLayer entry:', latestEntry); // Log the latest found entry

// 🖥️ Function to detect browser type based on user agent
function getBrowser(userAgent) {
    if (!userAgent) return 'unknown'; // If no user agent, return 'unknown'

    if (userAgent.indexOf("Opera") !== -1 || userAgent.indexOf("OPR") !== -1) return 'Opera';
    if (userAgent.indexOf("Edg") !== -1) return 'Edge';
    if (userAgent.indexOf("Chrome") !== -1) return 'Chrome';
    if (userAgent.indexOf("Safari") !== -1) return 'Safari';
    if (userAgent.indexOf("Firefox") !== -1) return 'Firefox';
    if (userAgent.indexOf("MSIE") !== -1 || userAgent.indexOf("Trident") !== -1) return 'IE';
    
    return 'unknown'; // If no match, return 'unknown'
}

// 📱 Function to detect device type based on user agent
function getDeviceType() {
  let ua = userAgent; // Retrieve user agent

  if (!ua) {
    return "unknown"; // If no user agent, return 'unknown'
  }
  
  ua = ua.toLowerCase(); // Convert to lowercase for consistent comparison
  
  // Check if the device is a tablet
  if (ua.indexOf("tablet") !== -1 || 
      ua.indexOf("ipad") !== -1 || 
      ua.indexOf("playbook") !== -1 || 
      ua.indexOf("silk") !== -1 || 
      (ua.indexOf("android") !== -1 && ua.indexOf("mobi") === -1)) {
    return "tablet";
  }
  
  // Check if the device is a mobile phone
  if (ua.indexOf("mobile") !== -1 || 
      ua.indexOf("iphone") !== -1 || 
      ua.indexOf("ipod") !== -1 || 
      ua.indexOf("android") !== -1 || 
      ua.indexOf("blackberry") !== -1 || 
      ua.indexOf("iemobile") !== -1 || 
      ua.indexOf("kindle") !== -1 || 
      ua.indexOf("silk-accelerated") !== -1 || 
      ua.indexOf("hpw") !== -1 || 
      ua.indexOf("webos") !== -1 || 
      ua.indexOf("opera mobi") !== -1 || 
      ua.indexOf("opera mini") !== -1) {
    return "mobile";
  }
  
  return "desktop"; // Default to desktop if no matches
}

// Ensure latestEntry has valid values
const dataLayerPayload = latestEntry ? JSON.stringify(latestEntry) : {};

// Extract browser and device details
let browserName = getBrowser(userAgent); // Extract browser name
let deviceName = getDeviceType(userAgent); // Extract device name

// 📡 Construct the payload for tracking
let payload = {
  event: latestEntry['event'] || 'unknown', // Event name or 'unknown' if missing
  domain: domain, // Website domain 
  url: getUrl(), // Get the current URL
  device_type: deviceName, // Device type (mobile, tablet, or desktop)
  browser: browserName, // Browser type
  section: section, // Website section
  datalayer_payload: dataLayerPayload // Full dataLayer payload
};

// 🔗 Generate query string for URL parameters
let queryString = '';
for (let key in payload) {
    if (queryString !== '') {
        queryString += '&'; // Add '&' separator between key-value pairs
    }
    queryString += encodeUriComponent(key) + '=' + encodeUriComponent(payload[key]); // Encode values
}

// 📡 Construct the tracking pixel URL
const pixelUrl = endPoint +'/' + domain + '/datalayers/' + '?' + queryString;
log(pixelUrl);

// 📨 Send pixel request to the endpoint
sendPixel(pixelUrl, function(response) {
    log('SendPixel successful:', response); // Log successful request
    data.gtmOnSuccess(); // ✅ Mark the GTM tag execution as successful
}, function(error) {
    log('SendPixel error:', error); // Log any errors
    data.gtmOnFailure(); // Notify GTM of failure
});


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: View promotion event
  code: "const mockData = {\n    \"endPoint\": \"https://collect.cloudninedigital.nl\"\
    ,\n    \"section\":\"vfdssfdsfs\",\n    \"domain\":\"demo\",\n    \"userAgent\"\
    :\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)\
    \ Chrome/134.0.0.0 Safari/537.36\"\n  };\n  \n  mock('copyFromWindow', key =>\
    \ {\n   if(key === 'dataLayer') {\n    return dataLayer;\n  }\n  });\n  \n  mock('copyFromDataLayer',\
    \ key => {\n  if (key === 'gtm.uniqueEventId'){\n    return 4;\n  }\n  });\n\n\
    \  mock('sendPixel', (url, onSuccess, onFailure) => {\n    onFailure();\n  });\n\
    \  \n  // Call runCode to run the template's code.\n  runCode(mockData);\n  \n\
    \  // Verify that the tag finished successfully.\n  assertApi('gtmOnFailure').wasCalled();"
setup: |-
  //Example dataLayer object including a promotion_view
  const dataLayer = [
      {
          "event": "pageView",
          "pageCategory": "Luxury Travel Home",
          "gtm.uniqueEventId": 3
      },
      {
          "event": "view_promotion",
          "ecommerce": {
              "creative_name": "Summer Banner",
              "creative_slot": "featured_app_1",
              "promotion_id": "P_12345",
              "promotion_name": "Summer Sale",
              "items": [
                  {
                      "item_id": "SKU_12345",
                      "item_name": "Stan and Friends Tee",
                      "affiliation": "Google Merchandise Store",
                      "coupon": "SUMMER_FUN",
                      "discount": 2.22,
                      "index": 0,
                      "item_brand": "Google",
                      "item_category": "Apparel",
                      "item_category2": "Adult",
                      "item_category3": "Shirts",
                      "item_category4": "Crew",
                      "item_category5": "Short sleeve",
                      "item_list_id": "related_products",
                      "item_list_name": "Related Products",
                      "item_variant": "green",
                      "location_id": "ChIJIQBpAG2ahYAR_6128GcTUEo",
                      "price": 10.01,
                      "quantity": 3
                  }
              ]
          },
          "gtm.uniqueEventId": 4
      },
      {
          "event": "view_promotion",
          "ecommerce": {
              "creative_name": "Winter Banner",
              "creative_slot": "featured_app_2",
              "promotion_id": "P_98765",
              "promotion_name": "Winter Sale",
              "items": [
                  {
                      "item_id": "SKU_98765",
                      "item_name": "Stan and Friends Tee",
                      "affiliation": "Your Travel Buddy",
                      "coupon": "WINTER_FUN",
                      "discount": 4.44,
                      "index": 0,
                      "item_brand": "Google",
                      "item_category": "Apparel",
                      "item_category2": "Adult",
                      "item_category3": "Shirts",
                      "item_category4": "Crew",
                      "item_category5": "Short sleeve",
                      "item_list_id": "most_viewed",
                      "item_list_name": "Most viewed Products",
                      "price": 20.01,
                      "quantity": 1
                  }
              ]
          },
          "gtm.uniqueEventId": 5
      },
      {
          "gtm.start": 1741869570028,
          "event": "gtm.js",
          "gtm.uniqueEventId": 6
      },
      {
          "event": "gtm.dom",
          "gtm.uniqueEventId": 7
      },
      {
          "event": "gtm.load",
          "gtm.uniqueEventId": 8
      }
  ];


___NOTES___

Created on 31/03/2025, 16:16:48


