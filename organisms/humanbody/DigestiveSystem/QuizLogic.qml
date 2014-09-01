import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import components 1.0 as Components

RowLayout {
    id: root
    property string organism
    property string organSystem
    property string currentQuizOrgan
    property variant organs: ["liver", "intestine", "stomach"]

    property int score: 0

    signal selected(var selectDisplaySummary)


    Rectangle {
               id: diagram
               property string currentOrgan: "liver"
               color: "lightsteelblue"
               Layout.fillWidth: true
               Layout.fillHeight: true

               Button {
                   id: button
                   style: Components.ButtonStyle {}
                   text: "Visualize Score Summary"
                   x: 700
                   y: 70
                   onClicked: stack.push(scoreSummary)
                }

               Organs {
                    organism: root.organism
                    organSystem: root.organSystem
                    onClicked: diagram.handleAnswer(diagram.currentOrgan, root.currentQuizOrgan)
               }

                Column {
                  anchors {
                    right: parent.right;
                    margins: 10;
                    }

                  height: parent.height; width: 300
                  spacing: 5

                  Text {
                        id: questionText
                        font.bold: true
                        font.pixelSize: 14
                        text: "Question: where is " + root.currentQuizOrgan + "?"
                  }

                   Text {
                        id: scoreText
                        property string label: "Score"
                        font.bold: true
                        font.pixelSize: 14
                        color: "brown"
                        text: label + ": " + root.score
                    }
                }

                function handleAnswer(answerOrgan, correctOrgan) {
                    if (answerOrgan === correctOrgan) {
                        root.score += 1
                    }
                    var index = (root.organs.indexOf(correctOrgan) + 1)
                    if (index == root.organs.length) {
                            gameOver()

                    } else {
                        root.currentQuizOrgan = root.organs[index]
                    }
                }

                function gameOver() {
                    scoreText.label = "Game over, your score is"
                }

    }

}
