package data.address;

import com.google.gson.annotations.SerializedName;

public class AddressDocument {
	
	@SerializedName("y")
	String lng; // 경도
	
	@SerializedName("x")
	String lat; // 위도
	
	@SerializedName("address_type")
	String type;
	
	@SerializedName("address_name")
	String name;

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
