import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: containment

    PlasmaComponents.Label {
        id: priceLabel
        
        text: "N/A";
        font.pointSize: 96

        Timer {
            id: timer
        
            interval: 5000; running: true; repeat: true; triggeredOnStart: true
        
            onTriggered: request("https://api.coinbase.com/v2/prices/BTC-USD/spot", function(reply) {
                var json = JSON.parse(reply.responseText)

                priceLabel.text = json.data.amount + " " + json.data.currency
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
}
