TARGET = asteroid-qrcoder
CONFIG += asteroidapp
CONFIG += qzxing_multimedia
CONFIG += enable_encoder_qr_code

SOURCES +=     main.cpp \
				qrcode.cpp
				
HEADERS += qrcode.h

RESOURCES +=   resources.qrc

OTHER_FILES += main.qml

include(QZXing/QZXing.pri)
lupdate_only{ SOURCES = i18n/$$TARGET.desktop.h }
TRANSLATIONS = $$files(i18n/$$TARGET.*.ts)
QML_IMPORT_NAME = com.asteroidos.qrcoder
QML_IMPORT_MAJOR_VERSION = 1
