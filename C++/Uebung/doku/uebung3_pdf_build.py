from pathlib import Path
from collections import Counter
import re
import math
import html
import json

from markdown_it import MarkdownIt
from pygments import lex
from pygments.lexers import CppLexer
from pygments.token import Token
from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.platypus import (
    BaseDocTemplate, PageTemplate, Frame, Paragraph, Spacer, PageBreak,
    Flowable, Table, TableStyle, KeepTogether, CondPageBreak,
)
from reportlab.platypus.tableofcontents import TableOfContents

ROOT = Path('/home/klemens/Desktop/FHVault_Git/ObsiGit/C++/Uebung/doku')
SOURCE = ROOT / 'Übung_3_optimized.md'
OUT = ROOT / 'output/pdf/Übung_3_optimized.pdf'
TMP = Path('/tmp/uebung3-pdf/tmp/pdfs')
OUT.parent.mkdir(parents=True, exist_ok=True)
TMP.mkdir(parents=True, exist_ok=True)

W, H = A4
LEFT = RIGHT = 49
TOP, BOTTOM = 53, 50
CW = W - LEFT - RIGHT
NAVY = colors.HexColor('#152C40')
TEAL = colors.HexColor('#087F8C')
INK = colors.HexColor('#263B49')
MUTED = colors.HexColor('#617582')
LINE = colors.HexColor('#DCE5EA')
PALE = colors.HexColor('#F2F6F8')

for name, filename in [
    ('Lato', 'Lato-Regular.ttf'), ('LatoB', 'Lato-Bold.ttf'),
    ('LatoI', 'Lato-Italic.ttf'), ('LatoBI', 'Lato-BoldItalic.ttf'),
]:
    pdfmetrics.registerFont(TTFont(name, '/usr/share/fonts/truetype/lato/' + filename))
pdfmetrics.registerFontFamily('Lato', normal='Lato', bold='LatoB', italic='LatoI', boldItalic='LatoBI')
pdfmetrics.registerFont(TTFont('Mono', '/usr/share/fonts/truetype/firacode/FiraCode-Regular.ttf'))
pdfmetrics.registerFont(TTFont('MonoB', '/usr/share/fonts/truetype/firacode/FiraCode-Bold.ttf'))
pdfmetrics.registerFontFamily('Mono', normal='Mono', bold='MonoB', italic='Mono', boldItalic='MonoB')
pdfmetrics.registerFont(TTFont('Math', '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'))

styles = {}
def style(name, **kwargs):
    base = dict(fontName='Lato', fontSize=10.2, leading=14.9, textColor=INK,
                spaceAfter=8, allowWidows=0, allowOrphans=0, splitLongWords=1)
    base.update(kwargs)
    styles[name] = ParagraphStyle(name, **base)
    return styles[name]

style('body')
style('small', fontSize=9.2, leading=13.1)
style('h2', fontName='LatoB', fontSize=23, leading=28, textColor=NAVY,
      spaceAfter=18, keepWithNext=1)
style('h3', fontName='LatoB', fontSize=13, leading=17, textColor=NAVY,
      spaceBefore=13, spaceAfter=7, keepWithNext=1)
style('list', leftIndent=15, firstLineIndent=0, bulletIndent=0,
      bulletFontName='LatoB', bulletFontSize=9, spaceAfter=5)
style('cell', fontSize=9.2, leading=12.9, spaceAfter=0)
style('th', fontName='LatoB', fontSize=9.2, leading=12.9,
      textColor=colors.white, spaceAfter=0)
style('box', fontSize=9.8, leading=14.2, spaceAfter=5)
style('box_title', fontName='LatoB', fontSize=10, leading=14, spaceAfter=0)
style('toc', fontSize=11, leading=17, spaceBefore=0, spaceAfter=11,
      textColor=NAVY, leftIndent=0, firstLineIndent=0)

md = MarkdownIt('commonmark').enable('table')
def normal(text):
    return text.replace('\u2013', '-').replace('\u2014', '-').replace('\u2011', '-')

def esc(text):
    return html.escape(normal(text), quote=False)

