# vim-stumble

If you are you using the Swedish Balans time registration system, you'd be
happy to hear that you can create transactional comma separated values files
according to their API. This little plugin will help you keep track of your
daily efforts in a compact and readable text-only way and then bulk load them
into the system all at once at the end of the day.

## Usage

As of now (first version), it requires a TAB separated row of four values:

1. Project
2. Activity
3. Hours
4. Comment

Eg: `99300<TAB>4301<TAB>0,25<TAB>Daily agile team meeting`

Put your cursor on the line and run `:Stumble`. Hot-key the command
if you like. The line transforms into Balans syntax:

`ABCXYZ;;99300;2017-03-01;2017-03-01;2017-03-01;4301;0,25;0,25;Daily agile team meeting;Daily agile team meeting;1;;;;;`

Save the file in ASCII and with CRLF line endings.

## Options for ~/.vimrc

### g:stumble_user

`let g:stumble_user = "ABCXYZ"`

This username will be automatically included for every row. Set it to whatever
your login is in the live system.

## License

Free as in free beer.
