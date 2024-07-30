// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';

import 'package:eClassify/Utils/Notification/chat_message_handler.dart';
import 'package:eClassify/data/model/chat/chat_message_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Ui/screens/chat/chatAudio/widgets/chat_widget.dart';
import '../../Ui/screens/chat/chat_screen.dart';
import '../../app/routes.dart';

import '../../data/Repositories/Item/item_repository.dart';
import '../../data/cubits/chatCubits/delete_message_cubit.dart';
import '../../data/cubits/chatCubits/get_buyer_chat_users_cubit.dart';
import '../../data/cubits/chatCubits/load_chat_messages.dart';
import '../../data/model/chat/chated_user_model.dart';
import '../../data/model/data_output.dart';

import '../../data/model/item/item_model.dart';

import '../../exports/main_export.dart';
import '../../main.dart';
import '../helper_utils.dart';
import 'awsomeNotification.dart';

String currentlyChatingWith = "";
String currentlyChatItemId = "";

class NotificationService {
  static FirebaseMessaging messagingInstance = FirebaseMessaging.instance;

  static LocalAwsomeNotification localNotification = LocalAwsomeNotification();

  static late StreamSubscription<RemoteMessage> foregroundStream;
  static late StreamSubscription<RemoteMessage> onMessageOpen;

  static requestPermission() async {}

  void updateFCM() async {
    await FirebaseMessaging.instance.getToken();
    // await Api.post(
    //     // url: Api.updateFCMId,
    //     parameter: {Api.fcmId: token},
    //     useAuthToken: true);
  }