def render_inline(tokens):
    out = []
    links = []
    for tok in tokens or []:
        if tok.type == 'text':
            txt = re.sub(r'\[\[([^\]|]+)(?:\|([^\]]+))?\]\]', lambda m: m.group(2) or m.group(1), tok.content)
            out.append(esc(txt))
        elif tok.type == 'code_inline':
            out.append('<font name="Mono" size="8.6" color="#175D69">' + esc(tok.content) + '</font>')
        elif tok.type == 'strong_open': out.append('<b>')
        elif tok.type == 'strong_close': out.append('</b>')
        elif tok.type == 'em_open': out.append('<i>')
        elif tok.type == 'em_close': out.append('</i>')
        elif tok.type in ('softbreak', 'hardbreak'): out.append(' ' if tok.type == 'softbreak' else '<br/>')
        elif tok.type == 'link_open':
            href = tok.attrGet('href') or ''
            active = href.startswith(('https://', 'http://'))
            links.append(active)
            if active: out.append('<a href="' + html.escape(href, quote=True) + '" color="#087F8C">')
        elif tok.type == 'link_close':
            if links.pop(): out.append('</a>')
        else:
            raise ValueError(f'Unhandled inline token: {tok.type}')
    return ''.join(out)

def rich(text):
    toks = md.parseInline(text)
    return render_inline(toks[0].children)

def para(text, kind='body', **kw):
    return Paragraph(rich(text), styles[kind], **kw)

class Chapter(Paragraph):
    def __init__(self, title):
        self.heading_text = normal(title)
        match = re.match(r'(\d+)\. (.*)', self.heading_text)
        self.number, label = match.groups()
        self.key = 'chapter-' + self.number
        super().__init__(f'<font color="#087F8C" size="11">KAPITEL {self.number.zfill(2)}</font><br/>{esc(label)}', styles['h2'])

