{
  "name": "OHAutoNIBi18n",
  "version": "0.1.3",
  "summary": "Automate the internationalisation (i18n) of your XIB files without a line of code",
  "description": "This class allows you to **automate the internationalisation** (i18n) of your
  interface (XIB files) **without any additional code in your application**.

  No more using multiple XIBs for various locales or having outlets just to
  translate the text of a label!

  Simply use the keys of your `Localizable.strings` in the text of any element
  in your XIB (title of an `UIButton`, text of a `UILabel`, …), and it will be
  automatically translated on the fly at runtime! No code needed!",
  "homepage": "https://github.com/AliSoftware/OHAutoNIBi18n",
  "license": "MIT",
  "authors": { "Olivier Halligon": "olivier.halligon+ae@gmail.com" },
  "source": { "git": "https://github.com/AliSoftware/OHAutoNIBi18n.git",
    "tag": "0.1.3" },
    "requires_arc": true,
    "platforms": {
      "ios": "4.3",
      "watchos": "2.0"
    },
    "public_header_files": "OHAutoNIBi18n/*.h",
    "ios": {
      "source_files": ["OHAutoNIBi18n/OHAutoNIBi18n.m",
        "OHAutoNIBi18n/OHAutoNIBiOS.m"
      ],
      "frameworks": "UIKit"
    },
    "watchos": {
      "source_files": ["OHAutoNIBi18n/OHAutoNIBi18n.m"
      ],
    },
  }
