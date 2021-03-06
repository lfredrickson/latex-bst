% fredrickson.bst bibliographic style, ver. 1.0. by Laura Fredrickson
%      Based on:
%      Jacque Distler's utphys.bst ver 2.7 
%				(has "eprint" field with hypertex support)
%      alpha.bst's style of labelling and sorting 
%
% For modifying .bst file types, see Part 4 of http://mirrors.concertpass.com/tex-archive/info/bibtex/tamethebeast/ttb_en.pdf, and preceeding chapters which explain that the whole goal of a .bst file is to generate the list .bbl (bibliography items  are \bibitem[ABC17]{label}....) from the file .bib.
%
%The rest of the file is copied from utphys.bst, except where indicated.
%-----------------------
%
% HyperTeX Wizardry:
%
% The following are equivalent:
%   archive  =  arXiv
%   eprint   = "hep-th/9605023"
% and
%   eprint   = "hep-th/9605023"
% both produce 
%
%    \href{http://arxiv.org/abs/hep-th/9605023}{{\ttfamily hep-th/9605023}}
%
% in the bibliographic output at the appropriate point. More generally,
% if the archive field is present, we produce a URL of the form
% "archive/eprint" as the first argument of the \href. If absent, the base
% URL defaults to "http://arxiv.org/abs"
% If you are using a hypertex macropackage, like hyperref.sty, this command
% will create a link to the eprint at Los Alamos (or wherever).
%
% "New-style" arXiv identifiers are also supported.
%
%     archivePrefix = "arXiv",
%     eprint    = "0707.3168",
%     primaryClass = "hep-th",
%
% produces
%
%     \href{http://arxiv.org/abs/0707.3168}{{\ttfamily arXiv:0707.3168 [hep-th]}}
%
% Another (non-arXiv) example:
%
%     archive = "http://cogprints.org",
%     eprint = "5542",
%     archivePrefix = "Cogprints",
%
%  produces
%
%     \href{http://cogprints.org/5542}{{\ttfamily Cogprints:5542}}
%
%  If a
%
%       doi = "10.xxxx"
%
%  field is present, then the journal reference becomes a
%  clickable hyperlink to the online journal version of the paper.
%
% The bibtex output produced by SPIRES, while far from perfect, is pretty
% suitable for use with this style. Indeed, this style was designed with
% SPIRES in mind.


FUNCTION {string.and} {" and "}
FUNCTION {string.editors} {", eds."}
FUNCTION {string.editor} {", ed."}
FUNCTION {string.edition} {"~ed."}
FUNCTION {string.volume} {"vol.~"}
FUNCTION {string.capsvolume} {"Vol.~"}
FUNCTION {string.of} {" of "}
FUNCTION {string.number} {"no.~"}
FUNCTION {string.capsnumber} {"No.~"}
FUNCTION {string.in} {"in "}
FUNCTION {string.spacein} {" in "}
FUNCTION {string.capsin} {"In "}
FUNCTION {string.multipages} {"pp.~"}
FUNCTION {string.pages} {"p.~"}
FUNCTION {string.chapter} {"ch.~"}
FUNCTION {string.techrep} {"Tech. Rep."}
FUNCTION {string.mastersthesis} {"Master's thesis"}
FUNCTION {string.phdthesis} {"PhD thesis"}

%MACRO defines all abbreviations
MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"Mar."}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sept."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}
MACRO {am} {"Acta Math."}
MACRO {amj} {"Am. J. Phys."}
MACRO {ap} {"Ann. Phys."}
MACRO {cmp} {"Comm. Math. Phys."}
MACRO {ijmp} {"Int. Jour. Mod. Phys."}
MACRO {mpl} {"Mod. Phys. Lett."}
MACRO {njp} {"New J. Phys"}
MACRO {nup} {"Nucl. Phys."}
MACRO {pl} {"Phys. Lett."}
MACRO {pla} {"Phys. Lett. A"}
MACRO {pr} {"Phys. Rev."}
MACRO {pra} {"Phys. Rev. A"}
MACRO {prl} {"Phys. Rev. Lett."}
MACRO {repmp} {"Rep. Math. Phys"}
MACRO {rmp} {"Rev. Mod. Phys."}

MACRO {arXiv}     {"http://arxiv.org/abs"}
MACRO {cogprints} {"http://cogprints.org"}
MACRO {pubmed}    {"http://www.ncbi.nlm.nih.gov/pubmed"}

%Entry has three arguments: a list of: fields, integer entry variables, and string variables
%String variables are added from alpha.bst: extra.label, sort.label
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    archive
    eprint
    report
    collaboration
    SLACcitation
    archivePrefix
    primaryClass
    url
    doi
  }
  {}
  { label extra.label sort.label }

%two additional integers than alpha.bst: after.quote, after.quoted.block
INTEGERS { output.state before.all mid.sentence after.quote after.sentence
		after.quoted.block after.block }


FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.quote :=
  #3 'after.sentence :=
  #4 'after.quoted.block :=
  #5 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=                           %we store the first value as s
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.quote =
	{ " " * write$ }
	{ output.state after.block =
	    { add.period$ write$
	      newline$
	      "\newblock " write$
	    }
	    { output.state before.all =
		'write$
		{ output.state after.quoted.block =
		    { write$
		      newline$
		      "\newblock " write$
		    }
		    { add.period$ " " * write$ }
		  if$
		}
	      if$
	    }
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}


FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

%the function "output.bibitem" outputs the label [ABC17] in the file .bbl, and is copied from alpha.bst rather than utphys.bst
FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}


