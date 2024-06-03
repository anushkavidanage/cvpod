/// Sample of strings used in the app.
///
/// Copyright (C) 2024 Software Innovation Institute, Australian National University
///
/// License: GNU General Public License, Version 3 (the "License")
/// https://www.gnu.org/licenses/gpl-3.0.en.html
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// Authors: Anushka Vidanage

// User bio data sample
Map bioData = {
  'name': 'Sarah Anderson',
  'gender': 'Female',
  'address': '23/A Murray Crescent, Canberra ACT 2600, Australia',
  'email': 'sarah.anderson@company.com.au',
  'phone': '+61 4123485657',
  'linkedin': 'linkedin.com/in/sarahanderson/',
  'web': 'sarahanderson.com.au'
};

// User summary sample
String summary =
    'I am a detail-oriented software engineer with a 5+ years of experience in the online services industry. Self mortivated individual with broad involvement in the software development and research projects as well as fieldwork. An excellent communicator with experince in working with wide range of clientele. I am now seeking a senior role where I can levarage my experience in project cordination and management.';

// User professional data sample
Map professionalData = {
  '1': {
    'title': 'Senior Software Engineer',
    'duration': 'Feb 2021 - Present',
    'company': 'Microsoft Online Services Division, Sydney, Australia',
    'comments':
        'Responsible for designing algorithms for different online services. Used Java, Dart, Flutter and Python for programming.',
  },
  '2': {
    'title': 'Junior Software Engineer',
    'duration': 'Jun 2018 - Jan 2021',
    'company': 'CornerStone, Victoria, Australia',
    'comments':
        'Build RESTful APIs that feed data to the JavaScript front-based on dynamically chosen user inputs.#Build internal tools using NodeJS to automate Q&A monitoring of web apps.',
  }
};

// User educational data sample
Map educationData = {
  '1': {
    'degree': 'Bachelor of Computer Science (Hons)',
    'duration': '2014 - 2018',
    'institute': 'The Australian National University',
    'comments': '1st class',
  },
  '2': {
    'degree': 'Diploma in Web Development',
    'duration': '2013 - 2014',
    'institute': 'Infortec International',
    'comments': 'Subjects: Web development, Software engineering, Databases',
  }
};

// User research data sample
Map researchData = {
  '1': {
    'title': 'Privacy-Preserving Record Linkage',
    'duration': 'Aug 2017 - Present',
    'institute': 'The Australian National University, Canberra, Australia',
    'comments':
        'Explore and develop privacy attacks on techniques utilised in privacy-preserving record linkage with the purpose of evaluating the privacy guarantees of those techniques.#Develop a vulnerability assessment framework to quantify the vulnerabilities of plaintext and encoded values in sensitive databases.',
  },
  '2': {
    'title': 'Solid decentralised personal online datastores (PODs)',
    'duration': 'Jul 2021 - Present',
    'institute':
        'Software Innovation Institute, The Australian National University',
    'comments':
        'Explore the means of collecting and storing sensitive, private, or confidential data in a decentralised manner by utlising services such as SOLID (solidproject.org) PODs.#Investigate the possibility of using encoding and/or encryption techniques to ensure the privacy of the data stored in PODs is preserved.#Application of various machine learning algorithms on stored data with the aim of providing individual services. The goal would be to offer the same level of services as provided by tech companies (such as Google and Facebook) while preserving the privacy of individuals whose data is being used.',
  }
};

// User publications data sample
Map publicationsData = {
  '1': {
    'citation':
        'Anushka Vidanage, Thilina Ranbaduge, Peter Christen, Rainer Schnell. 2020. “A Graph Matching Attack on Privacy-Preserving Record Linkage”. In ACM International Conference on Information and Knowledge Management (CIKM), Ireland (online), 1485-1494.',
    'year': 2020,
  },
  '2': {
    'citation':
        'Anushka Vidanage, Jess Moore, Sergio Rodriguez-Mendez, Graham Williams, Jason King. 2023. “Privacy Focused Health Data Storage and Access Control Through Personal Online Datastores”. In Vocabulary Symposium 2023.',
    'year': 2023,
  },
  '3': {
    'citation':
        'Anushka Vidanage, Jessica Moore, Graham Williams. 2023. “Data Privacy: Access and Consent Management using Personal Online Datastores - a Hand\'s on Primer”. In the 21st Australasian Data Mining Conference. Auckland, New Zealand. Tutorial.',
    'year': 2023
  },
  '4': {
    'citation':
        'Anushka Vidanage, Thilina Ranbaduge, Peter Christen, Sean Randall. 2020. “A Privacy Attack on Multiple Dynamic Match-key based Privacy-Preserving Record Linkage”. In International Journal of Population Data Science (IJPDS), 5 (1).',
    'year': 2020
  }
};

// User awards data sample
Map awardsData = {
  '1': {
    'title': 'Australia-Germany joint research cooperation scheme fund',
    'description':
        'For the research Development of secure and accurate binary encodings for multi-domain privacy-preserving record linkage. Co-investigator with Peter Christen, Thilina Ranbaduge, Rainer Schnell, and Sarah Redlich',
    'year': 2021,
  },
  '2': {
    'title': 'SIGIR student travel grant',
    'description': 'Conference on Information and Knowledge Management (CIKM)',
    'year': 2020,
  },
  '3': {
    'title': 'People\'s choice award',
    'description':
        'University level finals, Three Minute Thesis (3MT) competition',
    'year': 2019,
  },
};

// User presentations data sample
Map presentationsData = {
  '1': {
    'url': 'https://youtu.be/OYooBJQg3jc?si=3-xzgIZ9bHAcpXLO',
    'description':
        'Presenter - Building Health Software on Decentralised Health Data Using Personal Online Datastores. PyCon AU.',
    'year': 2023,
  },
  '2': {
    'url':
        'https://www.meetup.com/en-AU/canberra-python-meetup-group/events/294449703/',
    'description':
        'Invited Presenter - Personal Online Datastores for Data Governance and Consented Data Sharing. Canberra Python User Group - 2023 July Meetup',
    'year': 2023,
  },
};

// User extra data sample
Map extraData = {
  '1': {
    'description': 'Volunteer - ANU Open Day - School of Computing stall',
    'duration': '2024',
  },
  '2': {
    'description': 'Co-supervisor - One PhD student at the School of Computing',
    'duration': '2023 - Present',
  },
};

// User referee details sample
Map refereeData = {
  '1': {
    'name': 'Steven West',
    'position': 'Senior Architect',
    'email': 'steven.west@company.com.au',
    'institute': 'Microsoft Online Services Division, Sydney, Australia',
  },
  '2': {
    'name': 'Lisa Hart',
    'position': 'Project Manager',
    'email': 'lisa.hart@company.com.au',
    'institute': 'Microsoft Online Services Division, Sydney, Australia',
  },
  '3': {
    'name': 'Harold Ellis',
    'position': 'Senior Software Engineer',
    'email': 'harold.ellis@company.com.au',
    'institute': 'CornerStone, Victoria, Australia',
  },
};
