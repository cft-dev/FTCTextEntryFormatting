### Overview

**FTCTextEntryFormatting** is a component for formatting input data in realtime.

### Installation

```ruby
pod 'FTCTextEntryFormatting', :git => 'https://github.com/cft-dev/FTCTextEntryFormatting.git', :tag => '1.0.4'
```

### Standalone usage

Example for cell phone. See Demo project for more details.

```swift
import FTCTextEntryFormatting

class EntryViewController: UIViewController
{
	@IBOutlet var textField: UITextField!

	// required strong stored
	var textFieldFormatCoordinator: FTCTextFieldFormatCoordinator!

	override func viewDidLoad()
	{
		super.viewDidLoad()

		self.textFieldFormatCoordinator = FTCTextFieldFormatCoordinator(textField: self.textField)

		let formattingConfig = FTCTextEntryFormattingConfigFactory.mobilePhoneConfig(with: "+7 (___) ___-__-__",
		                                                                             maskChar: "_")
		self.textFieldFormatCoordinator.apply(formattingConfig: formattingConfig)
	}
}
```

### Custom usage

1. Create adopter of FTCTextEntryEditingInputFilter

```swift
import FTCTextEntryFormatting

class CustomEditingInputFilter : NSObject, FTCTextEntryEditingInputFilter
{
	func replaceSubstring(in originalString: String, at range: NSRange, with replacement: String) -> FTCFilteredString
	{
		...
	}
}
```

2. Create adopter of FTCTextEntryFormatter

```swift
class CustomFormatter : NSObject, FTCTextEntryFormatter
{
	func raw(fromFormatted formattedValue: String?) -> String
	{
		...
	}

	func formatted(fromRaw rawValue: String?) -> String
	{
		...
	}

	func rangeInFormattedValue(for rangeInRawValue: NSRange, inRawValue rawValue: String?) -> NSRange
	{
		...
	}

	func rangeInRawValue(for rangeInFormattedValue: NSRange, inFormattedValue formattedValue: String?) -> NSRange
	{
		...
	}
}
```

3. Create adopter of FTCTextEntryNotEditingInputFilter

```swift
class CustomNotEditingInputFilter : NSObject, FTCTextEntryNotEditingInputFilter
{
	func filterString(_ string: String) -> String
	{
		...
	}
}
```

4. Use it

```swift
class EntryViewController: UIViewController
{
	@IBOutlet var textField: UITextField!

	// required strong stored
	var textFieldFormatCoordinator: FTCTextFieldFormatCoordinator!

	override func viewDidLoad()
	{
		super.viewDidLoad()

		self.textFieldFormatCoordinator = FTCTextFieldFormatCoordinator(textField: self.textField)

		let formattingConfig = FTCTextEntryFormattingConfig()
		formattingConfig.editingInputFilter = CustomEditingInputFilter()
		formattingConfig.editingFormatter = CustomFormatter()
		formattingConfig.notEditingInputFilter = CustomNotEditingInputFilter()
		formattingConfig.notEditingFormatter = CustomFormatter()

		self.textFieldFormatCoordinator.apply(formattingConfig: formattingConfig)
	}
}
```

### Generic input filters

FTCDigitsValueFilter – Allows only digits symbols.

FTCNoFilteringFilter – Allows any symbol.

FTCLimitedLengthInputFilter – Allows any symbol. Constraining input by length.

FTCToUpperCaseInputFilter – Allows any symbol. Turns case to upper.

### License
MIT
