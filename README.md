# QuizMeUp

## Simple Quiz App that uses an API and Firebase to store data so players can play against eachother.

#### This Application consumes the [Quiz API](https://opentdb.com/api_config.php) to get the questions
#### The player can choose the category and the dificulty of the questions and acording to what was chosen the API response will vary. 
#### After the player chooses the category and dificulty and presses "Play" the first question and four answers will appear.
#### For each question the player has 15 seconds to answer. When the time runs out the next quetion will appear and 0 points will be scored. The faster the player anwsers more points will be scored. For each question answered a popup will appear letting the player know if the answser was right ou wrong. After the 10 questions are answered a screen will appear with the score of the game and a button to play again.

### Firebase
#### This app also uses Firebase. Whenever the player chooses the category and the difficulty a verification will be made in the data stored in the Firebase. If there is a game with the same category and the difficulty and only one player then the player will join that game. The game that is stored in Firebase has already been played by someone else and the player would be answering the same questions, therefor playing against someone else. After the player who joined a already existing game answers the 10 questions the score will be saved in the same game, and the player with the most points wins.
#### If there isn't any game stored in Fire base with the category and the difficulty chosen then a game will be created so a player can eventually join.

|<img src="ReadMe%20Images/print2.png" height="500">|<img src="ReadMe%20Images/print3.png" height="500">|
|<img src="ReadMe%20Images/print4.png" height="500">| <img src="ReadMe%20Images/print5.png" height="500">| <img src="ReadMe%20Images/print6.png" height="500">|

#### I made this app along with a friend of mine who did the same thing in Android some that we can play against each other.

##### This isn't a finished product. The players can't play in real time and there isn't a history of all the game in the app (I will get to it eventually)

