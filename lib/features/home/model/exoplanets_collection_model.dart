class NasaCollection {
  final String version;
  final String href;
  final List<NasaItem> items;

  NasaCollection({
    required this.version,
    required this.href,
    required this.items,
  });

  factory NasaCollection.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<NasaItem> nasaItems =
        itemsFromJson.map((item) => NasaItem.fromJson(item)).toList();

    return NasaCollection(
      version: json['version'],
      href: json['href'],
      items: nasaItems,
    );
  }
}

class NasaItem {
  final String href;
  final List<NasaData> data;
  final List<NasaLink> links;

  NasaItem({
    required this.href,
    required this.data,
    required this.links,
  });

  factory NasaItem.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] as List;
    List<NasaData> nasaData =
        dataFromJson.map((data) => NasaData.fromJson(data)).toList();

    var linksFromJson = json['links'] as List;
    List<NasaLink> nasaLinks =
        linksFromJson.map((link) => NasaLink.fromJson(link)).toList();

    return NasaItem(
      href: json['href'],
      data: nasaData,
      links: nasaLinks,
    );
  }
}

class NasaData {
  final String center;
  final String title;
  final List<String> keywords;
  final String nasaId;
  final String dateCreated;
  final String mediaType;
  final String description;
  final String? secondaryCreator;
  final String? description508;

  NasaData({
    required this.center,
    required this.title,
    required this.keywords,
    required this.nasaId,
    required this.dateCreated,
    required this.mediaType,
    required this.description,
    this.secondaryCreator,
    this.description508,
  });

  factory NasaData.fromJson(Map<String, dynamic> json) {
    return NasaData(
      center: json['center'],
      title: json['title'],
      keywords: List<String>.from(json['keywords']),
      nasaId: json['nasa_id'],
      dateCreated: json['date_created'],
      mediaType: json['media_type'],
      description: json['description'],
      secondaryCreator: json['secondary_creator'],
      description508: json['description_508'],
    );
  }
}

class NasaLink {
  final String href;
  final String rel;
  final String render;

  NasaLink({
    required this.href,
    required this.rel,
    required this.render,
  });

  factory NasaLink.fromJson(Map<String, dynamic> json) {
    return NasaLink(
      href: json['href'],
      rel: json['rel'],
      render: json['render'],
    );
  }
}
