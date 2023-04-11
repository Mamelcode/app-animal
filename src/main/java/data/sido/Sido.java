package data.sido;

public class Sido {
	SidoResponse response;

	public SidoResponse getResponse() {
		return response;
	}

	public void setResponse(SidoResponse response) {
		this.response = response;
	}

	@Override
	public String toString() {
		return "Sido [response=" + response + "]";
	}
}
