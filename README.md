# A Complete System to Detect, Stop Cyberbullying Along with AI-Supported Mental Health Counselling Chatbot.

## Project Statement:

The goal of this project is to create a comprehensive system that integrates cutting-edge technology to identify and stop cyberbullying while also include a system for mental health therapy based on artificial intelligence. With this project, we hope to make the online world a safer place for everyone, especially those who are most at risk from the negative impacts of cyberbullying.

Our project's primary goal is to create a system that can identify cyberbullying. We seek to develop an algorithm that can recognize and detect instances of cyberbullying across various platforms and communication channels by utilizing deep learning and machine learning models. In order to identify hate speech, this system will employ an advanced text analysis technique

We will include a mental health counseling system powered by AI in our project in addition to the detecting system. We think it's critical to provide accessible and individualized mental health care since we are aware of the emotional toll that cyberbullying can have on people.  

The frontend application will be developed using the Flutter framework, ensuring a seamless and user-friendly experience across multiple platforms, including Android and Windows.

Our implementation efforts will be concentrated within institutions in order to maximize the impact of our approach. By using a targeted strategy, we can create better control and monitoring systems that guarantee the anti-cyberbullying laws are being followed. With close cooperation from these organizations, we will adapt the system to meet their unique requirements and easily incorporate it into their current work processes.

## Tools Used:
  -Django
  
  -Django-Rest Framework
  
  -OpenAI API
  
  -Flutter
  
  -Bnlp-toolkit
  
  -pytesseract

## Technical Design 
  
  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/079f57bf-d80d-4429-b1e8-60de75dbde7c)

## Implementation
We have developed our system in two parts. 

In the first part, we created a Backend Server using Django, which efficiently processes incoming requests. Python served as the primary language for our Backend server. We utilized a Sqlite3 database for data handling and storage, following the Django Object-Relational Model (ORM) to interact with the database. All data operations such as inputting, updating, deleting, and creation were implemented using the Object-Oriented Programming approach. Additionally, we integrated our Deep Learning and Machine Learning models into the backend server. Our backend system also performs Image to Text conversion. We established API endpoints to facilitate constant communication between our Frontend Application and Backend Server, collecting and processing data from the frontend.

For the second part, we developed our Frontend Application using the Flutter Framework, enabling us to create a versatile application for Web, Android, iOS, Windows, and Linux platforms. We established a connection between our Frontend Application and Backend Server through APIs. In the Flutter application, we collected user data and sent it to the Backend Server for processing.

To achieve high accuracy in detecting Bangla and English Hate Speech, we implemented various Machine Learning and Deep Learning models. For Bangla Hate Speech detection, we employed models such as Linear SVM, Naïve Bayes, Random Forest Classifier, Logistic Regression, and Sequential Models. Among them, the Sequential Model achieved the highest accuracy of 83.27%. Sequential Models are widely recognized for their effectiveness in Natural Language Processing tasks. For English Hate Speech Detection, we used models like Naïve Bayes, Linear SVM, and Decision Tree Models. Our highest accuracy of 96.37% was obtained using the Decision Tree Model.

To train our Machine & Deep Learning Models for Bangla Hate Speech Detection, we used “Benglai Hate Speech Dataset” from Kaggle. We collected some data via Google Form also and used them with it.
For English HateSpeech detection we used a dataset named “Cyber Bullying Dataset”, which is mainly a Twitter Parsed Dataset. We also added some of our Google Form data with it.

## PROJECT DESCRIPTION
### TO ACCESS APP:
The app opens with a welcome screen with two options. New users have to Signup First. Then they can login to use the app. Login requires User ID and password that was set before by user.

![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/ea8ac425-9dd6-413d-b879-e8ddcb8547c2) ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/75092044-f40a-457d-af6a-4f9cb7c30a50) ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/1047a6b7-8604-4aca-b854-de3fc350f358)

