import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardControllerProvider =
    ChangeNotifierProvider<DashboardController>((ref) {
  return DashboardController();
});

class DashboardController extends ChangeNotifier {
  int index = 0;

  setIndex(int i) {
    index = i;
    notifyListeners();
  }
}

class CompatibilityProfile {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> profileType;
  String category;
  Map<String, CompatibilityAnswer> compatibilityAnswers;
  PersonLocation personLocation;

  CompatibilityProfile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.profileType,
    required this.category,
    required this.compatibilityAnswers,
    required this.personLocation,
  });

  factory CompatibilityProfile.fromJson(Map<String, dynamic> json) {
    return CompatibilityProfile(
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      profileType: List<String>.from(json['profileType']['value']),
      category: json['category'],
      compatibilityAnswers: Map.fromIterable(
        json['compatibilityAnswers'].keys,
        key: (key) => key as String,
        value: (key) => CompatibilityAnswer.fromJson(
          json['compatibilityAnswers'][key],
        ),
      ),
      personLocation: PersonLocation.fromJson(json['personLocation']),
    );
  }
}

class CompatibilityAnswer {
  String type;
  bool isRequired;
  SeekingAnswer seekingAnswer;
  SeekerAnswer seekerAnswer;

  CompatibilityAnswer({
    required this.type,
    required this.isRequired,
    required this.seekingAnswer,
    required this.seekerAnswer,
  });

  factory CompatibilityAnswer.fromJson(Map<String, dynamic> json) {
    return CompatibilityAnswer(
      type: json['type'],
      isRequired: json['isRequired'],
      seekingAnswer: SeekingAnswer.fromJson(json['seekingAnswer']),
      seekerAnswer: SeekerAnswer.fromJson(json['seekerAnswer']),
    );
  }
}

class SeekingAnswer {
  String propertyKey;
  List<String> value;
  bool isHiddenOnPublicProfile;
  bool isADealBreaker;

  SeekingAnswer({
    required this.propertyKey,
    required this.value,
    required this.isHiddenOnPublicProfile,
    required this.isADealBreaker,
  });

  factory SeekingAnswer.fromJson(Map<String, dynamic> json) {
    return SeekingAnswer(
      propertyKey: json['propertyKey'],
      value: List<String>.from(json['value']),
      isHiddenOnPublicProfile: json['isHiddenOnPublicProfile'],
      isADealBreaker: json['isADealBreaker'],
    );
  }
}

class SeekerAnswer {
  String propertyKey;
  List<String> value;
  bool isHiddenOnPublicProfile;
  bool isADealBreaker;

  SeekerAnswer({
    required this.propertyKey,
    required this.value,
    required this.isHiddenOnPublicProfile,
    required this.isADealBreaker,
  });

  factory SeekerAnswer.fromJson(Map<String, dynamic> json) {
    return SeekerAnswer(
      propertyKey: json['propertyKey'],
      value: List<String>.from(json['value']),
      isHiddenOnPublicProfile: json['isHiddenOnPublicProfile'],
      isADealBreaker: json['isADealBreaker'],
    );
  }
}

class PersonLocation {
  String displayLocation;
  Map<String, dynamic> value;

  PersonLocation({
    required this.displayLocation,
    required this.value,
  });

  factory PersonLocation.fromJson(Map<String, dynamic> json) {
    return PersonLocation(
      displayLocation: json['displayLocation'],
      value: json['value'],
    );
  }
}

