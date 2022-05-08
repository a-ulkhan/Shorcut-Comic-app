# The Shortcut Comics app

-  browse through the comics,
-  see the comic details, including its description

## Challenges and Solutions
- Used MVVM architecture with Coordinator pattern and Provider pattern. The coordinator pattern is responsible for navigation flow. Provider pattern supplies data without giving details weather it's from local storage or from network request.
- ViewController owns viewModel
- ViewController delegates/binds viewModel
- ViewModel owns provider
- Model is an Entity where no logic in it
- Coordinator is delegate of ViewModel
- Coordinator does not own viewController or viewModel.
- ViewController has no access to coordintor but can send request through viewModel and viewModel delegate the request to coordinator(Look viewModel.selectItem(at:) )

- Used dataSource approach where dataSoure is immutable data and supplied by viewModel to viewController
- DataSource should not be directly used from viewModel but it should be supplied and stored in ViewController to assure immutability(imagine the case where viewModel alters dataSoure while you're scroll through the content, it will crash unless you use some kind of streams(Bindings)
- Setting up view datas from api response is not encouraged, so for views we should have displayData where ViewModel is responsible to translate(convert)
  api response into displayData

- Used programmatic layout using UIKit: 
  - ComicViewController uses autolayout
  - Other uses Snapkit lib since it's more comfortable to use

-SDWebImage used to show images asynchronously
- To browse the comics we no api that returns a list, therefore (1...12).forEach used to get first 12 comics and parse it as a list
  "http://xkcd.com/\(comicNum)/info.0.json"