### LOGIN AS A STUDENT

  #### HOME PAGE:
  In the Nav bar section we have all the features. Default screen is “Home”. 
  “Home” will have all the complains that user will post. If there is multiple complains, it will show as separate complain cards. User can see short description of the complain from card. It will keep changing its status as Processing / Verified/ Failed.
  User can also check all the details about the complain that he/ she posted by clicking on the card.
  It will show 
  •	Whom he/she complaint against.
  •	Type harassment.
  •	Date and Time of harassment.
  •	Place of harassment.
  •	Status of complain.
  •	Complain description.

  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/f19442e9-0158-4b71-9426-f28a27bedcde)
  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/ce1c5e98-3a28-4140-be76-ae880973d095)
  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/5c5da2ad-c545-400c-86e5-961212adc5c4)

  #### PROFILE:

  From the Nav bar section we’ll finds “Profile” option. User can update his/ her profile with all the details. They can set profile picture. Later on they can edit and save the information if they need.

  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/18a238a4-0721-4205-9a3c-0a1f36f9a0c7)
  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/b8afc7d8-b668-4610-a815-d97c77ad4f07)

  #### CHATBOT:

  Victim need mental support and someone to talk nicely which will be done by the ChatBot. He/ She can talk anytime with the ChatBot.

  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/f7032bb7-86e4-46b0-bd1b-075beef63c03)

  #### ADD NEW COMPLAIN:

  User can add new complain if they want. They need to fill up the form carefully with accurate details. They need to upload valid images as proves.

  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/b6481b6e-e20a-41c8-b1ed-4457185219d8)
  ![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/160fb6f1-91b3-43c4-90a5-c32db24cf3ec)

### LOGIN AS A PROCTOR:

#### PROCTOR SCREEN:
Default screen is “Proctor Screen”. This will have all the New and Old complains that users posted. It will show as separate complain cards. User can see short description of the complaint from card. Status will keep “Checked” is the complaint is old and already judged. Otherwise, it’ll show “Unchecked” if it’s new and not judged yet.
Proctor can also check all the details about the complain users posted by clicking on the card.
It will show 
•	Who complained.
•	Whom he/she complaint against.
•	Type harassment.
•	Date and Time of harassment.
•	Place of harassment.
•	Status of complain.
•	Complain description.
•	Submitted proves.
•	Field to enter opinions
•	Call parents for meeting
•	Mark bully as “Guilty ” or “Not Guilty”.

![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/ffbb222b-eab7-4201-9c50-0e921eedc88f)
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/b80c634a-48fb-4bc7-b31f-109d0c053db7)
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/249681d2-8c64-4863-8410-020a6289dd17)
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/17cdcddc-a5a6-4204-a54e-3d6925f78824)
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/855fd36b-4432-4f3e-b3f3-357f25a74e93)

## Results and Comparison:
From our research on the Internet we have not found anything that is a complete system to detect, stop cyber bullying and also a system for mental health counseling. I am attaching some of the existing applications that has been implemented in order to prevent cyber bullying:

  1.	Bully Button: Bully Button is a handy application that allows users to flag and alert instances of online harassment through a simple and effective alert framework.

  2.	ReThink: The intention behind ReThink is to prevent instances of cyberbullying before they have even occurred. The app flags messages that have been predetermined to contain hateful or abusive content and offers senders the chance to reword or reconsider their messages. Users then have to clear their choice of words. This extra encouragement to reflect on word choice could go a long way in preventing cyberbullies from hurting others.


  3.	BulliBlock: Bully Block is a free app designed to help young people deal with bullying when it does occur. Users can discreetly record and capture instances of harassment and use their evidence to report to responsible adults. Users can easily record their harassers and catch them in the act. Users can also block certain content, such as harassment or abusive language. Everything that users record will be saved onto your device’s SD card, meaning it can be presented as evidence to the appropriate authorities!

  4.	Take a Stand Together: This app was developed by the Australian educational authority to tackle the issue of cyberbullying among school children. Take a Stand Together provides its users with a host of handy tips, resources, and support that they can use in the occurrence of harassment. The app offers young people stories, advice, and animated clips that explain bullying in various forms.


