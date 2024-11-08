from pymongo import MongoClient

import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()


# Retrieve MongoDB connection details from environment variables
mongodb_uri = os.getenv('MONGODB_URI')
database_name = os.getenv('DATABASE_NAME')

# Connect to MongoDB
client = MongoClient(mongodb_uri)
db = client[database_name]



# Function to insert data into a collection
def insert_scenario_data(data, collection_name):
    # Connect to MongoDB
    client = MongoClient(mongodb_uri)
    db = client[database_name]

    # Insert data into the specified collection
    collection = db[collection_name]
    collection.insert_one(data)

    # Close the MongoDB connection
    client.close()

# Example data for Scenario 1
scenario1_data = {
  "users": ["A", "B", "C", "D"],
  "observations": [
    {"sender": "A", "recipient": "B", "message": "Redecentralization of the Web"},
    {"sender": "D", "recipient": "C", "message": "Web of Things"},
    {"sender": "C", "recipient": "B", "message": "Web Assembly"},
    {"sender": "B", "recipient": "D", "message": "Semantic Web and Linked Open Data"},
    {"sender": "C", "recipient": "A", "message": "Redecentralization of the Web"},
    {"sender": "D", "recipient": "A", "message": "Web-based learning"}
  ],
  "history": {
    "A": {
      "B": {"url": "https://example.com/Semantic-Web", "data": [9, 14]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [18, 11]},
      "D": {"url": "https://example.com/Semantic-Web", "data": [2, 15]}
    },
    "B": {
      "A": {"url": "https://example.com/Semantic-Web", "data": [17, 5]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [3, 0]},
      "D": {"url": "https://example.com/Web-Assembly", "data": [18, 5]}
    },
    "C": {
      "A": {"url": "https://example.com/Linked-Data", "data": [4, 1]},
      "B": {"url": "https://example.com/Web-based-learning", "data": [3, 1]},
      "D": {"url": "https://example.com/Web-of-Things", "data": [7, 3]}
    },
    "D": {
      "A": {"url": "https://example.com/Web-Assembly", "data": [3, 0]},
      "B": {"url": "https://example.com/Linked-Data", "data": [6, 2]},
      "C": {"url": "https://example.com/Web-Assembly", "data": [15, 46]}
    }
  }
}

# Example data for Scenario 2
scenario2_data = {
  "users": ["A", "B", "C", "D"],
  "observations": [
    {"sender": "A", "recipient": "B", "message": "Redecentralization of the Web"},
    {"sender": "A", "recipient": "D", "message": "Web of Things"},
    {"sender": "C", "recipient": "B", "message": "Web Assembly"},
    {"sender": "C", "recipient": "D", "message": "Semantic Web and Linked Open Data"},
    {"sender": "D", "recipient": "B", "message": "Redecentralization of the Web"},
    {"sender": "D", "recipient": "A", "message": "Web-based learning"}
  ],
  "history": {
    "A": {
      "B": {"url": "https://example.com/Semantic-Web", "data": [9, 20]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [18, 11]},
      "D": {"url": "https://example.com/Semantic-Web", "data": [2, 15]}
    },
    "B": {
      "A": {"url": "https://example.com/Semantic-Web", "data": [17, 5]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [3, 0]},
      "D": {"url": "https://example.com/Web-Assembly", "data": [18, 5]}
    },
    "C": {
      "A": {"url": "https://example.com/Linked-Data", "data": [4, 1]},
      "B": {"url": "https://example.com/Web-based-learning", "data": [3, 1]},
      "D": {"url": "https://example.com/Web-of-Things", "data": [7, 3]}
    },
    "D": {
      "A": {"url": "https://example.com/Web-Assembly", "data": [3, 0]},
      "B": {"url": "https://example.com/Linked-Data", "data": [6, 2]},
      "C": {"url": "https://example.com/Web-Assembly", "data": [15, 46]}
    }
  }
}

