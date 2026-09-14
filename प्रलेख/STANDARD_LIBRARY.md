# मानक-पुस्तकालयः (Sutra Standard Library)

This document describes the built-in mathematical, string, list, and input/output library operations exposed globally by the Sutra runtime.

---

## 1. Mathematical Functions (अङ्कगणित-कार्याणि)

Mathematical operations are defined to support both standard float-pointing digits and native integer structures:

### 1.1 `वर्गमूल(संख्या)`
* **Description**: Returns the square root of a numeric value.
* **Returns**: `दशमलव` (Float)

### 1.2 `घात(आधार, घातांक)`
* **Description**: Computes the value of base raised to the power exponent.
* **Returns**: `दशमलव` (Float)

### 1.3 `निरपेक्ष(मान)`
* **Description**: Returns the absolute value of integer or decimal digits.
* **Returns**: Same type as input.

### 1.4 `न्यूनतम(संख्या१, संख्या२)`
* **Description**: Returns the smaller of two numbers.
* **Returns**: Numeric value

### 1.5 `अधिकतम(संख्या१, संख्या२)`
* **Description**: Returns the larger of two numbers.
* **Returns**: Numeric value

### 1.6 `गोल(मान)`
* **Description**: Rounds the floating value to the nearest integer.
* **Returns**: `संख्या` (Integer)

---

## 2. String & List Operations (पाठ-सूची-कार्याणि)

### 2.1 `लंबाई(मान)`
* **Description**: Returns length. For string inputs, returns the number of UTF-8 codepoints (not bytes). For lists, returns the current element count.
* **Returns**: `संख्या` (Integer)

### 2.2 `उच्च(पाठ्य)`
* **Description**: Converts all characters in a string value to upper-case representation.
* **Returns**: `पाठ` (String)

### 2.3 `निम्न(पाठ्य)`
* **Description**: Converts all characters in a string value to lower-case representation.
* **Returns**: `पाठ` (String)

### 2.4 `प्रकार(मान)`
* **Description**: Returns the data type name of a value as a string: `"संख्या"`, `"दशमलव"`, `"पाठ"`, `"बूल"`, `"सूची"`, or `"शून्यम्"`.
* **Returns**: `पाठ` (String)

### 2.5 `जोड़ें(सूची, मान)`
* **Description**: Appends a value to the end of a list. Resizes list capacity if required.
* **Returns**: `सूची` (List)

---

## 3. Input & Output (पठन-लेखन-कार्याणि)

### 3.1 `लिखतु(मान)`
* **Description**: Prints a value (converting to string automatically) to standard output followed by a newline character.
* **Returns**: `शून्यम्`

### 3.2 `दर्शयतु(मान)`
* **Description**: Prints a value to standard output without appending a newline.
* **Returns**: `शून्यम्`

### 3.3 `पंक्तिं()`
* **Description**: Prints a newline character.
* **Returns**: `शून्यम्`

### 3.4 `पठतु()`
* **Description**: Reads a line of UTF-8 text from standard input (stdin) until a newline is reached.
* **Returns**: `पाठ` (String)