Our system provides an end-to-end solution under the control of an authority, whether it be an organization or an educational institution. This ensures that victims receive proper justice. Additionally, our application offers mental health counseling for those in need, providing a safe space for individuals who may not feel comfortable seeking in-person counseling. Users also have the option to chat with a ChatBot if they feel lonely and simply need someone to talk to. Our project maintains a record of user activity, serving as a footprint that can be utilized in the future for both bullies and victims. By doing so, we aim to raise awareness in society, prevent cyberbullying, and protect potential victims.

Experimental result for our Machine & Deep Learning Models, OCR system results are given below as 
Screnshots:
#### Image to text Result for Bangla Language:

![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/d439eb4d-9a52-4abd-a178-e42ddb7e11bf)
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/97de5856-644a-4e75-a78d-e5c27d0299f2)

#### Bangla hate speech detection with Sequential Model results:
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/cb0e6cd7-4d76-4525-8734-d1176f5a327d)

![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/dde2882f-ad7a-4b1b-8c6b-80bcae8839a7)

#### English Hate Speech Detection With Decision Tree Model:
![image](https://github.com/FarhanTahmid/CyberBullying-Detection-Prevention-Counseling-System/assets/62169118/ba32f636-fe88-4160-b2bc-ece9e06c3914)

## Future Direction:

Presently, we are in the process of implementing our ChatBot using OpenAI's API. However, our future plan is to develop and integrate our own generative text methods to enhance the ChatBot's capabilities. This transition will enable us to have greater control and customization over the ChatBot's responses and behavior.

A crucial aspect of our future ChatBot development involves collecting and learning from user behavior. By analyzing user interactions, we can gather valuable insights into their preferences, needs, and patterns. This data-driven approach allows us to continually improve the ChatBot's understanding and response generation, making it more tailored and effective in providing support.

By incorporating our own generative text methods, we can create a ChatBot that aligns closely with our specific requirements and objectives. This level of customization ensures that the ChatBot's responses are accurate, relevant, and aligned with our desired user experience. Additionally, it grants us the flexibility to adapt and refine the ChatBot over time based on user feedback and changing needs.

In summary, while we are currently utilizing OpenAI's API for our ChatBot implementation, our future plans involve developing our own generative text methods and incorporating user behavior analysis. This approach enables us to create a more personalized and effective ChatBot that better meets the needs of our users.

## Conclusion:

In conclusion, our project has successfully developed a comprehensive system aimed at detecting and preventing cyberbullying while incorporating an AI-based mental health counseling system. We recognized the critical importance of addressing cyberbullying, a pervasive issue with significant consequences for individuals' well-being and mental health.

By leveraging advanced AI technologies, we implemented a robust cyberbullying detection system capable of identifying and flagging instances of harmful behavior. Our system covers various aspects of cyberbullying, including detection, reporting, and taking appropriate actions against bullies. Furthermore, we integrated an AI-based mental health counseling system, providing a safe and accessible platform for individuals to seek support and guidance in a confidential manner.

Throughout the project, we meticulously planned and implemented our backend server using Django, incorporating deep learning and machine learning models to enhance accuracy and efficiency. We developed a user-friendly frontend application using the versatile Flutter framework, ensuring seamless user experiences across multiple platforms.

To address the challenges of implementation, we strategically focused on deploying our system within organizations, offices, and institutions. This approach allowed for better control, monitoring, and collaboration with established authority figures, leading to more effective cyberbullying prevention measures.

While our project achieved significant milestones, we acknowledge that there is room for future enhancements. Specifically, incorporating transformer models for improved accuracy in Bangla cyberbullying detection and further refining the ChatBot by leveraging our own generative text methods.

In conclusion, our complete system to detect and prevent cyberbullying, combined with an AI-based mental health counseling system, stands as a testament to our commitment to creating a safer and more compassionate digital society. By empowering individuals, raising awareness, and providing effective support mechanisms, we aim to combat cyberbullying and promote the overall well-being of individuals in online spaces.





