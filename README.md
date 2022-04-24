# genda_home_assignment
matan's home assignment for genda application

## Description
this demo project represent the home page of the genda app.
I wrote documentation for each function and widget i created.
the screen itself divided to 4 parts:
component - the front, the widgets the user sees.
presenter - functions that manipulate the data to present in the component.
model - fetching the data from the json file.
view - abstract class that indicates changes in the component , can be called from the model and presenter. implemented in the component itself.

models:
User - user model according to the json file - containing also the Location model inside.
Location - location model inside the user that indicates the level and apartment the user in using the level and apartment index.
Level - level model according to the json file , has name ,index according to the list and apartments inside.
Contractor - Contractor model that has number/index and name.


utils: 
general utils - file that has inside all the general utils classes needed for the app. Like colors, references and more , currently I use only colors.
icons utils - because the icons folder has a lot of icons, i figured it will be better to have a file that handled it correctly,
 and turning each icon in the function into an widget from svg file.  
