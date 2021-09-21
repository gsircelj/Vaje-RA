#include <iostream>
#include <string>

void binarnaPretvorba() {

}

bool preveriAliJeBin(std::string bin) {
	bool check = true;
	for (int i = 0; i < bin.size(); i++) {
		if (bin[i] != '1' && bin[i] != '0') {
			check = false;
		}
		else continue;
	}
	return check;
}

bool preveriAliJeHex(std::string bin) {
	bool check = true;
	std::string valid = "0123456789ABCDEFabcdef";
	for (int i = 0; i < bin.size(); i++) {
		if (valid.find(bin[i]) == std::string::npos) {
			check = false;
		}
		else continue;
	}
	return check;
}

bool preveriAliJeDes(std::string bin) {
	bool check = true;
	std::string valid = "0123456789";
	for (int i = 0; i < bin.size(); i++) {
		if (valid.find(bin[i]) == std::string::npos) {
			check = false;
		}
		else continue;
	}
	return check;
}

void hexVBin(std::string stevilo, std::string &bin) {

}

void kodiranje() {

}

void dekodiranje() {

}

int main() {

	std::cout << "UTF-8 kodiranje in dekodiranje\n\n";

	char izbira;
	std::cout << "Ali bi rad: A ... kodiral, ali: B ... dekodiral?\n";
	std::cout << "Izberi moznost: ";
	std::cin >> izbira;


	char podatkovni_tip;
	// kodiranje
	if (izbira == 'A') {
		std::cout << "Kateri podatkovni tip bi rad kodiral?\nB ... binarno stevilo, H ... heksadecimalno stevilo, D ... desetisko stevilo\n";

		while (true) {
			std::cout << "Izberi moznost: ";
			std::cin >> podatkovni_tip;

			//		putchar (toupper(podatkovni_tip));
			if (podatkovni_tip == 'B' || podatkovni_tip == 'H' || podatkovni_tip == 'D') break;
			else {
				std::cout << "\nError: Napacen vnos...\n";
				continue;
			}
		}
	}

	// dekodiranje
	else {
		std::cout << "Kateri podatkovni tip bi rad dekodiral?\nB ... binarno stevilo, H ... heksadecimalno stevilo\n";

		while (true) {
			std::cout << "Izberi moznost: ";
			std::cin >> podatkovni_tip;

			//		putchar (toupper(podatkovni_tip));
			if (podatkovni_tip == 'B' || podatkovni_tip == 'H') break;
			else {
				std::cout << "\nError: Napacen vnos...\n";
				continue;
			}
		}
	}



	std::string stevilo;
	std::string bin;
	while (true) {
		std::cout << "Vnesi stevilo: ";
		std::cin >> stevilo;

		if (podatkovni_tip == 'B') {
			if (preveriAliJeBin(stevilo)) {
				bin = stevilo;
				break;
			}
			else {
				std::cout << "Ni binarni zapis\n";
				continue;
			}
		}

		else if (podatkovni_tip == 'H') {
			if (preveriAliJeHex(stevilo)) {
				hexVBin(stevilo, bin);
				break;
			}
			else {
				std::cout << "Ni heksadecimalni zapis\n";
				continue;
			}
		}

		else {
			if (preveriAliJeDes(stevilo)) break;
			else {
				std::cout << "Ni desetiski zapis\n";
				continue;
			}
		}
	}



	return 0;
}