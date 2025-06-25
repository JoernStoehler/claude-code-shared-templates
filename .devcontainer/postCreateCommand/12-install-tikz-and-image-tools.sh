#!/bin/bash
# ==============================================================================
# 12-install-tikz-and-image-tools.sh
# ==============================================================================
# PURPOSE: Install LaTeX/TikZ and image conversion tools for mathematical diagrams
# 
# DESCRIPTION:
#   Installs LaTeX distribution with TikZ support and various image conversion
#   tools for working with mathematical diagrams and visualizations. This enables
#   creating TikZ diagrams and converting between different image formats.
#
# LATEX/TIKZ PACKAGES INSTALLED:
#   - texlive-latex-base: Core LaTeX system
#   - texlive-latex-extra: Additional packages including TikZ/PGF
#   - texlive-fonts-recommended: Standard fonts
#   - texlive-fonts-extra: Additional fonts for mathematics
#   - texlive-science: Science and math packages
#   - texlive-pictures: Graphics and picture packages
#
# IMAGE CONVERSION TOOLS INSTALLED:
#   - imagemagick: Multi-format image conversion (png↔pdf, jpg↔png, etc.)
#   - inkscape: SVG manipulation and conversion (svg↔png, svg↔pdf)
#   - ghostscript: PostScript/PDF processing (required by ImageMagick)
#   - poppler-utils: PDF utilities (pdftoppm, pdfimages, pdftotext)
#
# COMMON CONVERSION COMMANDS ENABLED:
#   - convert image.png image.pdf  (ImageMagick)
#   - inkscape --export-png=out.png input.svg  (Inkscape)
#   - pdftoppm -png input.pdf output  (Poppler)
#   - pdflatex tikz_diagram.tex  (LaTeX with TikZ)
#
# NOTES:
#   - This is a large installation (~500MB) but provides comprehensive support
#   - TikZ diagrams can be compiled standalone or included in larger documents
#   - Image conversion tools allow easy inspection of TikZ output
# ==============================================================================

set -e

echo "Installing LaTeX/TikZ and image conversion tools..."

# Update package list
sudo apt-get update

# Install LaTeX distribution with TikZ support
echo "Installing LaTeX packages with TikZ support..."
sudo apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-science \
    texlive-pictures

echo "✓ LaTeX/TikZ packages installed"

# Install image conversion tools
echo "Installing image conversion tools..."
sudo apt-get install -y \
    imagemagick \
    inkscape \
    ghostscript \
    poppler-utils

echo "✓ Image conversion tools installed"

# Verify installations
echo "Verifying installations..."

# Check LaTeX
if command -v pdflatex &> /dev/null; then
    echo "  ✓ pdflatex available"
else
    echo "  ✗ pdflatex not found"
fi

# Check ImageMagick
if command -v convert &> /dev/null; then
    echo "  ✓ ImageMagick convert available"
else
    echo "  ✗ ImageMagick convert not found"
fi

# Check Inkscape
if command -v inkscape &> /dev/null; then
    echo "  ✓ Inkscape available"
else
    echo "  ✗ Inkscape not found"
fi

# Check Poppler tools
if command -v pdftoppm &> /dev/null; then
    echo "  ✓ Poppler PDF tools available"
else
    echo "  ✗ Poppler PDF tools not found"
fi

echo ""
echo "✓ LaTeX/TikZ and image conversion tools installation complete!"
echo ""
echo "Available conversion commands:"
echo "  • pdflatex diagram.tex     - Compile TikZ/LaTeX to PDF"
echo "  • convert image.png out.pdf - Convert images (ImageMagick)"
echo "  • inkscape --export-png=out.png input.svg - SVG conversion"
echo "  • pdftoppm -png input.pdf output - PDF to PNG conversion"