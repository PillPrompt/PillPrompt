# PillPrompt - Medication Management Utility

## Team Members
- Freddie Clarke
- Abhi Sharma
- Evan Dilger
## General Idea
An app to manage personal medication

## User Stories

### Required
- [x] Users can create an account
- [x] Users can sign in
- [x] Users can log out
- Users can add a medication to thei list
- Users can see a list of their medication 
### Optional
- Users can set a time when they have to take their medication
- Users get push notifications when they have to take their pill
- Users can set how many pills they have remaining
- Users can see pharmacies in their area
- Users can share a list of their medication
- Users can set a profile picture
## Screens
- Load
- Login
- Signup page
- List of medication
- Add medication
 Profile (optional)

## Navigation Flows
-Login Page->Medication List
-SignUp Page->Medication List
-Edit button->Already filled add medication page

**Tab Navigation** (Tab to Screen)
- Home Feed (List of medication)
- Profile Tab

## Schema 
### Models
#### Medication

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | medicineId      | String   | unique id for the medication |
   | author        | Pointer to User| id of user who created medication object |
   | name         | String     | name of the medication |
   | frequency       | Integer   | integer representing how many times per day medication is taken |
   | days | String   | days of the week that the medication is taken |
   | times | String | times of the day that medication is taken|

#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userId      | String   | unique id for the user |
   | username  | String| username of user |
   | password  | String | password of user |
   | name | String   | name of user |
   | email | String   | email of user (optional) |
   | profileImage | Image | profile image for user (optional) |
   
### Networking
#### List of network requests by screen
   - Login/SignUp Screen
       - (Create/POST) Create a new User object
   - Home Screen
      - (Read/GET) Query all medication where user is author
   - Add Medication Screen
      - (Create/POST) Create a new post object 
   - Profile Screen
      - (Read/GET) Query current logged in user
      - (Update/PUT) Update user profile image
   - Medication Info Screen
       - (Read/GET) Query clicked on medication
       - (Delete) Delete clicked on medication
       - (Update/PUT) Update medication information
