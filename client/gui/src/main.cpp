#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include <include/controlers/registrationcontroler.h>
#include <include/controlers/logincontroler.h>
#include <include/controlers/messagescontroler.h>
#include <include/controlers/chatscontroler.h>


#include <include/models/chats_filter_proxy_model.h>
#include <include/models/contacts_model.h>

#include <include/guiadapter.h>



using namespace m2::gui::controler;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    LoginControler::declareQML();
    RegistrationControler::declareQML();
    MessagesControler::declareQML();
    ChatsControler::declareQML();

    ContactsModel::declareQML();

    QQmlApplicationEngine engine;

    GuiAdapter::getGuiAdapter()->addModelsToEngineRoot(&engine);


    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
