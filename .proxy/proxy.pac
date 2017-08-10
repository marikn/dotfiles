function FindProxyForURL(url, host) {
	if (shExpMatch(host,"ENTER_URL_MASK_HERE")) {
		return "PROXY ENTER_PROXY_ADDRESS_HERE";
	}

	return "DIRECT";
}