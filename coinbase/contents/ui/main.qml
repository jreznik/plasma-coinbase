import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: containment

    property string cryptoCurrency: plasmoid.configuration.cryptoCurrency
    property string displayedCurrency: plasmoid.configuration.displayedCurrency

    property string valueText: "N/A"

    Plasmoid.icon: "utilities-system-monitor"
    Plasmoid.switchWidth: units.gridUnit * 12
    Plasmoid.switchHeight: units.gridUnit * 12

    Plasmoid.compactRepresentation: Item {
        Layout.minimumWidth: priceLabel.paintedWidth

        Column {
            anchors.centerIn: parent

            PlasmaComponents.Label {
                id: changeLabel
                anchors.horizontalCenter: parent.horizontalCenter
                height: paintedHeight
                text: "1 " + containment.cryptoCurrency
            }

            PlasmaComponents.Label {
                id: priceLabel
                anchors.horizontalCenter: parent.horizontalCenter
                height: paintedHeight
                text: containment.valueText;
            }
        }
    }

    Timer {
        id: timer

        interval: 5000; running: true; repeat: true; triggeredOnStart: true

        property string requestUrl: "https://api.coinbase.com/v2/prices/" + containment.cryptoCurrency + "-" + containment.displayedCurrency + "/spot"
        onTriggered: request(requestUrl, function(reply) {
            var json = JSON.parse(reply.responseText)
            containment.valueText = json.data.amount + " " + json.data.currency
        }
        )

        function request(url, callback) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = (function(myxhr) {
                return function() {
                    if (myxhr.readyState === 4) callback(myxhr);
                }
            })(xhr);
            xhr.open('GET', url, true);
            xhr.send('');
        }
    }
}
