# vim-stumble

If you are you using the Swedish Balans time registration system, you'd be
happy to hear that you can create transactional comma separated values files
according to their API. This little plugin will help you keep track of your
daily efforts in a compact and readable text-only way and then bulk load them
into the system all at once at the end of the day.

## Usage

As of now (first version), it requires a semi-colon separated row of:

1. Date
2. Project
3. Activity
4. Internal hours
5. External hours
    * Can be left blank
6. Comment
    * Can be left blank

Eg: `2017-03-08 ; 9912003 ; 4301 ; 0,25 ; ; Daily agile team meeting`

Put your cursor on the line, or visually select multiple rows, and run
`:Stumble`. The line(s) transforms into Balans syntax in a new split buffer:

`ABCXYZ;9912003;;2017-03-08;2017-03-08;2017-03-08;4301;0,25;0;Daily agile team meeting;Daily agile team meeting;1;;;;;;;`

The buffer will automatically be set to `fileformat=dos` and
`fileencoding=latin1` as to be consistent with the requirements of Balans.

Save the file and load it into Balans.

## Options for ~/.vimrc

### g:stumble_user

`let g:stumble_user = "ABCXYZ"`

This username will be automatically included for every row. Set it to whatever
your login is in the live system. If left empty, the script will prompt you for
a username.

## License

Free as in free beer.