class CodeBlock(Flowable):
    FONT = 8.5
    LEADING = 11.25
    def __init__(self, code=None, lines=None, start=1, continuation=False, full=False):
        Flowable.__init__(self)
        self.start = start
        self.continuation = continuation
        self.full = full or (code is not None and 'int main()' in code)
        self.lines = lines if lines is not None else self.tokenize(code.rstrip('\n'))
        self.spaceBefore = 4
        self.spaceAfter = 12
    @staticmethod
    def token_color(token):
        if token in Token.Comment: return '#617C6B'
        if token in Token.Keyword: return '#674199'
        if token in Token.Literal.String: return '#A34F2B'
        if token in Token.Literal.Number: return '#A34F2B'
        if token in Token.Name.Builtin or token in Token.Name.Class: return '#087F8C'
        if token in Token.Comment.Preproc: return '#087F8C'
        return '#243B4C'
    def tokenize(self, text):
        lines = [[]]
        for token, value in lex(text, CppLexer()):
            pieces = value.split('\n')
            for i, piece in enumerate(pieces):
                if piece: lines[-1].append((piece, self.token_color(token)))
                if i != len(pieces)-1: lines.append([])
        if lines and not lines[-1]: lines.pop()
        return lines
    def wrap(self, width, height):
        self.width = width
        self.height = 29 + len(self.lines) * self.LEADING + 10
        for line in self.lines:
            line_width = sum(pdfmetrics.stringWidth(v, 'Mono', self.FONT) for v, c in line)
            assert line_width <= width - 54, (line_width, width)
        return self.width, self.height
    def split(self, width, height):
        count = int((height - 39) // self.LEADING)
        if count < 7: return []
        if count >= len(self.lines): return [self]
        # Prefer a blank line near the available boundary; keep useful continuations.
        if len(self.lines)-count < 5: count = len(self.lines)-5
        for candidate in range(count, max(7, count-6), -1):
            if not self.lines[candidate-1]:
                count = candidate
                break
        if count < 7: return []
        return [CodeBlock(lines=self.lines[:count], start=self.start,
                          continuation=self.continuation, full=self.full),
                CodeBlock(lines=self.lines[count:], start=self.start+count,
                          continuation=True, full=self.full)]
    def draw(self):
        c = self.canv
        c.setFillColor(PALE)
        c.roundRect(0, 0, self.width, self.height, 6, stroke=0, fill=1)
        c.setFillColor(colors.HexColor('#E6EEF1'))
        c.roundRect(0, self.height-25, self.width, 25, 6, stroke=0, fill=1)
        c.rect(0, self.height-25, self.width, 12, stroke=0, fill=1)
        c.setFillColor(TEAL)
        c.setFont('LatoB', 8)
        c.drawString(12, self.height-16, 'C++')
        c.setFillColor(MUTED)
        c.setFont('Lato', 7.8)
        label = 'VOLLSTÄNDIGES BEISPIEL' if self.full else 'CODEAUSSCHNITT'
        if self.continuation: label += ' / FORTSETZUNG'
        c.drawRightString(self.width-12, self.height-16, label)
        y = self.height-38
        for n, line in enumerate(self.lines, self.start):
            c.setFillColor(colors.HexColor('#91A2AD'))
            c.setFont('Mono', 7)
            c.drawRightString(27, y, str(n))
            x = 39
            for val, color in line:
                c.setFillColor(colors.HexColor(color))
                c.setFont('Mono', self.FONT)
                c.drawString(x, y, val)
                x += pdfmetrics.stringWidth(val, 'Mono', self.FONT)
            y -= self.LEADING

class Equation(Flowable):
    def __init__(self, text):
        Flowable.__init__(self)
        self.text = text
        self.spaceAfter = 12
        self.height = 57
    def wrap(self, w, h):
        self.width=w
        return w, self.height
    def draw(self):
        c=self.canv
        c.setFillColor(colors.HexColor('#F0F7F8'))
        c.roundRect(0, 0, self.width, self.height, 6, stroke=0, fill=1)
        c.setFillColor(NAVY)
        c.setStrokeColor(NAVY)
        c.setLineWidth(.7)
        def txt(value, x, y=24):
            c.setFont('LatoI', 13)
            c.drawString(x, y, value)
        def fraction(top, bottom, x, width):
            c.setFont('LatoI', 12)
            c.drawCentredString(x+width/2, 36, top)
            c.line(x, 30, x+width, 30)
            c.drawCentredString(x+width/2, 13, bottom)
        if self.text.startswith('r ='):
            x=(self.width-180)/2
            txt('r =', x)
            fraction('n', 'd', x+34, 21)
            txt(',     d', x+66)
            c.setFont('Math', 13)
            c.drawString(x+104, 24, '≠')
            txt('0', x+124)
        else:
            x=(self.width-300)/2
            fraction('a', 'b', x, 25)
            txt('+', x+39)
            fraction('c', 'd', x+62, 25)
            txt('=', x+102)
            fraction('a · d + c · b', 'b · d', x+129, 125)

BOX_COLORS = {
    'warning': ('#A96C16', '#FFF7E8'),
    'important': ('#68539A', '#F4F1F9'),
    'success': ('#237B63', '#EEF7F2'),
    'summary': ('#087F8C', '#EEF7F8'),
    'tip': ('#087F8C', '#EEF7F8'),
    'abstract': ('#087F8C', '#EEF7F8'),
    'note': ('#426D8D', '#F0F5FA'),
    'info': ('#426D8D', '#F0F5FA'),
}

def make_box(content):
    lines = content.strip().splitlines()
    match = re.match(r'\[!(\w+)\][-+]?\s*(.*)', lines[0])
    if match:
        kind, title = match.groups()
        body = '\n'.join(lines[1:]).strip()
    else:
        kind, title, body = 'note', 'Hinweis', content
    accent, background = BOX_COLORS.get(kind, BOX_COLORS['note'])
    body_items = parse_body(md.parse(body), in_box=True)
    rows = [[Paragraph('<font color="'+accent+'">'+esc(title)+'</font>', styles['box_title'])]]
    for item in body_items:
        rows.append([item])
    t = Table(rows, colWidths=[CW], repeatRows=1, hAlign='LEFT', spaceBefore=5, spaceAfter=12)
    t.setStyle(TableStyle([
        ('BACKGROUND',(0,0),(-1,-1),colors.HexColor(background)),
        ('LINEBEFORE',(0,0),(0,-1),2.5,colors.HexColor(accent)),
        ('LEFTPADDING',(0,0),(-1,-1),13), ('RIGHTPADDING',(0,0),(-1,-1),13),
        ('TOPPADDING',(0,0),(-1,0),10), ('BOTTOMPADDING',(0,0),(-1,0),5),
        ('TOPPADDING',(0,1),(-1,-1),0), ('BOTTOMPADDING',(0,1),(-1,-1),7),
        ('BOTTOMPADDING',(0,-1),(-1,-1),10),
        ('VALIGN',(0,0),(-1,-1),'TOP'),
    ]))
    return t

def make_table(tokens):
    rows, row, header = [], [], False
    for tok in tokens:
        if tok.type=='thead_open': header=True
        elif tok.type=='thead_close': header=False
        elif tok.type=='tr_open': row=[]
        elif tok.type=='inline':
            cell_text=render_inline(tok.children)
            if header:
                cell_text=cell_text.replace('color="#175D69"','color="#C8F2F3"')
            row.append(Paragraph(cell_text, styles['th' if header else 'cell']))
        elif tok.type=='tr_close': rows.append(row)
    n=len(rows[0])
    ratios={2:[.32,.68],3:[.30,.35,.35],4:[.22,.30,.32,.16]}[n]
    t=Table(rows,colWidths=[CW*r for r in ratios],repeatRows=1,hAlign='LEFT',spaceBefore=4,spaceAfter=13)
    t.setStyle(TableStyle([
        ('BACKGROUND',(0,0),(-1,0),NAVY),
        ('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.white,PALE]),
        ('LINEBELOW',(0,0),(-1,0),.5,NAVY),
        ('LINEBELOW',(0,1),(-1,-1),.4,LINE),
        ('LEFTPADDING',(0,0),(-1,-1),9),('RIGHTPADDING',(0,0),(-1,-1),9),
        ('TOPPADDING',(0,0),(-1,-1),8),('BOTTOMPADDING',(0,0),(-1,-1),8),
        ('VALIGN',(0,0),(-1,-1),'TOP'),
    ]))
    return t

def matching(tokens, start, open_type, close_type):
    depth=0
    for j in range(start,len(tokens)):
        if tokens[j].type==open_type: depth+=1
        if tokens[j].type==close_type:
            depth-=1
            if depth==0: return j
    raise ValueError(open_type)

def parse_body(tokens, in_box=False):
    out=[]
    i=0
    while i<len(tokens):
        t=tokens[i]
        if t.type=='heading_open':
            content=tokens[i+1].content
            if t.tag=='h2':
                number=int(content.split('.')[0])
                if number in (1,7,12,13):
                    out.append(PageBreak())
                else:
                    out.extend([CondPageBreak(300),Spacer(1,20)])
                out.append(Chapter(content))
            elif t.tag=='h3':
                p=para(content,'h3')
                p.subheading=normal(content)
                out.append(p)
            i+=3
        elif t.type=='paragraph_open':
            inline=tokens[i+1]
            if inline.content.startswith('$$'):
                out.append(Equation(inline.content.strip('$\n ')))
            else:
                p=Paragraph(render_inline(inline.children),styles['box' if in_box else 'body'])
                following=tokens[i+3] if i+3<len(tokens) else None
                long_example=(following is not None and following.type=='fence'
                              and len(following.content.splitlines())>35)
                if inline.content.endswith(':') and not long_example:
                    p.keepWithNext=True
                out.append(p)
            i+=3
        elif t.type=='fence':
            out.append(CodeBlock(code=t.content))
            i+=1
        elif t.type=='blockquote_open':
            end=matching(tokens,i,'blockquote_open','blockquote_close')
            # Using the source lines keeps Obsidian callout markers and list structure intact.
            block='\n'.join(re.sub(r'^> ?', '', line) for line in source_lines[t.map[0]:t.map[1]])
            if block.startswith('[!success]- Lösungen'):
                out.extend([Notes(),PageBreak(),para('Lösungen und Merksätze','h2')])
            out.append(make_box(block))
            i=end+1
        elif t.type=='table_open':
            end=matching(tokens,i,'table_open','table_close')
            out.append(make_table(tokens[i:end+1]))
            i=end+1
        elif t.type in ('bullet_list_open','ordered_list_open'):
            close='bullet_list_close' if t.type=='bullet_list_open' else 'ordered_list_close'
            end=matching(tokens,i,t.type,close)
            number=int(t.attrGet('start') or 1)
            ordered=t.type=='ordered_list_open'
            for token in tokens[i+1:end]:
                if token.type=='inline':
                    st=ParagraphStyle('boxlist',parent=styles['box' if in_box else 'list'],leftIndent=16,firstLineIndent=0,bulletIndent=0,spaceAfter=5)
                    out.append(Paragraph(render_inline(token.children),st,bulletText=f'{number}.' if ordered else '•'))
                    number+=1
            out.append(Spacer(1,3))
            i=end+1
        elif t.type=='hr': i+=1
        else:
            raise ValueError(f'Unhandled block token {t.type}')
    return out

class Cover(Flowable):
    def wrap(self,w,h):
        self.width=w
        self.height=h-1
        return w,self.height
    def draw(self):
        c=self.canv
        h=self.height
        c.setFillColor(TEAL)
        c.setFont('LatoB',10)
        c.drawString(0,h-10,'C++  /  ÜBUNG 03')
        c.setFillColor(NAVY)
        c.setFont('LatoB',50)
        c.drawString(-2,h-113,'Von C')
        c.drawString(-2,h-171,'zu C++')
        c.setFont('Lato',19)
        c.setFillColor(MUTED)
        c.drawString(0,h-211,'Verstehen. Anwenden. Nachschlagen.')
        c.setStrokeColor(TEAL)
        c.setLineWidth(4)
        c.line(0,h-242,57,h-242)

        # A quiet typographic motif, composed directly as vector shapes.
        c.setFillColor(colors.HexColor('#EAF3F5'))
        c.roundRect(self.width-133,h-177,133,167,12,fill=1,stroke=0)
        c.setFillColor(TEAL)
        c.setFont('Mono',38)
        c.drawCentredString(self.width-66,h-82,'{ }')
        c.setFont('LatoB',37)
        c.drawCentredString(self.width-66,h-135,'03')

        p=Paragraph('Ein Lernskript zu Namensräumen, Referenzen, Klassen und sicherer Ressourcenverwaltung.',
                    ParagraphStyle('coverdesc',parent=styles['body'],fontSize=15,leading=21,textColor=NAVY))
        pw,ph=p.wrap(self.width-30,100)
        p.drawOn(c,0,h-285-ph)

        tracks=[('01', 'SPRACHGRUNDLAGEN', 'Namen, Funktionen, const'),
                ('02', 'OBJEKTE VERSTEHEN', 'Klassen, Lebensdauer, RAII'),
                ('03', 'WISSEN ANWENDEN', 'Operatoren und Selbsttest')]
        y=h-413
        for number,title,desc in tracks:
            c.setFillColor(TEAL)
            c.setFont('LatoB',11)
            c.drawString(0,y,number)
            c.setFillColor(NAVY)
            c.setFont('LatoB',10)
            c.drawString(34,y,title)
            c.setFillColor(MUTED)
            c.setFont('Lato',10)
            c.drawString(34,y-17,desc)
            y-=57

        goals = 'Du kannst Namen eindeutig zuordnen, Funktionsüberladungen unterscheiden und mit Zeigern, Referenzen und const umgehen. Darauf aufbauend verstehst du Klassen, Konstruktoren, Destruktoren und Operatorüberladung.'
        p=Paragraph('<b>Dein Lernziel</b><br/>'+goals,ParagraphStyle('covergoals',parent=styles['small'],textColor=MUTED,leading=14))
        pw,ph=p.wrap(self.width,120)
        p.drawOn(c,0,45)
        c.setStrokeColor(LINE)
        c.setLineWidth(.6)
        c.line(0,28,self.width,28)
        c.setFont('LatoB',8)
        c.setFillColor(TEAL)
        c.drawString(0,8,'C++17+  |  KOMMENTIERTE BEISPIELE  |  VERSTÄNDNISFRAGEN')

class Notes(Flowable):
    def wrap(self,w,h):
        self.width=w
        self.height=max(80,min(h-10,260))
        return w,self.height
    def draw(self):
        c=self.canv
        c.setFont('LatoB',9)
        c.setFillColor(MUTED)
        c.drawString(0,self.height-20,'EIGENE ANTWORTEN UND NOTIZEN')
        c.setStrokeColor(LINE)
        c.setLineWidth(.5)
        y=self.height-48
        while y>10:
            c.line(0,y,self.width,y)
            y-=24

class LearningDoc(BaseDocTemplate):
    def __init__(self,path):
        super().__init__(str(path),pagesize=A4,leftMargin=LEFT,rightMargin=RIGHT,
                         topMargin=TOP,bottomMargin=BOTTOM,title='Übung 3 - Von C zu C++',
                         author='C++ Lernnotizen',subject='Überarbeitetes Lernskript mit C++-Beispielen',
                         pageCompression=1)
        frame=Frame(LEFT,BOTTOM,CW,H-TOP-BOTTOM,id='main',leftPadding=0,rightPadding=0,topPadding=0,bottomPadding=0)
        self.addPageTemplates(PageTemplate(id='pages',frames=[frame],onPage=self.draw_page))
        self.chapter_pages=[]
    def beforeDocument(self):
        self.chapter_pages=[]
        self.subcounter=0
    def draw_page(self,c,doc):
        if doc.page==1: return
        c.saveState()
        c.setStrokeColor(LINE)
        c.setLineWidth(.6)
        c.line(LEFT,H-35,W-RIGHT,H-35)
        c.setFont('LatoB',8)
        c.setFillColor(TEAL)
        c.drawString(LEFT,H-26,'C++ / ÜBUNG 03')
        c.setFillColor(MUTED)
        c.setFont('Lato',8)
        c.drawRightString(W-RIGHT,H-26,'Von C zu C++')
        c.line(LEFT,35,W-RIGHT,35)
        c.setFillColor(MUTED)
        c.drawString(LEFT,22,'LERNEN  /  VERSTEHEN  /  ANWENDEN')
        c.setFillColor(NAVY)
        c.setFont('LatoB',9)
        c.drawRightString(W-RIGHT,22,f'{doc.page:02d}')
        c.restoreState()
    def afterFlowable(self,flowable):
        if isinstance(flowable,Chapter):
            self.canv.bookmarkHorizontalAbsolute(flowable.key,self.frame._y+flowable.height)
            self.canv.addOutlineEntry(flowable.heading_text,flowable.key,0,False)
            self.notify('TOCEntry',(0,esc(flowable.heading_text),self.page,flowable.key))
            self.chapter_pages.append((flowable.heading_text,self.page))
        elif getattr(flowable,'subheading',None):
            self.subcounter+=1
            key='sub-'+str(self.subcounter)
            self.canv.bookmarkPage(key)
            self.canv.addOutlineEntry(flowable.subheading,key,1,False)

source=SOURCE.read_text()
source=re.sub(r'^---\n.*?\n---\n','',source,count=1,flags=re.S)
source=source.replace('Die Lösungen lassen sich in Obsidian aufklappen.',
                      'Die Lösungen findest du gesammelt auf der folgenden Seite.')
source_lines=source.splitlines()
tokens=md.parse(source)
start=next(i for i,t in enumerate(tokens) if t.type=='heading_open' and tokens[i+1].content.startswith('1. '))

story=[Cover(),PageBreak()]
story.append(para('Dein Weg durch die Übung','h2'))
story.append(para('13 Kapitel - von den Sprachgrundlagen bis zum eigenen Zahlentyp. Die Einträge führen direkt zum jeweiligen Abschnitt.','small'))
toc=TableOfContents()
toc.levelStyles=[styles['toc']]
toc.dotsMinLevel=0
story.extend([Spacer(1,8),toc,Spacer(1,18)])

intro=next(t.content for t in tokens if t.type=='inline' and t.content.startswith('Diese überarbeitete'))
story.append(para(intro,'small'))
usage=next(t for t in tokens if t.type=='blockquote_open' and 'Codebeispiele' in '\n'.join(source_lines[t.map[0]:t.map[1]]))
usage_text='\n'.join(re.sub(r'^> ?', '', line) for line in source_lines[usage.map[0]:usage.map[1]])
story.append(make_box(usage_text))
story.extend(parse_body(tokens[start:]))

doc=LearningDoc(OUT)
doc.multiBuild(story)
(TMP/'chapters.json').write_text(json.dumps(doc.chapter_pages,ensure_ascii=False,indent=2))
print(json.dumps({'pdf':str(OUT),'pages':doc.page,'chapters':doc.chapter_pages,'bytes':OUT.stat().st_size},ensure_ascii=False,indent=2))