# Example data for Scenario 3
scenario3_data = {
  "users": ["A", "B", "C", "D"],
  "observations": [
    {"sender": "B", "recipient": "A", "message": "Redecentralization of the Web"},
    {"sender": "C", "recipient": "D", "message": "Web of Things"},
    {"sender": "D", "recipient": "A", "message": "Web Assembly"},
    {"sender": "A", "recipient": "B", "message": "Semantic Web and Linked Open Data"},
    {"sender": "B", "recipient": "C", "message": "Redecentralization of the Web"},
    {"sender": "C", "recipient": "D", "message": "Web-based learning"}
  ],
  "history": {
    "A": {
      "B": {"url": "https://example.com/Semantic-Web", "data": [9, 30]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [18, 11]},
      "D": {"url": "https://example.com/Semantic-Web", "data": [2, 15]}
    },
    "B": {
      "A": {"url": "https://example.com/Semantic-Web", "data": [17, 5]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [3, 0]},
      "D": {"url": "https://example.com/Web-Assembly", "data": [18, 5]}
    },
    "C": {
      "A": {"url": "https://example.com/Linked-Data", "data": [4, 1]},
      "B": {"url": "https://example.com/Web-based-learning", "data": [3, 1]},
      "D": {"url": "https://example.com/Web-of-Things", "data": [7, 3]}
    },
    "D": {
      "A": {"url": "https://example.com/Web-Assembly", "data": [3, 0]},
      "B": {"url": "https://example.com/Linked-Data", "data": [6, 2]},
      "C": {"url": "https://example.com/Web-Assembly", "data": [15, 46]}
    }
  }
}

# Example data for Scenario 4
scenario4_data = {
  "users": ["A", "B", "C", "D"],
  "observations": [
    {"sender": "D", "recipient": "A", "message": "Redecentralization of the Web"},
    {"sender": "A", "recipient": "B", "message": "Web of Things"},
    {"sender": "B", "recipient": "C", "message": "Web Assembly"},
    {"sender": "C", "recipient": "D", "message": "Semantic Web and Linked Open Data"},
    {"sender": "D", "recipient": "C", "message": "Redecentralization of the Web"},
    {"sender": "A", "recipient": "C", "message": "Web-based learning"}
  ],
  "history": {
    "A": {
      "B": {"url": "https://example.com/Semantic-Web", "data": [9, 40]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [18, 11]},
      "D": {"url": "https://example.com/Semantic-Web", "data": [2, 15]}
    },
    "B": {
      "A": {"url": "https://example.com/Semantic-Web", "data": [17, 5]},
      "C": {"url": "https://example.com/Web-based-learning", "data": [3, 0]},
      "D": {"url": "https://example.com/Web-Assembly", "data": [18, 5]}
    },
    "C": {
      "A": {"url": "https://example.com/Linked-Data", "data": [4, 1]},
      "B": {"url": "https://example.com/Web-based-learning", "data": [3, 1]},
      "D": {"url": "https://example.com/Web-of-Things", "data": [7, 3]}
    },
    "D": {
      "A": {"url": "https://example.com/Web-Assembly", "data": [3, 0]},
      "B": {"url": "https://example.com/Linked-Data", "data": [6, 2]},
      "C": {"url": "https://example.com/Web-Assembly", "data": [15, 46]}
    }
  }
}