  static handleNotification(RemoteMessage? message, [BuildContext? context]) {
    var notificationType = message?.data['type'] ?? "";

    log("@notificaiton data is ${message?.data}");

    if (notificationType == "chat") {
      var username = message?.data['user_name'];
      var itemImage = message?.data['item_image'];
      var itemName = message?.data['item_name'];
      var userProfile = message?.data['user_profile'];
      var senderId = message?.data['user_id'];
      var itemId = message?.data['item_id'];
      var date = message?.data['created_at'];
      var itemOfferId = message?.data['item_offer_id'];
      var itemPrice = message?.data['item_price'];
      var itemOfferPrice = message?.data['item_offer_amount'];
      var userType = message?.data['user_type'];

      if (userType == "Buyer") {
        (context as BuildContext)
            .read<GetBuyerChatListCubit>()
            .addNewChat(ChatedUser(
              itemId: int.parse(itemId),
              amount: int.parse(itemOfferPrice),
              createdAt: date,
              userBlocked: false,
              id: int.parse(itemOfferId),
              /* sellerId: senderId,*/
              updatedAt: date,
              item: Item(
                  id: int.parse(itemId),
                  price: int.parse(itemPrice),
                  name: itemName,
                  image: itemImage),
              /*seller: Seller(name: username, profile: userProfile),*/
              buyerId: int.parse(senderId),
              buyer: Buyer(
                  name: username,
                  profile: userProfile,
                  id: int.parse(senderId)),
            ));
      } else {
        (context as BuildContext)
            .read<GetBuyerChatListCubit>()
            .addNewChat(ChatedUser(
              itemId: int.parse(itemId),
              userBlocked: false,
              amount: int.parse(itemOfferPrice),
              createdAt: date,
              id: int.parse(itemOfferId),
              sellerId: int.parse(senderId),
              updatedAt: date,
              item: Item(
                  id: int.parse(itemId),
                  price: int.parse(itemPrice),
                  name: itemName,
                  image: itemImage),
              seller: Seller(
                  name: username,
                  profile: userProfile,
                  id: int.parse(senderId)),
            ));
      }

      ///Checking if this is user we are chatiing with
      if (senderId == currentlyChatingWith && itemId == currentlyChatItemId) {
        ChatMessageModal chatMessageModel = ChatMessageModal(
            id: int.parse(message?.data['id']),
            updatedAt: message?.data['updated_at'],
            createdAt: message?.data['created_at'],
            itemId: int.parse(message?.data['item_id']),
            audio: message?.data['audio'],
            file: message?.data['file'],
            message: message?.data['message'],
            receiverId: int.parse(HiveUtils.getUserId().toString()),
            senderId: int.parse(message?.data['sender_id']));
        //chatMessageModel.setIsSentByMe(false);
        //chatMessageModel.setIsSentNow(false);
        //ChatMessageHandler.add(chatMessageModel);

        ChatMessageHandler.add(ChatMessage(
          key: ValueKey(DateTime.now().toString().toString()),
          message: chatMessageModel.message,
          senderId: chatMessageModel.senderId!,
          createdAt: chatMessageModel.createdAt!,
          isSentNow: false,
          updatedAt: chatMessageModel.updatedAt!,
          audio: chatMessageModel.audio,
          file: chatMessageModel.file,
          itemOfferId: chatMessageModel.id!,
        ));

/*        ChatMessageHandler.add(
          Builder(builder: (context) {
            return ChatMessage(
              key: ValueKey(DateTime.now().toString().toString()),
              message: chatMessage,
              isSentByMe: false,
              propertyId: "",
              reciverId: "",
              isChatAudio: audioMessage != null && audioMessage != "",
              audioFile: audioMessage,
              attachment: attachment,
              hasAttachment: attachment != "" && attachment != null,
              senderId: senderId,
              time: time,
              itemOfferId: null,
            );
          }),
        );*/

        totalMessageCount++;
      } else {
        localNotification.createNotification(
          isLocked: false,
          notificationData: message!,
        );
      }
    } else {
      localNotification.createNotification(
          isLocked: false, notificationData: message!);
    }
  }

/*  static handleNotification(RemoteMessage? message,
      [BuildContext? context]) async {
    print("in notification****${message?.data['type']}***${message?.data}");
    var notificationType = message?.data['type'] ?? "";

    if (notificationType == "chat") {
      var username = message?.data['user_name'];
      var itemImage = message?.data['item_image'];
      var itemName = message?.data['item_name'];
      var userProfile = message?.data['user_profile'];
      var senderId = message?.data['user_id'];
      var itemId = message?.data['item_id'];
      var date = message?.data['created_at'];
      var itemOfferId = message?.data['item_offer_id'];
      var itemPrice = message?.data['item_price'];
      var itemOfferPrice = message?.data['item_offer_amount'];

*/ /*      (context as BuildContext).read<GetBuyerChatListCubit>().addNewChat(
          ChatedUser(
              itemId: itemId,
              amount: itemOfferPrice,
              createdAt: date,
              id: itemOfferId,
              sellerId: senderId,
              updatedAt: date,
              item: Item(
                  id: itemId,
                  price: itemPrice,
                  name: itemName,
                  image: itemImage),
              seller: Seller(name: username, profile: userProfile)));

      ///Checking if this is user we are chatiing with
      if (senderId == currentlyChatingWith && itemId == currentlyChatItemId) {
        ChatMessageHandler.add(
          Builder(builder: (context) {
            return ChatMessage(
              key: ValueKey(DateTime.now().toString().toString()),
              message: chatMessage,
              audio: audioMessage,
              file: attachment,
              senderId: senderId,
              createdAt: date,
              updatedAt: date,
              itemOfferId: int.parse(offerItemId),
            );
          }),
        );
        totalMessageCount++;
      } else {
        localNotification.createNotification(
          isLocked: false,
          notificationData: message,
        );
      }*/ /*

      Future.delayed(
        Duration.zero,
        () {
          Navigator.push(Constant.navigatorKey.currentContext!,
              MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LoadChatMessagesCubit(),
                  ),
                  BlocProvider(
                    create: (context) => DeleteMessageCubit(),
                  ),
                ],
                child: Builder(builder: (context) {
                  return ChatScreen(
                    profilePicture: userProfile ?? "",
                    userName: username ?? "",
                    itemImage: itemImage ?? "",
                    itemTitle: itemName ?? "",
                    userId: senderId ?? "",
                    itemId: itemId ?? "",
                    date: date ?? "",
                    itemOfferId: int.parse(itemOfferId!),
                    itemPrice: int.parse(itemPrice!),
                    itemOfferPrice: int.parse(itemOfferPrice!),
                  );
                }),
              );
            },
          ));
        },
      );
    }

    if (message?.data["item_id"] != null) {
      String id = message?.data["item_id"] ?? "";

      DataOutput<ItemModel> item =
          await ItemRepository().fetchItemFromItemId(int.parse(id));

      Future.delayed(
        Duration.zero,
        () {
          HelperUtils.goToNextPage(
              Routes.itemDetails, Constant.navigatorKey.currentContext!, false,
              args: {
                'itemData': item.modelList[0],
                'fromMyItem': false,
              });
        },
      );
    } else {
      Navigator.push(Constant.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const EntryPoint()));
    }
  }*/

