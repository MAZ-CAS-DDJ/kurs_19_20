# REGEX CHEAT SHEET
by Simon Schmid. Work in progrss, without any guarantees. Spotted a mistake? Mail [here](mailto:simon@netwings.ch).

## Wildcards

| Shortcut | what it does |
|--------|---------|
| `.` | Match any character except newline |
| `\w` | letters |
| `\W` | not letters |
| `\d` | numbers [0-9] |
| `\D` | not numbers |
| `\s` | whitespace characters: space, tab... |
| `\S` | not space |
| `\b` | Word boundary: spaces, commas, end of line |
| `\B` | Not a word-boundary |
| `^` | match the beginning of string |
| `$` | match the end of string, including `\n` |

## Repetitions

| repetitions | what it does |
|--------|---------|
| `*` | match 0 or more repetitions |
| `+` | match 1 or more repetitions  |
| `?` | match 0 or 1 repetitions  |
| `{m}` | m specifies the number of repetitions  |
| `{m,n}` | m and n specifies a range of repetitions  |
| `{m,}` | m specifies the minimum number of repetitions  |

## Enclosures

| enclosures | what it does |
|--------|---------|
| `[]` | A defined **set** of characters to search for |
| `()` | A group of characters to search for, can be accessed in the results. |

## Wildcard sets

| Examples of sets | what it does |
|--------|---------|
| `[aeiou]` | Find any vowel |
| `[Tt]` | Find a lowercase or uppercase t |
| `[0-9]` | Find any number (there is a shortcut for this) |
| `[^0-9]` | Find anything that's not number (there is a shortcut for this) |
| `[13579]` | Find any odd numer |
| `[A-Za-z]` | Find any letter (there is a shortcut for this too) |
| `[+.*]` | Find those actual characters (special characters are canceled in sets) |

## Lookaround

| Lookahead/behind | what it does |
|--------|---------|
| `A(?=B)` | Find A if followed by B |
| `A(?!B)` | Find A if not followed by B |
| `(?<=B)A` | Find A if preceded by B |
| `(?<!B)A` | Find A if not preceded by B |
| `(A)\1` | Backreferencing content of group 1 |