# Example data for Scenario 5
scenario5_data = {
    "users": ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
    "observations": [
      {"sender": "D", "recipient": "A", "message": "Redecentralization of the Web"},
      {"sender": "A", "recipient": "B", "message": "Web of Things"},
      {"sender": "B", "recipient": "C", "message": "Web Assembly"},
      {"sender": "C", "recipient": "D", "message": "Semantic Web and Linked Open Data"},
      {"sender": "D", "recipient": "C", "message": "Redecentralization of the Web"},
      {"sender": "A", "recipient": "C", "message": "Web-based learning"},
      {"sender": "D", "recipient": "G", "message": "Web of Things"},
      {"sender": "G", "recipient": "A", "message": "Web Assembly"},
      {"sender": "A", "recipient": "D", "message": "Semantic Web"},
      {"sender": "B", "recipient": "F", "message": "Linked Open Data"}
    ],
    "history": {
      "A": {
        "B": {"url": "https://example.com/Semantic-Web", "data": [9, 40]},
        "C": {"url": "https://example.com/Web-based-learning", "data": [18, 11]},
        "D": {"url": "https://example.com/Semantic-Web", "data": [2, 15]},
        "E": {"url": "https://example.com/Web-of-Things", "data": [10, 20]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [15, 5]},
        "G": {"url": "https://example.com/Another-Web-Assembly", "data": [12, 8]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [17, 3]},
        "I": {"url": "https://example.com/Semantic-Web", "data": [1, 19]},
        "J": {"url": "https://example.com/Another-Web-Assembly", "data": [10, 10]}
      },
      "B": {
        "A": {"url": "https://example.com/Semantic-Web", "data": [17, 5]},
        "C": {"url": "https://example.com/Web-based-learning", "data": [3, 0]},
        "D": {"url": "https://example.com/Web-Assembly", "data": [18, 5]},
        "E": {"url": "https://example.com/Semantic-Web", "data": [3, 17]},
        "F": {"url": "https://example.com/Another-Web-Assembly", "data": [20, 0]},
        "G": {"url": "https://example.com/Web-Assembly", "data": [13, 7]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [16, 4]},
        "I": {"url": "https://example.com/Semantic-Web", "data": [7, 13]},
        "J": {"url": "https://example.com/Web-Assembly", "data": [8, 12]}
      },
      "C": {
        "A": {"url": "https://example.com/Linked-Data", "data": [4, 1]},
        "B": {"url": "https://example.com/Web-based-learning", "data": [3, 1]},
        "D": {"url": "https://example.com/Semantic-Web", "data": [3, 17]},
        "E": {"url": "https://example.com/Linked-Data", "data": [19, 1]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [3, 17]},
        "G": {"url": "https://example.com/Another-Web-Assembly", "data": [5, 15]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [13, 7]},
        "I": {"url": "https://example.com/Web-based-learning", "data": [9, 11]},
        "J": {"url": "https://example.com/Another-Web-Assembly", "data": [7, 13]}
      },
      "D": {
        "A": {"url": "https://example.com/Web-Assembly", "data": [19, 1]},
        "B": {"url": "https://example.com/Semantic-Web", "data": [6, 14]},
        "C": {"url": "https://example.com/Semantic-Web", "data": [15, 5]},
        "E": {"url": "https://example.com/Web-Assembly", "data": [17, 3]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [5, 15]},
        "G": {"url": "https://example.com/Another-Web-Assembly", "data": [14, 6]},
        "H": {"url": "https://example.com/Semantic-Web", "data": [11, 9]},
        "I": {"url": "https://example.com/Web-Assembly", "data": [16, 4]},
        "J": {"url": "https://example.com/Web-Assembly", "data": [19, 1]}
      },
      "E": {
        "A": {"url": "https://example.com/Web-of-Things", "data": [10, 10]},
        "B": {"url": "https://example.com/Web-Assembly", "data": [1, 19]},
        "C": {"url": "https://example.com/Linked-Data", "data": [12, 8]},
        "D": {"url": "https://example.com/Semantic-Web", "data": [17, 3]},
        "F": {"url": "https://example.com/Another-Web-Assembly", "data": [8, 12]},
        "G": {"url": "https://example.com/Semantic-Web", "data": [16, 4]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [19, 1]},
        "I": {"url": "https://example.com/Another-Web-Assembly", "data": [14, 6]},
        "J": {"url": "https://example.com/Another-Web-Assembly", "data": [7, 13]}
      },
      "F": {
        "A": {"url": "https://example.com/Web-Assembly", "data": [15, 5]},
        "B": {"url": "https://example.com/Another-Web-Assembly", "data": [7, 13]},
        "C": {"url": "https://example.com/Web-Assembly", "data": [17, 3]},
        "D": {"url": "https://example.com/Another-Web-Assembly", "data": [14, 6]},
        "E": {"url": "https://example.com/Web-Assembly", "data": [13, 7]},
        "G": {"url": "https://example.com/Semantic-Web", "data": [5, 15]},
        "H": {"url": "https://example.com/Web-based-learning", "data": [1, 19]},
        "I": {"url": "https://example.com/Web-Assembly", "data": [7, 13]},
        "J": {"url": "https://example.com/Semantic-Web", "data": [2, 18]}
      },
      "G": {
        "A": {"url": "https://example.com/Web-Assembly", "data": [15, 5]},
        "B": {"url": "https://example.com/Another-Web-Assembly", "data": [7, 13]},
        "C": {"url": "https://example.com/Web-based-learning", "data": [12, 8]},
        "D": {"url": "https://example.com/Semantic-Web", "data": [9, 11]},
        "E": {"url": "https://example.com/Another-Web-Assembly", "data": [1, 19]},
        "F": {"url": "https://example.com/Another-Web-Assembly", "data": [20, 0]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [13, 7]},
        "I": {"url": "https://example.com/Semantic-Web", "data": [10, 10]},
        "J": {"url": "https://example.com/Redecentralization", "data": [0, 20]}
      },
      "H": {
        "A": {"url": "https://example.com/Web-Assembly", "data": [4, 16]},
        "B": {"url": "https://example.com/Another-Web-Assembly", "data": [16, 4]},
        "C": {"url": "https://example.com/Web-Assembly", "data": [19, 1]},
        "D": {"url": "https://example.com/Semantic-Web", "data": [12, 8]},
        "E": {"url": "https://example.com/Redecentralization", "data": [2, 18]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [9, 11]},
        "G": {"url": "https://example.com/Web-Assembly", "data": [19, 1]},
        "I": {"url": "https://example.com/Semantic-Web", "data": [7, 13]},
        "J": {"url": "https://example.com/Another-Web-Assembly", "data": [18, 2]}
      },
      "I": {
        "A": {"url": "https://example.com/Web-Assembly", "data": [10, 10]},
        "B": {"url": "https://example.com/Web-based-learning", "data": [12, 8]},
        "C": {"url": "https://example.com/Another-Web-Assembly", "data": [5, 15]},
        "D": {"url": "https://example.com/Web-Assembly", "data": [16, 4]},
        "E": {"url": "https://example.com/Semantic-Web", "data": [13, 7]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [6, 14]},
        "G": {"url": "https://example.com/Semantic-Web", "data": [15, 5]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [9, 11]},
        "J": {"url": "https://example.com/Semantic-Web", "data": [13, 7]}
      },
      "J": {
        "A": {"url": "https://example.com/Semantic-Web", "data": [17, 3]},
        "B": {"url": "https://example.com/Web-Assembly", "data": [3, 17]},
        "C": {"url": "https://example.com/Another-Web-Assembly", "data": [13, 7]},
        "D": {"url": "https://example.com/Web-Assembly", "data": [15, 5]},
        "E": {"url": "https://example.com/Another-Web-Assembly", "data": [18, 2]},
        "F": {"url": "https://example.com/Web-Assembly", "data": [14, 6]},
        "G": {"url": "https://example.com/Semantic-Web", "data": [8, 12]},
        "H": {"url": "https://example.com/Web-Assembly", "data": [10, 10]},
        "I": {"url": "https://example.com/Another-Web-Assembly", "data": [16, 4]}
      }
    } 
}


# Insert data into collections dynamically
insert_scenario_data(scenario1_data, 'scenario_1')
insert_scenario_data(scenario2_data, 'scenario_2')
insert_scenario_data(scenario3_data, 'scenario_3')
insert_scenario_data(scenario4_data, 'scenario_4')
insert_scenario_data(scenario5_data, 'scenario_5')