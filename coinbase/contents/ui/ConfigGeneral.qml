import QtQuick 2.2
import QtQuick.Controls 1.3
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: generalPage
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_cryptoCurrency: cryptocurrencyBox.currentText
    property alias cfg_displayedCurrency: displayedCurrencyBox.currentText

    signal configurationChanged

    Column {
        Row {
            spacing: 5
            Label {
                anchors.verticalCenter: cryptocurrencyBox.verticalCenter
                text: i18n("Monitored cryptoccurency:")
            }

            ComboBox {
                id: cryptocurrencyBox
                width: 200
                model: [ "BTC", "BCH", "ETH", "LTC" ]

                onActivated: {
                    saveConfig()
                    configurationChanged()
                }
            }
        }

        Row {
            spacing: 5
            Label {
                anchors.verticalCenter: displayedCurrencyBox.verticalCenter
                text: i18n("Displayed currency:")
            }

            ComboBox {
                id: displayedCurrencyBox
                width: 2007
                model: [ "USD", "EUR", "CZK" ]

                onActivated: {
                    saveConfig()
                    configurationChanged()
                }
            }
        }
    }

    Component.onCompleted: {
        cryptocurrencyBox.currentIndex = cryptocurrencyBox.find(plasmoid.configuration.cryptoCurrency)
        displayedCurrencyBox.currentIndex = displayedCurrencyBox.find(plasmoid.configuration.displayedCurrency)
    }

    function saveConfig() {
        plasmoid.configuration.cryptoCurrency = cryptocurrencyBox.currentText
        plasmoid.configuration.displayedCurrency = displayedCurrencyBox.currentText
    }
}

