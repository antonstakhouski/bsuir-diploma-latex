ifeq ($(OS),Windows_NT)
	SHELL=%WINDIR%/cmd.exe
	DROPBOX_PUBLIC=$(USERPROFILE)/Dropbox/Public
else
	SHELL=/usr/bin/env sh
	DROPBOX_PUBLIC=$(HOME)/Dropbox/Public
endif
#XELATEX = xelatex
XELATEX = lualatex --shell-escape
#XELATEX = lualatex
#XELATEX = pdflatex
DIPLOMA_REPORT_PDF = diploma_report
PRACTICE_REPORT_PDF = practice_report
ECONOMICS_REPORT_PDF = economics_report
FEEDBACK_REPORT_PDF = feedback_report
SPEECH_REPORT_PDF = speech_report
REVIEW_REPORT_PDF = review_report
COURSE_REPORT_PDF = course_report
TITLE_PDF = diploma_title_only
TASK_PDF = diploma_task_only
PRESENTATION_PDF = presentation
SHORT_SPEECH_PDF = short_speech
BIBTEX = bibtex
RM = rm -f
GREP = grep


#all: $(DIPLOMA_REPORT_PDF).pdf $(PRACTICE_REPORT_PDF).pdf $(TITLE_PDF).pdf $(TASK_PDF).pdf
#all: $(DIPLOMA_REPORT_PDF).pdf
#all: $(SPEECH_REPORT_PDF).pdf
#all: $(PRESENTATION_PDF).pdf
all: $(SHORT_SPEECH_PDF).pdf


publish_to_dropbox: all
	cp $(DIPLOMA_REPORT_PDF).pdf $(DROPBOX_PUBLIC)/$(DIPLOMA_REPORT_PDF).pdf
	cp $(PRACTICE_REPORT_PDF).pdf $(DROPBOX_PUBLIC)/$(PRACTICE_REPORT_PDF).pdf

fast: *.tex
	latexmk -pdf -pdflatex="pdflatex" $(DIPLOMA_REPORT_PDF)
	mv $(DIPLOMA_REPORT_PDF).pdf $(DIPLOMA_REPORT_PDF)-`date +'%m-%d-%H-%M-%S'`.pdf

fastcheck: *.tex
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	$(BIBTEX) $(DIPLOMA_REPORT_PDF).aux
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	mv $(DIPLOMA_REPORT_PDF).pdf $(DIPLOMA_REPORT_PDF)-`date +'%m-%d-%H-%M-%S'`.pdf

$(DIPLOMA_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	$(BIBTEX) $(DIPLOMA_REPORT_PDF).aux
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	$(XELATEX) $(DIPLOMA_REPORT_PDF)
	#cp $(DIPLOMA_REPORT_PDF).pdf ../example_diploma.pdf

$(FEEDBACK_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(FEEDBACK_REPORT_PDF)

$(PRESENTATION_PDF).pdf: *.tex
	$(XELATEX) $(PRESENTATION_PDF)

$(SPEECH_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(SPEECH_REPORT_PDF)

$(SHORT_SPEECH_PDF).pdf: *.tex
	$(XELATEX) $(SHORT_SPEECH_PDF)

$(REVIEW_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(REVIEW_REPORT_PDF)

$(ECONOMICS_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(ECONOMICS_REPORT_PDF)
	$(BIBTEX) $(ECONOMICS_REPORT_PDF).aux
	$(XELATEX) $(ECONOMICS_REPORT_PDF)
	$(XELATEX) $(ECONOMICS_REPORT_PDF)

$(PRACTICE_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(PRACTICE_REPORT_PDF)
	$(BIBTEX) $(PRACTICE_REPORT_PDF).aux
	$(XELATEX) $(PRACTICE_REPORT_PDF)
	$(XELATEX) $(PRACTICE_REPORT_PDF)
	cp $(PRACTICE_REPORT_PDF).pdf ../example_practice.pdf


$(COURSE_REPORT_PDF).pdf: *.tex
	$(XELATEX) $(COURSE_REPORT_PDF)
	$(BIBTEX) $(COURSE_REPORT_PDF).aux
	$(XELATEX) $(COURSE_REPORT_PDF)
	$(XELATEX) $(COURSE_REPORT_PDF)
	cp $(COURSE_REPORT_PDF).pdf ../example_course_project.pdf

$(TITLE_PDF).pdf: *.tex
	$(XELATEX) $(TITLE_PDF)

$(TASK_PDF).pdf: *.tex
	$(XELATEX) $(TASK_PDF)


cleanall: clean
	$(RM)  *.pdf

.PHONY: clean
clean:
	$(RM) *.aux *.log *.out *.toc *.gz *.gz\(busy\) *.blg *.bbl $(DIPLOMA_REPORT_PDF).pdf $(TASK_PDF).pdf $(TITLE_PDF).pdf $(PRACTICE_REPORT_PDF).pdf $(COURSE_REPORT_PDF).pdf

