// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

//this is a function to convert JSON to a string
Event eventFromJson(String str) => Event.fromJson(json.decode(str));
//this is a function to convert string to a JSON
String eventToJson(Event data) => json.encode(data.toJson());

//the next classes are generated automatically depending on the content of the API
class Event {
  int id;
  String title;
  String slug;
  DateTime date;
  String locationText;
  dynamic heroText;
  String heroDescription;
  String copyrightText;
  String aboutText;
  String bottomRightText;
  String cssStyle;
  String ticketText1;
  String ticketText2;
  String registerText1;
  String registerText2;
  int scheduleMenuOrder;
  String scheduleMenuLabel;
  int speakersMenuOrder;
  String speakersMenuLabel;
  int expoMenuOrder;
  String expoMenuLabel;
  int jobsMenuOrder;
  String jobsMenuLabel;
  String schedulePageContent;
  String speakersPageContent;
  String expoPageContent;
  String jobsPageContent;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic activitiesMenuOrder;
  dynamic activitiesMenuLabel;
  String activitiesPageContent;
  dynamic discussions;
  int formEmailOrder;
  String formEmailLabel;
  String themeLabel;
  String subThemeLabel;
  dynamic fieldsNeedConfirmation;
  String visioLink;
  dynamic labels;
  String access;
  int formPasswordOrder;
  String ormPasswordLabel;
  dynamic forceUserLogin;
  dynamic goToAfterLogin;
  dynamic goToAfterRegister;
  dynamic participantsPageContent;
  dynamic stagesRefreshInterval;
  dynamic durationHours;
  dynamic organizerName;
  dynamic organizerEmail;
  dynamic leftLogoHref;
  List<dynamic> fields;
  dynamic ticketFields;
  List<dynamic> menuLinks;
  dynamic ticketConfiguration;
  dynamic participantsConf;
  LogoLeft logoLeft;
  dynamic logoRight;
  dynamic ticketLogo;
  List<Stage> stages;
  List<Sponsor> sponsors;
  List<dynamic> jobs;
  List<Speaker> speakers;
  List<dynamic> activities;

