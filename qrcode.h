#ifndef EXPORT_H
#define EXPORT_H

#include <QObject>

class QRCode : public QObject
{	  
    Q_OBJECT
public:

	Q_INVOKABLE void generateQRCodeTest(QString str, QString filename);	
		
		
};

#endif