final jsonData = {
  "profileProgress": 100,
  "status": "published",
  "profileType": {
    "propertyKey": "",
    "value": ["Committed Partners"],
    "isHiddenOnPublicProfile": false
  },
  "category": "personal",
  "compatibilityAnswers": {
    "Preferred Gender": {
      "type": "multiselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Preferred Gender",
        "value": ["Woman"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Preferred Gender",
        "value": [],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Preferred Age Range": {
      "type": "multiselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Preferred Age Range",
        "value": ["18-25"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Preferred Age Range",
        "value": [],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Preferred Ethnicity": {
      "type": "multiselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Preferred Ethnicity",
        "value": ["Asian"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Preferred Ethnicity",
        "value": [],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Relationship Goals": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Relationship Goals",
        "value": ["Companionship"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Relationship Goals",
        "value": ["Long-term partnership"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Communication Style": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Communication Style",
        "value": ["Casual and spontaneous"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Communication Style",
        "value": ["Direct and open"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Lifestyle Preferences": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Lifestyle Preferences",
        "value": ["Active and adventurous"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Lifestyle Preferences",
        "value": ["Active and adventurous"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Values and Beliefs": {
      "type": "multiselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Values and Beliefs",
        "value": ["Family and relationships"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Values and Beliefs",
        "value": ["Career and success"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Conflict Resolution": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Conflict Resolution",
        "value": ["Open discussion"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Conflict Resolution",
        "value": ["Avoiding confrontation"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Time Together": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Time Together",
        "value": ["Some alone time is important"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Time Together",
        "value": ["Balanced time"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Financial Management": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Financial Management",
        "value": ["Flexible"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Financial Management",
        "value": ["Combination of both"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Family Planning": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Family Planning",
        "value": ["Do not want children"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Family Planning",
        "value": ["Already have children"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Leisure Activities": {
      "type": "multiselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Leisure Activities",
        "value": [
          "Outdoor and physical activities",
          "Cultural and artistic activities"
        ],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Leisure Activities",
        "value": [
          "Outdoor and physical activities",
          "Quiet and home-based activities"
        ],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Personal Space": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Personal Space",
        "value": ["Not very important"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Personal Space",
        "value": ["Not important"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Emotional Support": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Emotional Support",
        "value": ["Giving advice"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Emotional Support",
        "value": ["Giving advice"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Health and Wellness": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Health and Wellness",
        "value": ["No specific focus"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Health and Wellness",
        "value": ["Low priority"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Cultural and Social Views": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Cultural and Social Views",
        "value": ["Moderate"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Cultural and Social Views",
        "value": ["Conservative"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Hobbies and Interests Sharing": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Hobbies and Interests Sharing",
        "value": ["Somewhat important"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Hobbies and Interests Sharing",
        "value": ["Not important"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Social Circle Integration": {
      "type": "singleselect",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Social Circle Integration",
        "value": ["Prefer separate social circles"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Social Circle Integration",
        "value": ["Depends on the situation"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    },
    "Anything else?": {
      "type": "freetext",
      "isRequired": true,
      "seekingAnswer": {
        "propertyKey": "Anything else?",
        "value": ["fddytrdr"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      },
      "seekerAnswer": {
        "propertyKey": "Anything else?",
        "value": ["fsthdrudt"],
        "isHiddenOnPublicProfile": false,
        "isADealBreaker": false
      }
    }
  },
  "personLocation": {
    "propertyKey": "location",
    "value": {
      "startingPoint": "selectPlace",
      "searchRadius": 20,
      "localSearchRadius": 20,
      "localSearchRadiusUnit": "miles",
      "selectedCity": "",
      "selectedPresetPlace": "",
      "selectedPlace":
          "Rajiv Gandhi International Airport (HYD), Shamshabad, Hyderabad, Telangana, India",
      "currentPosition": {"lat": 17.2402633, "lng": 78.42938509999999},
      "presetPlace": null,
      "city": null,
      "place": {
        "value": {"place_id": "ChIJRRvZsX-7yzsRUajqM-wpIFM"},
        "label":
            "Rajiv Gandhi International Airport (HYD), Shamshabad, Hyderabad, Telangana, India"
      },
      "displayLocation":
          "Rajiv Gandhi International Airport (HYD), Shamshabad, Hyderabad, Telangana, India"
    },
    "isHiddenOnPublicProfile": false
  },
  "name": "",
  "_id": "65a8c25fef225c8fc08428d0",
  "createdAt": "2024-01-18T06:17:04.006Z",
  "updatedAt": "2024-01-18T06:17:04.006Z"
};