  Event({
    required this.id,
    required this.title,
    required this.slug,
    required this.date,
    required this.locationText,
    this.heroText,
    required this.heroDescription,
    required this.copyrightText,
    required this.aboutText,
    required this.bottomRightText,
    required this.cssStyle,
    required this.ticketText1,
    required this.ticketText2,
    required this.registerText1,
    required this.registerText2,
    required this.scheduleMenuOrder,
    required this.scheduleMenuLabel,
    required this.speakersMenuOrder,
    required this.speakersMenuLabel,
    required this.expoMenuOrder,
    required this.expoMenuLabel,
    required this.jobsMenuOrder,
    required this.jobsMenuLabel,
    required this.schedulePageContent,
    required this.speakersPageContent,
    required this.expoPageContent,
    required this.jobsPageContent,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    this.activitiesMenuOrder,
    this.activitiesMenuLabel,
    required this.activitiesPageContent,
    this.discussions,
    required this.formEmailOrder,
    required this.formEmailLabel,
    required this.themeLabel,
    required this.subThemeLabel,
    this.fieldsNeedConfirmation,
    required this.visioLink,
    this.labels,
    required this.access,
    required this.formPasswordOrder,
    required this.ormPasswordLabel,
    this.forceUserLogin,
    this.goToAfterLogin,
    this.goToAfterRegister,
    this.participantsPageContent,
    this.stagesRefreshInterval,
    this.durationHours,
    this.organizerName,
    this.organizerEmail,
    this.leftLogoHref,
    required this.fields,
    this.ticketFields,
    required this.menuLinks,
    this.ticketConfiguration,
    this.participantsConf,
    required this.logoLeft,
    this.logoRight,
    this.ticketLogo,
    required this.stages,
    required this.sponsors,
    required this.jobs,
    required this.speakers,
    required this.activities,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        date: DateTime.parse(json["date"]),
        locationText: json["locationText"],
        heroText: json["heroText"],
        heroDescription: json["heroDescription"],
        copyrightText: json["copyrightText"],
        aboutText: json["aboutText"],
        bottomRightText: json["bottomRightText"],
        cssStyle: json["cssStyle"],
        ticketText1: json["ticketText1"],
        ticketText2: json["ticketText2"],
        registerText1: json["registerText1"],
        registerText2: json["registerText2"],
        scheduleMenuOrder: json["scheduleMenuOrder"],
        scheduleMenuLabel: json["scheduleMenuLabel"],
        speakersMenuOrder: json["speakersMenuOrder"],
        speakersMenuLabel: json["speakersMenuLabel"],
        expoMenuOrder: json["expoMenuOrder"],
        expoMenuLabel: json["expoMenuLabel"],
        jobsMenuOrder: json["jobsMenuOrder"],
        jobsMenuLabel: json["jobsMenuLabel"],
        schedulePageContent: json["schedulePageContent"],
        speakersPageContent: json["speakersPageContent"],
        expoPageContent: json["expoPageContent"],
        jobsPageContent: json["jobsPageContent"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        activitiesMenuOrder: json["activitiesMenuOrder"],
        activitiesMenuLabel: json["activitiesMenuLabel"],
        activitiesPageContent: json["activitiesPageContent"],
        discussions: json["discussions"],
        formEmailOrder: json["formEmailOrder"],
        formEmailLabel: json["formEmailLabel"],
        themeLabel: json["themeLabel"],
        subThemeLabel: json["subThemeLabel"],
        fieldsNeedConfirmation: json["fieldsNeedConfirmation"],
        visioLink: json["visioLink"],
        labels: json["labels"],
        access: json["access"],
        formPasswordOrder: json["formPasswordOrder"],
        ormPasswordLabel: json["ormPasswordLabel"],
        forceUserLogin: json["forceUserLogin"],
        goToAfterLogin: json["goToAfterLogin"],
        goToAfterRegister: json["goToAfterRegister"],
        participantsPageContent: json["participantsPageContent"],
        stagesRefreshInterval: json["stagesRefreshInterval"],
        durationHours: json["durationHours"],
        organizerName: json["organizerName"],
        organizerEmail: json["organizerEmail"],
        leftLogoHref: json["leftLogoHref"],
        fields: List<dynamic>.from(json["fields"].map((x) => x)),
        ticketFields: json["ticketFields"],
        menuLinks: List<dynamic>.from(json["menuLinks"].map((x) => x)),
        ticketConfiguration: json["ticketConfiguration"],
        participantsConf: json["participantsConf"],
        logoLeft: LogoLeft.fromJson(json["logoLeft"]),
        logoRight: json["logoRight"],
        ticketLogo: json["ticketLogo"],
        stages: List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))),
        sponsors: List<Sponsor>.from(
            json["sponsors"].map((x) => Sponsor.fromJson(x))),
        jobs: List<dynamic>.from(json["jobs"].map((x) => x)),
        speakers: List<Speaker>.from(
            json["speakers"].map((x) => Speaker.fromJson(x))),
        activities: List<dynamic>.from(json["activities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "date": date.toIso8601String(),
        "locationText": locationText,
        "heroText": heroText,
        "heroDescription": heroDescription,
        "copyrightText": copyrightText,
        "aboutText": aboutText,
        "bottomRightText": bottomRightText,
        "cssStyle": cssStyle,
        "ticketText1": ticketText1,
        "ticketText2": ticketText2,
        "registerText1": registerText1,
        "registerText2": registerText2,
        "scheduleMenuOrder": scheduleMenuOrder,
        "scheduleMenuLabel": scheduleMenuLabel,
        "speakersMenuOrder": speakersMenuOrder,
        "speakersMenuLabel": speakersMenuLabel,
        "expoMenuOrder": expoMenuOrder,
        "expoMenuLabel": expoMenuLabel,
        "jobsMenuOrder": jobsMenuOrder,
        "jobsMenuLabel": jobsMenuLabel,
        "schedulePageContent": schedulePageContent,
        "speakersPageContent": speakersPageContent,
        "expoPageContent": expoPageContent,
        "jobsPageContent": jobsPageContent,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "activitiesMenuOrder": activitiesMenuOrder,
        "activitiesMenuLabel": activitiesMenuLabel,
        "activitiesPageContent": activitiesPageContent,
        "discussions": discussions,
        "formEmailOrder": formEmailOrder,
        "formEmailLabel": formEmailLabel,
        "themeLabel": themeLabel,
        "subThemeLabel": subThemeLabel,
        "fieldsNeedConfirmation": fieldsNeedConfirmation,
        "visioLink": visioLink,
        "labels": labels,
        "access": access,
        "formPasswordOrder": formPasswordOrder,
        "ormPasswordLabel": ormPasswordLabel,
        "forceUserLogin": forceUserLogin,
        "goToAfterLogin": goToAfterLogin,
        "goToAfterRegister": goToAfterRegister,
        "participantsPageContent": participantsPageContent,
        "stagesRefreshInterval": stagesRefreshInterval,
        "durationHours": durationHours,
        "organizerName": organizerName,
        "organizerEmail": organizerEmail,
        "leftLogoHref": leftLogoHref,
        "fields": List<dynamic>.from(fields.map((x) => x)),
        "ticketFields": ticketFields,
        "menuLinks": List<dynamic>.from(menuLinks.map((x) => x)),
        "ticketConfiguration": ticketConfiguration,
        "participantsConf": participantsConf,
        "logoLeft": logoLeft.toJson(),
        "logoRight": logoRight,
        "ticketLogo": ticketLogo,
        "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
        "sponsors": List<dynamic>.from(sponsors.map((x) => x.toJson())),
        "jobs": List<dynamic>.from(jobs.map((x) => x)),
        "speakers": List<dynamic>.from(speakers.map((x) => x.toJson())),
        "activities": List<dynamic>.from(activities.map((x) => x)),
      };
}

class LogoLeft {
  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  LogoLeftFormats formats;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  String url;
  dynamic previewUrl;
  Provider provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  LogoLeft({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LogoLeft.fromJson(Map<String, dynamic> json) => LogoLeft(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: LogoLeftFormats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: providerValues.map[json["provider"]]!,
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Ext { PNG, JPG, JPEG, EXT_PNG }

final extValues = EnumValues(
    {".PNG": Ext.EXT_PNG, ".jpeg": Ext.JPEG, ".jpg": Ext.JPG, ".png": Ext.PNG});

class LogoLeftFormats {
  LogoLeftFormats();

  factory LogoLeftFormats.fromJson(Map<String, dynamic> json) =>
      LogoLeftFormats();

  Map<String, dynamic> toJson() => {};
}

enum Mime { IMAGE_PNG, IMAGE_JPEG }

final mimeValues =
    EnumValues({"image/jpeg": Mime.IMAGE_JPEG, "image/png": Mime.IMAGE_PNG});

enum Provider { AWS_S3, LOCAL }

final providerValues =
    EnumValues({"aws-s3": Provider.AWS_S3, "local": Provider.LOCAL});

class Speaker {
  int id;
  String name;
  String slug;
  String title;
  String company;
  String? bio;
  DateTime createdAt;
  DateTime updatedAt;
  String? email;
  LogoLeft image;

  Speaker({
    required this.id,
    required this.name,
    required this.slug,
    required this.title,
    required this.company,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    required this.image,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        title: json["title"],
        company: json["company"],
        bio: json["bio"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        email: json["email"],
        image: LogoLeft.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "title": title,
        "company": company,
        "bio": bio,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "email": email,
        "image": image.toJson(),
      };
}

class Sponsor {
  int id;
  String name;
  String slug;
  String? youtubeSlug;
  String? description;
  Tier? tier;
  String? website;
  DateTime createdAt;
  DateTime updatedAt;
  List<CallToAction> links;
  dynamic chat;
  CallToAction? callToAction;
  CardImage? cardImage;
  CardImage? logo;

  Sponsor({
    required this.id,
    required this.name,
    required this.slug,
    this.youtubeSlug,
    this.description,
    this.tier,
    this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.links,
    this.chat,
    this.callToAction,
    this.cardImage,
    this.logo,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        youtubeSlug: json["youtubeSlug"],
        description: json["description"],
        tier: tierValues.map[json["tier"] ?? "error"],
        website: json["website"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        links: List<CallToAction>.from(
            json["links"].map((x) => CallToAction.fromJson(x))),
        chat: json["chat"],
        callToAction: json["callToAction"] == null
            ? null
            : CallToAction.fromJson(json["callToAction"]),
        cardImage: json["cardImage"] == null
            ? null
            : CardImage.fromJson(json["cardImage"]),
        logo: json["logo"] == null ? null : CardImage.fromJson(json["logo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "youtubeSlug": youtubeSlug,
        "description": description,
        "tier": tierValues.reverse[tier],
        "website": website,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "chat": chat,
        "callToAction": callToAction?.toJson(),
        "cardImage": cardImage?.toJson(),
        "logo": logo?.toJson(),
      };
}

class CallToAction {
  int id;
  String text;
  String url;
  int order;
  dynamic group;
  dynamic inNewPage;

  CallToAction({
    required this.id,
    required this.text,
    required this.url,
    required this.order,
    this.group,
    this.inNewPage,
  });

  factory CallToAction.fromJson(Map<String, dynamic> json) => CallToAction(
        id: json["id"],
        text: json["text"],
        url: json["url"],
        order: json["order"],
        group: json["group"],
        inNewPage: json["inNewPage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "url": url,
        "order": order,
        "group": group,
        "inNewPage": inNewPage,
      };
}

class CardImage {
  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  CardImageFormats formats;
  String hash;
  Ext ext;
  Mime mime;
  double size;
  String url;
  dynamic previewUrl;
  Provider provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  CardImage({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: CardImageFormats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: providerValues.map[json["provider"]]!,
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CardImageFormats {
  Large? thumbnail;
  Large? medium;
  Large? small;
  Large? large;

  CardImageFormats({
    this.thumbnail,
    this.medium,
    this.small,
    this.large,
  });

  factory CardImageFormats.fromJson(Map<String, dynamic> json) =>
      CardImageFormats(
        thumbnail: json["thumbnail"] == null
            ? null
            : Large.fromJson(json["thumbnail"]),
        medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
        small: json["small"] == null ? null : Large.fromJson(json["small"]),
        large: json["large"] == null ? null : Large.fromJson(json["large"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail?.toJson(),
        "medium": medium?.toJson(),
        "small": small?.toJson(),
        "large": large?.toJson(),
      };
}

class Large {
  String name;
  String hash;
  Ext ext;
  Mime mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  Large({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    this.path,
    required this.url,
  });

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]]!,
        mime: mimeValues.map[json["mime"]]!,
        width: json["width"],
        height: json["height"],
        size: json["size"]?.toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

enum Tier { DIAMOND, GOLD, SILVER }

final tierValues = EnumValues(
    {"diamond": Tier.DIAMOND, "gold": Tier.GOLD, "silver": Tier.SILVER});

class Stage {
  int id;
  String name;
  String slug;
  String menuLabel;
  int menuOrder;
  String? stream;
  int conference;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic sideBarContent;
  bool activateLiveChat;
  bool isPublic;
  String? mainContent;
  dynamic visioLink;
  dynamic moderators;
  bool publicCanAccessViso;
  bool isGridViewStage;
  bool intergratedVisioForSpeakers;
  dynamic scheduleOrder;
  dynamic chat;
  List<Schedule> schedule;

  Stage({
    required this.id,
    required this.name,
    required this.slug,
    required this.menuLabel,
    required this.menuOrder,
    this.stream,
    required this.conference,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    this.sideBarContent,
    required this.activateLiveChat,
    required this.isPublic,
    this.mainContent,
    this.visioLink,
    this.moderators,
    required this.publicCanAccessViso,
    required this.isGridViewStage,
    required this.intergratedVisioForSpeakers,
    this.scheduleOrder,
    this.chat,
    required this.schedule,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        menuLabel: json["menuLabel"],
        menuOrder: json["menuOrder"],
        stream: json["stream"],
        conference: json["conference"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sideBarContent: json["sideBarContent"],
        activateLiveChat: json["activateLiveChat"],
        isPublic: json["isPublic"],
        mainContent: json["mainContent"],
        visioLink: json["visioLink"],
        moderators: json["moderators"],
        publicCanAccessViso: json["publicCanAccessViso"],
        isGridViewStage: json["isGridViewStage"],
        intergratedVisioForSpeakers: json["intergratedVisioForSpeakers"],
        scheduleOrder: json["scheduleOrder"],
        chat: json["chat"],
        schedule: List<Schedule>.from(
            json["schedule"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "menuLabel": menuLabel,
        "menuOrder": menuOrder,
        "stream": stream,
        "conference": conference,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sideBarContent": sideBarContent,
        "activateLiveChat": activateLiveChat,
        "isPublic": isPublic,
        "mainContent": mainContent,
        "visioLink": visioLink,
        "moderators": moderators,
        "publicCanAccessViso": publicCanAccessViso,
        "isGridViewStage": isGridViewStage,
        "intergratedVisioForSpeakers": intergratedVisioForSpeakers,
        "scheduleOrder": scheduleOrder,
        "chat": chat,
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      };
}

class Schedule {
  int id;
  String title;
  String? description;
  DateTime start;
  DateTime end;
  dynamic theme;
  dynamic subTheme;
  dynamic stream;
  dynamic shortDescription;
  List<dynamic> speakers;

  Schedule({
    required this.id,
    required this.title,
    this.description,
    required this.start,
    required this.end,
    this.theme,
    this.subTheme,
    this.stream,
    this.shortDescription,
    required this.speakers,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        theme: json["theme"],
        subTheme: json["subTheme"],
        stream: json["stream"],
        shortDescription: json["shortDescription"],
        speakers: List<dynamic>.from(json["speakers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "theme": theme,
        "subTheme": subTheme,
        "stream": stream,
        "shortDescription": shortDescription,
        "speakers": List<dynamic>.from(speakers.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

//this is the function that helps us to get the informations needed on the event using it's ID
Future<Event> getEvent() async {
  var url = "https://backstage.conference.evey.live/conferences/36";
  var response = await http.get(Uri.parse(url));
  var jsonString = response.body;
  Event event = eventFromJson(jsonString);
  return event;
}

//most of the content are writing in HTML form so I created this function to remove the tags and return them as a proper paragraphs
String htmlToString(html) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return html.replaceAll(exp, '');
}

//this is a global variable representing the event. It's going to be used by the other files to get the data needed
Future<Event> event = getEvent();
