#include "qrcode.h"
#include <string>
#include <vector>
#include <sstream>
#include <QImage>
#include <QFile>
#include <QDebug>
#include "QZXing.h"

using namespace std;

void QRCode::generateQRCodeTest(QString str,QString filename) {
	QImage barcode = QZXing::encodeData(str);
	//QImage barcode = QZXing::encodeData(data, QZXing::EncoderFormat_QR_CODE,
	//							QSize(240, 240), QZXing::EncodeErrorCorrectionLevel_L);
	barcode.save(filename + ".jpg");
}

