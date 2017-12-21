// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

struct FormattingExampleItem
{
	let text: String
	let detailText: String?
	let config: FTCTextEntryFormattingConfig
	let keyboard: UIKeyboardType
}

extension FormattingExampleItem
{
	static func makeItems() -> [FormattingExampleItem]
	{

		return [
			self.makeCellPhoneItem(),
			self.makeMoneyItem(),
			self.makeCreditCardPANItem(),
			self.makeDriverLicenseModernItem(),
			self.makeDriverLicenseOutdatedItem(),
		]
	}

	static func makeCellPhoneItem() -> FormattingExampleItem
	{
		let config = FTCTextEntryFormattingConfigFactory.mobilePhoneConfig(with: "+7 (___) ___ __ __", maskChar: "_")

		return FormattingExampleItem(text: "Cell phone",
		                             detailText: nil,
		                             config: config,
		                             keyboard: .phonePad)
	}

	static func makeMoneyItem() -> FormattingExampleItem
	{
		let config = FTCTextEntryFormattingConfigFactory.moneyConfig(with: nil, onlyIntegral: false)

		return FormattingExampleItem(text: "Money",
		                             detailText: nil,
		                             config: config,
		                             keyboard: .decimalPad)
	}

	static func makeCreditCardPANItem() -> FormattingExampleItem
	{
		let maskConfig = FTCMaskFormatterGenericConfig(mask: "XXXX XXXX XXXX XXXX XXX", maskCharacter: "X")
		maskConfig.cutTail = true

		let maskFormatter = FTCMaskFormatter(config: maskConfig)
		let inputFilter = FTCDigitsValueFilter(maxLength: maskConfig.countMaskCharacters)

		let config = FTCTextEntryFormattingConfig(formatter: maskFormatter, inputFilter: inputFilter)

		return FormattingExampleItem(text: "Credit Card PAN",
		                             detailText: nil,
		                             config: config,
		                             keyboard: .numberPad)
	}

	static func makeDriverLicenseModernItem() -> FormattingExampleItem
	{
		let maskConfig = FTCMaskFormatterGenericConfig(mask: "__ __ ______", maskCharacter: "_")
		maskConfig.cutTail = false

		let maskFormatter = FTCMaskFormatter(config: maskConfig)
		let inputFilter = FTCDigitsValueFilter(maxLength: maskConfig.countMaskCharacters)

		let config = FTCTextEntryFormattingConfig(formatter: maskFormatter, inputFilter: inputFilter)

		return FormattingExampleItem(text: "Driver's license",
		                             detailText: "modern",
		                             config: config,
		                             keyboard: .numberPad)
	}

	static func makeDriverLicenseOutdatedItem() -> FormattingExampleItem
	{
		let maskConfig = FTCMaskFormatterGenericConfig(mask: "__ __ № ______", maskCharacter: "_")
		maskConfig.cutTail = false

		let maskFormatter = FTCMaskFormatter(config: maskConfig)
		let inputFilter = FTCToUpperCaseInputFilter()

		let config = FTCTextEntryFormattingConfig(formatter: maskFormatter, inputFilter: inputFilter)

		return FormattingExampleItem(text: "Driver's license",
		                             detailText: "outdated",
		                             config: config,
		                             keyboard: .default)
	}
}
