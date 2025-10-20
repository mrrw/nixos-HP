.TL
Title of your groff document
.AU
Your name
.AI
Your institution
.AB
This is an abstract.
.AE
.SH
Section heading is unnumbered
.PP
This is an indented paragraph.
.NH
Numbered section heading on the first level
.NH 2
Numbered subsection heading at the second level
.PP
Put the following words in quotation marks and on their own line to appear as
.B "bold text"
in this sentence. Mind you, this will all be on the same line. Do this to have
.B "bold text in parenthesis" ) (
look like this. The bold function is taking in the three arguments as explained above. Here
.I "italic text"
will continue the paragraph, just keep writing on the next line. If you want to
.UL "underline text" ,
and get the comma right after the quotation marks, you have to insert it as a second argument.
.BX "This text is boxed"
and the logic works the same for all functions when formatting in groff.
.IP \(bu 2
This is a properly formatted list item
.IP \(bu 2
Make sure that you add list items this way so they appear indented with bullet points
