PLATEX = platex
DVIPDFMX = dvipdfmx

TARGET = document
OUTPUT_DIR = build
BUILDED_TARGET = $(OUTPUT_DIR)/$(TARGET)

all: $(BUILDED_TARGET).dvi

pdf: $(BUILDED_TARGET).pdf

git:
	if [ ! -e constitution  -a ! -e tex-commands ]; then tools/clone_modules.sh; fi

$(BUILDED_TARGET).dvi: $(TARGET).tex git
	mkdir -p $(OUTPUT_DIR)
	tools/auto_input.sh
	$(PLATEX) -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) $(TARGET).tex
	$(PLATEX) -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) $(TARGET).tex

$(BUILDED_TARGET).pdf: $(BUILDED_TARGET).dvi
	$(DVIPDFMX) -o $(BUILDED_TARGET).pdf $(BUILDED_TARGET).dvi

allclean: clean
	cd $(OUTPUT_DIR) && rm -rf $(TARGET).pdf

clean:
	cd $(OUTPUT_DIR) && rm -rf *.dvi *.log *.aux *.toc

