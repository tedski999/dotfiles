inoremap \main int main(int argc, char **argv) {<cr><cr>return 0;<cr>}<c-o>2k<c-f>
inoremap \head #ifndef <c-o>m`<c-r>=toupper(expand('%:t:r'))<cr>_H<cr>#define <c-r>=toupper(expand('%:t:r'))<cr>_H<cr><cr><cr><cr>#endif<esc>``<c-v>$j
inoremap \inc #include "<c-r>=expand('%:t:r')<cr>.h"<esc>vF"o
inoremap \if if (<esc>m`acondition) {<cr>} else if (condition) {<cr>} else {<cr>}<esc>``lvt)
inoremap \for for (int i = 0; i < <esc>m`alength; i++) {<cr>}<esc>``lvt;
inoremap \wh while (<esc>m`acondition) {<cr>}<esc>``lvt)
inoremap \do do {<cr>} while (<esc>m`acondition);<esc>``lvt)
inoremap \swi switch (<esc>m`aexpression) {<cr>case value:<cr>break;<cr>default:<cr>break;<cr>}<esc>``lvt)
inoremap \mal malloc(sizeof *buffer * buffer_len);<esc>2hvF2*o
inoremap \gpl /*<cr><c-o>m`<program name and description><cr>Copyright (C) <c-r>=strftime('%Y')<cr> Ted Johnson <tedjohnsonjs@gmail.com><cr><cr>This program is free software: you can redistribute it and/or modify<cr>it under the terms of the GNU General Public License as published by<cr>the Free Software Foundation, either version 3 of the License, or<cr>(at your option) any later version.<cr><cr>This program is distributed in the hope that it will be useful,<cr>but WITHOUT ANY WARRANTY; without even the implied warranty of<cr>MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the<cr>GNU General Public License for more details.<cr><cr>You should have received a copy of the GNU General Public License<cr>along with this program.  If not, see <http://www.gnu.org/licenses/>.<cr><bs>/<esc>``vf>
inoremap \mit /*<cr><c-o>m`<program name and description><cr>Copyright (C) <c-r>=strftime('%Y')<cr> Ted Johnson <tedjohnsonjs@gmail.com><cr><cr>Permission is hereby granted, free of charge, to any person obtaining a copy<cr>of this software and associated documentation files (the "Software"), to deal<cr>in the Software without restriction, including without limitation the rights<cr>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell<cr>copies of the Software, and to permit persons to whom the Software is<cr>furnished to do so, subject to the following conditions:<cr><cr>The above copyright notice and this permission notice shall be included in<cr>all copies or substantial portions of the Software.<cr><cr>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<cr>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<cr>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<cr>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<cr>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,<cr>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE<cr>SOFTWARE.<cr><bs>/<esc>``vf>
