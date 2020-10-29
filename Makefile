PDFLATEX = xelatex
BIBTEX = bibtex
OTT = ott

OTT_FLAGS_WRAP := -tex_show_meta false -picky_multiple_parses false
OTT_FLAGS_NO_WRAP := -tex_wrap false -tex_show_meta false -picky_multiple_parses false
OTT_FLAGS := $(OTT_FLAGS_NO_WRAP)

# Name of the note:
Name := paper
# Name of the language (ott spec name):
OTTPrefix := spec
TexFileName := $(Name)
OTTFileName := $(OTTPrefix)
OTTFile := $(OTTFileName).ott
OTTGen := $(OTTFileName)-inc.tex
OTTOutputFile := $(TexFileName)-ottput.tex

PDF := $(TexFileName).pdf

OTT_FILES = introduction.tex	    

FILES := abstract.tex \
	 $(Name).tex \
	 Makefile

OTT_TARGETS := $(subst .tex,-ottput.tex,$(OTT_FILES))
OTT_FILTER := $(subst .tex,.tex ,$(addprefix -tex_filter ,$(join $(OTT_FILES), $(OTT_TARGETS))))

all : $(PDF)

$(OTTGen) : $(OTTFile)
	$(OTT) -i $(OTTFile) -o $(OTTGen) $(OTT_FLAGS)

$(OTT_TARGETS) : $(OTT_FILES) $(OTTGen) 
	$(OTT) -i $(OTTFile) $(OTT_FLAGS) $(OTT_FILTER)

$(PDF) : $(FILES) $(OTT_TARGETS)
	$(PDFLATEX) -jobname=$(Name) $(Name).tex

clean :
	rm -f *.aux *.dvi *.ps *.log *-ott.tex *-output.tex *.bbl *.blg \
	      *.rel note.pdf *~ *.vtc *.out *.spl *-inc.tex  *-ott.tex *-ottput.tex
