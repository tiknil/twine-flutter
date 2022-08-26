# Twine Flutter formatter plugin
This [twine](https://github.com/scelis/twine) plugin provide a formatter for `.arb` files, used by Flutter projects.

## Features

* Generation of arb files from twine
* Consumation of localized arb files into twine
* Support of arb comments
* Basic support of arb placeholders

## Generation of localizations
To generate a localizations `.arb` file use twine `generate-localization-file` command.

Example:
`twine generate-localization-file twine.txt app_en.arb`

_Input twine file:_
```
[[Section A]]
    [key1]
        en = Text with comment for translators
        comment = comment key1
    [key2]
        en = Simple text
```

_Output arb file:_
```json
{
    "@@locale": "en",

    "key1": "Text with comment for translators",
    "@key1": {
        "description": "comment key1"
    },
    "key2": "Simple text"
}
```

## Consumation of localizations
To consume a twin localizations file to an `.arb` file use twine `consume-localization-file` command.
If you want to consume comments add `-c` option to the twine command.

Example:
`twine consume-localization-file twine.txt app_en.arb -c`

_Input arb file:_
```json
{
    "@@locale": "en",

    "key1": "Text with comment for translators",
    "@key1": {
        "description": "comment key1"
    },
    "key2": "Simple text"
}
```

_Output twine file:_
```
[[Uncategorized]]
	[key1]
		en = Text with comment for translators
		comment = comment key1
	[key2]
		en = Simple text
```

**Warning!** The arb file doesn't contain any reference to sections so all the keys are added to the "Uncategorized" section, when the `-a` option of `consume-localization-file` is used.

## Placeholders
Flutter provides [extended support](https://localizely.com/flutter-arb/) to placeholders in the localization files.

Currently this plugin support a basic use of placeholders automatically creating an untyped placeholder for every string wrapped with curlty braces.
Are only supported placeholders with lowercase chars, uppercase chars, digits, `.`, `_` and `-`.

Example:

_Input twine file:_
```
[[Section B]]
    [key3]
        en = Text with {name} placeholder
    [key4]
        en = Text with double placeholders {1} and {2} and a comment
        comment = comment key4

[[Section C]]
    [key5]
        en = Placeholders with punctuation: {p_1}, {p-1}, {p.1}
```

_Output arb file:_
```json
{
    "@@locale": "en",

    "key3": "Text with {name} placeholder",
    "@key3": {
        "placeholders": {
            "name": {}
        }
    },
    "key4": "Text with double placeholders {1} and {2} and a comment",
    "@key4": {
        "description": "comment key4",
        "placeholders": {
            "1": {},
            "2": {}
        }
    },

    "key5": "Placeholders with punctuation: {p_1}, {p-1}, {p.1}",
    "@key5": {
        "placeholders": {
            "p_1": {},
            "p-1": {},
            "p.1": {}
        }
    }
}
```

## Installation
Install this gem:

```ruby
gem install twine-flutter
```

Then setup twine to use this plugin as described [here](https://github.com/scelis/twine/blob/main/documentation/formatters.md#plugins) adding the following in a twine configuration file.

```ruby
gems: twine-flutter
```

## TODO

* Automatic testing
* Extended placeholder support