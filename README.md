# StarShips
Coding Challenge
 
Created by Vimukthi Vishvanath on 10/10/21.
Copyright © 2021 Vimukthi Vishvanath. All rights reserved.

- Author has tried not to over-engineer the application and showed approaches which can be done when its scaled.
- App implemented MVVM architecture (Haven't used Any other complex patterns as its just one view - due to overengineer and time constraints)
- Mostly used the storyboard and nibs for layout designing since considering the time contraint.
- Auto Layout used for layout designing and configure them to be adapted to all the iphone devices.
- But Initially used the programatic approach to setup the rootviewcontroller(entry view) since it makes much easiar to change between entry views(like in login and logout).
- Tried to reduce using comments by using much meaningful names - which makes self explanatory the functionality.

* Folder structure:
    - Grouped by feature as thought it would be convinient for large scale app since developer needs to open few folders while working on.
    Easy for team development as well.

- No caching mechanism used to cache images, since there's no image urls involed in the project
-Author used three values to show on each cell considering the more menaingful of the each starship to the user.
- UITableview prefetch mechanism implemented to support for pagination, to follow best practices and improved the learning curve
Localization for future scalability and a process to structuring the app's code and for UI
    
* Author has used minimum number of third-party libraries to minimize dependencies.
  - CocoaPod used for dependency management (Reason: Familiarity)
  - For loadingIndicator and  Unit Testing
* Reasons:
        Easy learning curve within a team
        For easy error handling
        If issue (not support in future release) will not make huge impact on the development lifecycle.

 * Unit Tests:
     - Wrote unit tests for StarshipListVIewModel considering the given time for the test. Minimum code coverage.





# Considerations:

- Used a buton to select and to identify the favourited starship on each cell
    ex: Favourited starship cell showed with red colored star and the other one showed with a empty star
- Used a custom image to show each cell more elegant and more descriptive since the api not providing a url image for each starship
    
- Used to sort starships according to their name in the ascending order, but currently it applied to each page and not for the whole list.
- Author couldn't find a mechanism solve to sort all the items due to the given time constraint

- Used a modal view with bottom to top sliding animation to show the details of the each starship, while keeping the user's focus on the detail view

- Handled the errors using a custom error enum (using try ,catch ..)


# Things to improve (Author thought about):

- Repository pattern would be better solution to achive loose coupling and for keep domain objects persistant ignorant and abstract
    
- Tabview would be a best solution to keep the layout more user friendly as it provided enough option to show data seperately
    (like showing selected favourited starships in a seperate tab)
    
- Reactive programming (RxSwift or Combine) would be a better soulution for the future development as to maintain a cleaner code and architecture

# Please check the folder and architecture explanation on the app_architecture.pdf
link : https://github.com/vimukthivishvanath/StarShips/blob/main/app_architecture.pdf