FUNCTION {blank.sep}
{ after.quote 'output.state :=
}

FUNCTION {fin.entry}
{ output.state after.quoted.block =
    'skip$
    'add.period$
  if$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { output.state after.quote =
	{ after.quoted.block 'output.state := }
	{ after.block 'output.state := }
      if$
    }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
	'skip$
	{ after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}


FUNCTION {capitalize}
{ "u" change.case$ "t" change.case$ }

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { numnames #2 >
		{ "," * }
		'skip$
	      if$
	      t "others" =
		{ " {\em et~al.}" * }
		{ string.and * t * }
	      if$
	    }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.archive}
{
  archivePrefix empty$
      { "" }
      { archivePrefix ":" *}
  if$            
}

FUNCTION {format.primaryClass}
{
  primaryClass empty$
      { "" }
      { " [" primaryClass * "]" *}
  if$            
}

FUNCTION {format.eprint}
{ eprint empty$
     { ""}
     { archive empty$
          {"\href{http://arxiv.org/abs/" eprint * "}" * 
             "{{\ttfamily " * format.archive * eprint *
               "}}" *}
          {"\href{" archive *  "/" * eprint * "}" * 
             "{{\ttfamily " * format.archive * eprint *
              format.primaryClass * "}}" *}
       if$
     }
     if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    {"\url{" url * "}" *}
  if$
}

FUNCTION {add.doi}
{ duplicate$ empty$
    { skip$ }
    { doi empty$
        {}
        {"\href{http://dx.doi.org/" doi * "}{" * swap$ * "}" *}
      if$
    }
  if$
}

FUNCTION {format.report}
{ report empty$
     { ""}
     { report}
     if$
}

FUNCTION {format.howpublished}
{ howpublished empty$
    { "" }
    { howpublished capitalize
    }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
	{ string.editors * }
	{ string.editor * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { "``" title "t" change.case$ * ",''" * }
  if$
}

FUNCTION {format.title.p}
{ title empty$
    { "" }
    { "``" title "t" change.case$ * ".''" * }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
	{ t #1 #2 substring$ "--" = not
	    { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    {   { t #1 #1 substring$ "-" = }
		{ "-" *
		  t #2 global.max$ substring$ 't :=
		}
	      while$
	    }
	  if$
	}
	{ t #1 #1 substring$ *
	  t #2 global.max$ substring$ 't :=
	}
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
	{ "" }
	{ "there's a month but no year in " cite$ * warning$
	  month
	}
      if$
    }
    { month empty$
	'year
	{ month capitalize ", " * year * }
      if$
    }
  if$
}

FUNCTION {format.date.paren}
{ year empty$
    { month empty$
	{ "" }
	{ "there's a month but no year in " cite$ * warning$
	  month
	}
      if$
    }
    { month empty$
	{"(" year * ") " *}
	{"(" month capitalize * ", " * year * ") " *}
      if$
    }
  if$
}

FUNCTION {format.collaboration}
{ collaboration empty$
    { "" }
    { "{\bfseries " collaboration * "} " * "Collaboration" * }
  if$
}

FUNCTION {format.SLACcitation}
{ SLACcitation empty$
  {""}
   { newline$ SLACcitation output "" newline$ }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { string.volume volume *
      series empty$
	'skip$
	{ string.of * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
	{ series field.or.null }
	{ output.state mid.sentence =
	    { string.number }
	    { string.capsnumber }
	  if$
	  number *
	  series empty$
	    { "there's a number but no series in " cite$ * warning$ }
	    { string.spacein * series * }
	  if$
	}
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition "l" change.case$ string.edition * }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
	{ #1 'multiresult := }
	{ t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
	{ string.multipages pages n.dashify * }
	{ string.pages pages * }
      if$
    }
  if$
}

FUNCTION {format.pages.nopp}
{ pages empty$
    { "empty pages in " cite$ * warning$
      ""
    }
    { pages multi.page.check
	{ pages n.dashify  }
	{ pages }
      if$
    }
  if$
}


FUNCTION {format.volume}
{ volume empty$
    { "" }
    { "{\bfseries " volume * "} " * }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { "no.~" number * ", " *}
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
	{ string.chapter chapter * }
	{ type "l" change.case$ chapter tie.or.space.connect }
      if$
      pages empty$
	'skip$
	{ ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { string.in booktitle emphasize *
      editor empty$
	'skip$
	{ ", " * format.editors *  }
      if$
    }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      output.state after.block =
	{ type "t" change.case$ }
	{ type "l" change.case$ }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { string.techrep }
    'type
  if$
  number empty$
    { "l" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.paddress}
{ address empty$
    { "" }
    { "(" address * ")" * }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
	{ "need key or journal for " cite$ * " to crossref " * crossref *
	  warning$
	  ""
	}
	{ string.in "{\em " * journal * "\/}" * }
      if$
    }
    { string.in key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " {\em et~al.}" * }
    { #2 <
	'skip$
	{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
	    { " {\em et~al.}" * }
	    { string.and * editor #2 "{vv~}{ll}" format.name$ * }
	  if$
	}
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      string.capsin
    }
    { string.capsvolume volume *
      string.of *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ series empty$
	    { "need editor, key, or series for " cite$ * " to crossref " *
	      crossref * warning$
	      "" *
	    }
	    { "{\em " * series * "\/}" * }
	  if$
	}
	{ key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ booktitle empty$
	    { "need editor, key, or booktitle for " cite$ * " to crossref " *
	      crossref * warning$
	      ""
	    }
	    { string.in "{\em " * booktitle * "\/}" * }
	  if$
	}
	{ string.in key * }
      if$
    }
    { string.in format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.journal}
{ journal missing$   
    { "" }
    {journal emphasize " " *
     format.volume *
     format.number *
     format.date.paren *
     format.pages.nopp *
      }
    if$
}


FUNCTION {article}
{ output.bibitem
  format.collaboration output
  format.authors "author" output.check
  format.title "title" output.check
  blank.sep
  crossref missing$
  { journal missing$   
        { format.date.paren *}
        { format.journal add.doi "journal" output.check}
      if$
    report missing$
        {format.eprint output}
        {blank.sep format.report output format.eprint output}
      if$
    }
    { format.article.crossref output.nonnull
      format.pages output
      format.eprint output
    }
  if$
  new.sentence
  format.url output
  new.sentence
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.collaboration output
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  format.btitle add.doi "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.collaboration output
  format.authors output
  title empty$
    { "empty title in " cite$ * warning$
      howpublished new.sentence.checka
    }
    { howpublished empty$ not
      address empty$ month empty$ year empty$ and and
      or
	{ format.title.p output.nonnull }
	{ format.title output.nonnull }
      if$
      blank.sep
    }
  if$
  format.howpublished output
  address output
  format.date output
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  format.collaboration output
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages add.doi "chapter and pages" output.check
      new.block
      format.number.series output
      new.block
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages add.doi "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.collaboration output
  format.authors "author" output.check
  format.title add.doi "title" output.check
  blank.sep
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.block
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.collaboration output
  format.authors "author" output.check
  format.title add.doi "title" output.check
  blank.sep
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      organization output
      new.block
      publisher output
      address output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.collaboration output
  author empty$
    { organization empty$
	'skip$
	{ organization output.nonnull
	  address output
	}
      if$
    }
    { format.authors output.nonnull }
  if$
  format.btitle "title" output.check
  author empty$
    { organization empty$
	{ address new.block.checka
	  address output
	}
	'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  format.title add.doi "title" output.check
  blank.sep
  string.mastersthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.collaboration output
  format.authors output
  title empty$
    { howpublished new.sentence.checka }
    { howpublished empty$ not
      month empty$ year empty$ and
      or
	{ format.title.p output.nonnull }
	{ format.title output.nonnull }
      if$
      blank.sep
    }
  if$
  format.howpublished output
  format.date output
  new.block
  format.url output
  new.sentence
  note output
  new.sentence
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  format.btitle add.doi "title" output.check
  new.block
  string.phdthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  format.btitle add.doi "title" output.check
  format.bvolume output
  format.number.series output
  editor empty$
    'skip$
    { organization output }
  if$
  new.block
  publisher output
  address output
  format.date "year" output.check
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.collaboration output
  format.authors "author" output.check
  format.title add.doi "title" output.check
  blank.sep
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  new.block
  format.eprint output
  new.block
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.collaboration output
  format.authors "author" output.check
  format.title.p "title" output.check
  blank.sep
  note "note" output.check
  format.date output
  new.sentence
  format.SLACcitation output
  fin.entry
}

FUNCTION {default.type} { misc }



%reads the .bib file; matches alpha.bst from here to the end
READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=      
  'len :=   

  s #1 len substring$ = 
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { et.al.char.used }


FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}


EXECUTE {initialize.et.al.char.used}

FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 >
    { numnames #4 >
        { #3 'namesleft := }
        { numnames 'namesleft := }
      if$
      #1 'nameptr :=
      ""
        { namesleft #0 > }
        { nameptr numnames =
            { s nameptr "{ff }{vv }{ll}{ jj}" format.name$ "others" =
                { "{\etalchar{+}}" *
                  #1 'et.al.char.used :=
                }
                { s nameptr "{v{}}{l{}}" format.name$ * }
              if$
            }
            { s nameptr "{v{}}{l{}}" format.name$ * }
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
      numnames #4 >
        { "{\etalchar{+}}" *
          #1 'et.al.char.used :=
        }
        'skip$
      if$
    }
    { s #1 "{v{}}{l{}}" format.name$
      duplicate$ text.length$ #2 <
        { pop$ s #1 "{ll}" format.name$ #3 text.prefix$ }
        'skip$
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            { key #3 text.prefix$ }
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or 
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "manual" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  duplicate$
  year field.or.null purify$ #-1 #2 substring$
  *
  'label :=
  year field.or.null purify$ #-1 #4 substring$
  *
  sortify 'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
  sort.label
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  *
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
%This is where the string variable sort.key$ is defined.  The biblography is sorted according to it.
}
 
ITERATE {presort}

%Sorts the entry list using the values of the string entry variable sort.key$
SORT

STRINGS { longest.label last.sort.label next.extra }

INTEGERS { longest.label.width last.extra.num }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  extra.label 'next.extra :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{$^{#1}$}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

% "ITERATE{call.type$} produces the output for the entries. 
ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
