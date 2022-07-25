class Location {
  Address address;
  String description;
  String businessEmail;
  String businessName;
  String country;
  String currency;
  String id;
  String languageCode;
  String logoUrl;
  String merchantId;
  String name;
  String posBackgroundUrl;
  String status;

  Location(
      {this.address,
      this.businessEmail,
      this.businessName,
      this.country,
      this.description,
      this.currency,
      this.id,
      this.languageCode,
      this.logoUrl,
      this.merchantId,
      this.name,
      this.posBackgroundUrl,
      this.status});

  Location.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    businessEmail = json['business_email'];
    businessName = json['business_name'];
    country = json['country'];
    description = json['description'];
    currency = json['currency'];
    id = json['id'];
    languageCode = json['language_code'];
    logoUrl = json['logo_url'];
    merchantId = json['merchant_id'];
    name = json['name'];
    posBackgroundUrl = json['pos_background_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['business_email'] = this.businessEmail;
    data['business_name'] = this.businessName;
    data['country'] = this.country;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['language_code'] = this.languageCode;
    data['logo_url'] = this.logoUrl;
    data['merchant_id'] = this.merchantId;
    data['name'] = this.name;
    data['pos_background_url'] = this.posBackgroundUrl;
    data['status'] = this.status;
    return data;
  }
}

class Address {
  String addressLine1;
  String administrativeDistrictLevel1;
  String country;
  String locality;
  String postalCode;

  Address(
      {this.addressLine1,
      this.administrativeDistrictLevel1,
      this.country,
      this.locality,
      this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line_1'];
    administrativeDistrictLevel1 = json['administrative_district_level_1'];
    country = json['country'];
    locality = json['locality'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line_1'] = this.addressLine1;
    data['administrative_district_level_1'] = this.administrativeDistrictLevel1;
    data['country'] = this.country;
    data['locality'] = this.locality;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