  static init(context) {
    requestPermission();
    registerListeners(context);
  }

  static Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    if (message.notification == null) {
      handleNotification(
        message,
      );
    }
  }

  static forgroundNotificationHandler(BuildContext context) async {
    foregroundStream =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotification(message, context);
    });
  }

  static terminatedStateNotificationHandler(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message == null) {
          return;
        }
        if (message.notification == null) {
          handleNotification(message, context);
        }
      },
    );
  }

  static void onTapNotificationHandler(context) {
    onMessageOpen = FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {

      if (message.data['type'] == "chat") {
        var username = message.data['user_name'];
        var itemTitleImage = message.data['item_title_image'];
        var itemTitle = message.data['item_title'];
        var userProfile = message.data['user_profile'];
        var senderId = message.data['sender_id'];
        var itemId = message.data['item_id'];
        var date = message.data['created_at'];
        var itemOfferId = message.data['item_offer_id'];
        var itemPrice = message.data['item_price'];
        var itemOfferPrice = message.data['item_offer_amount'];
        Future.delayed(
          Duration.zero,
          () {
            Navigator.push(Constant.navigatorKey.currentContext!,
                MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) {
                    return LoadChatMessagesCubit();
                  },
                  child: Builder(builder: (context) {
                    return ChatScreen(
                      profilePicture: userProfile ?? "",
                      userName: username ?? "",
                      itemImage: itemTitleImage ?? "",
                      itemTitle: itemTitle ?? "",
                      userId: senderId ?? "",
                      itemId: itemId ?? "",
                      date: date ?? "",
                      itemOfferId: int.parse(itemOfferId),
                      itemPrice: int.parse(itemPrice!),
                      itemOfferPrice: int.parse(itemOfferPrice!),

                    );
                  }),
                );
              },
            ));
          },
        );
      } else if (message.data["item_id"] != null) {
        String id = message.data["item_id"] ?? "";
        DataOutput<ItemModel> item =
            await ItemRepository().fetchItemFromItemId(int.parse(id));
        Future.delayed(Duration.zero, () {
          HelperUtils.goToNextPage(Routes.adDetailsScreen,
              Constant.navigatorKey.currentContext!, false,
              args: {
                'model': item.modelList[0],
              });
        });
      } else {
       /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EntryPoint()));*/
      }
    }
// if (message.data["screen"] == "profile") {
//   Navigator.pushNamed(context, profileRoute);
// }

            );
  }

  static Future<void> registerListeners(context) async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await forgroundNotificationHandler(context);
    await terminatedStateNotificationHandler(context);
    onTapNotificationHandler(context);
  }

  static void disposeListeners() {
    onMessageOpen.cancel();
    foregroundStream.cancel();
  }
}
