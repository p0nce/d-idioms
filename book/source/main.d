static import std.file;
import std.stdio;
import std.conv;
import std.string;
import std.algorithm;
import std.format;
import std.array;

import printed.canvas;
import printed.flow;
import commonmarkd;
import arsd.dom;
import colorize;

enum string FONT_FACE = "Arial";

int main(string[] args)
{
    try
    {
        createManual("book.xml", false);
        return 0;
    }
    catch(Exception e)
    {
        error(e.msg);
        return 2;
    }
}

void createManual(string xmldesc, bool outputHTML)
{
    // Parse user-manual.xml
    Manual manual = parseManualXML(xmldesc);

    string outputPath = "d-idioms.pdf";

    // Start output
    int widthMm = 210;
    int heightMm = 297;

    PDFDocument pdf;
    HTMLDocument html;
    IRenderingContext2D context;
    if (outputHTML)
        context = html = new HTMLDocument(widthMm, heightMm);
    else
        context = pdf = new PDFDocument(widthMm, heightMm);
    StyleOptions style;
    style.fontSizePt = 10.0;
    style.color = "black";
    style.fontFace = "Arial";

    style.pre.fontFace = "Inconsolata";
    style.pre.fontWeight = FontWeight.normal;
    style.code = style.pre;

    // This is to workaround limitations in printed:flow
    style.h2.marginTopEm = 1.5;

    
    style.onEnterPage = (IRenderingContext2D context, int pageCount)
    {
        if (pageCount == 0) return;
        with(context)
        {          
        }
    };

    // Front page
   
    drawFrontPage(context, style, manual);

    IFlowDocument doc = new FlowDocument(context, style);

    foreach(size_t n, mdfile; manual.chapters)
    {
        cwritefln(format("Adding chapter %s...".cyan, mdfile.white));
        if (n != 0) doc.pageSkip;
        addMarkdownChapter(doc, mdfile);
    }

    // Get finished manual
    doc.finalize(); 
    const(ubyte)[] bytes = outputHTML ? html.bytes() : pdf.bytes();
    std.file.write(outputPath, bytes);
    cwritefln(" => Written %s (%s)".green, outputPath, prettyByteSize(bytes.length).white);
}

struct Manual
{
    string[] chapters = [];
}

// Parse user-manual.xml, return a Manual
Manual parseManualXML(string xmldesc)
{
    
    static immutable string[] CHAPTERS =
    [
        // DIID        
        "DIID #1 - Parse XML file.md",
        "DIID #2 - Play music.md",
        "DIID #3 - Convert Markdown to HTML.md",
        "DIID #4 - Draw an accelerated triangle.md",
        "DIID #5 - Draw a triangle in a PDF.md",
        "DIID #6 - Parse JSON file.md",
        "DIID #7 - GET a file from the Internet.md",
        "DIID #8 - Your own tree-walk interpreter.md",

        // Basics
        "assert(false) is special.md",
        "Falsey values.md",
        "&#x2F;+ +&#x2F; nestable comments and version(none).md",
        "Grouping modules with package.d.md",
        "Inheriting from Exception.md",
        "Porting from C gotchas.md",
        "Skip initialization with = void.md",        
        "Static arrays are value types.md",
        "So what does -debug do, exactly&#63;.md",
        "So what does -release do, exactly&#63;.md",
        "So what do module declarations do, exactly&#63;.md",

        // Language       
        "Trailing commas.md",
        "Automatic attribute inference for function templates.md",
        "Differences in integer handling vs C.md",        
        "Ensure array access without bounds checking.md",
        "Enumerate fields with __traits(allMembers) and static foreach.md",
        "Eponymous templates.md",
        "Everything you wanted to ask about struct construction.md",  
        "Four ways to use the static keyword you may not know about.md",
        "if (__ctfe).md",
        "if embedded declaration.md",
        "Knowing inout inside out.md",
        "Linking with C gotchas.md",
        "One does not simply call new for static arrays.md",
        "Precomputed tables at compile-time through CTFE.md",
        "Should I use ++pre-increment or post-increment++&#x3F;.md",
        "Smallest valid D program.md",
        "Type qualifiers and slices creation.md",
        "What is the difference between out and ref parameters&#x3F;.md",

        // Traps
        "The trouble with class destructors.md",
        "GC-proof resource class.md",
        "Don't use @property.md",
        "The truth about shared.md",
        "Friends don't let friends use the default struct postblit.md",
        "Get parent class of a class at compile-time.md",
        "Leveraging TLS for a fast thread-safe singleton.md",
        "Never use &gt;= for dependencies.md",
        "The importance of being pure.md",
        "Voldemort types.md",

        // D Runtime
        "Slices .capacity, the mysterious property.md",
        "Placement new with emplace.md",
        "Adding or removing an element from arrays.md",
        "The impossible real-time thread.md",
        "How the D Garbage Collector works.md",

        // Stdlib / Runtime        
        "Phobos gems.md",
        "Working with files.md",
        "Precise timestamps in milliseconds.md",
        "Capturing with regular expressions.md",
        "Converting from and to C strings.md",
        "Getting a method callbacked from C.md",
        "Minimum or maximum of numbers.md",
        "Optimal AA lookup.md",
        "Parallel foreach.md",
        "Recursive Sum Type with matching.md",
        "Searching for a substring position.md",
        "String interpolation as a library.md",
        "Using std.typecons.Flag like a pro.md",

        // Ecosystem        
        "Patching a library available on the DUB registry.md",
        "Contributing back with money.md",
        "Design by Introspection.md",
        "Games made with D.md",
        "How does D improve on C++17&#63;.md",
        "Renaming a module with backwards compatibility.md",
        "Unittests with optimizations &#x3A; the Final Frontier.md",
        "Which book should I read&#63;.md",
        
        // Oddities                
        "@nogc Array Literals&#x3A; Breaking the Limits.md",  
        "Bypassing @nogc.md",    
        "Compile-time RNG.md",
        "Emulating Perl's __DATA__.md",
        "Extend a struct with alias this.md",
        "Implicit conversion for user-defined types.md",        
        "Is this available at compile-time or runtime&#63;.md",  
        "Qualified switch using with.md",

        // Philosophy
        "So D is just C++ with a Garbage Collector&#63;.md",
        "Unrecoverable vs recoverable errors.md",
    ];

    Manual res;
    res.chapters = CHAPTERS.map!(a => "../idioms/" ~ a).array;


    return res;
}

void addMarkdownChapter(IFlowDocument doc, string markdownPath)
{
    string markdown = cast(string) std.file.read(markdownPath);

      string html = convertMarkdownToHTML(markdown);

    string fullHTML = 
        "<html>" ~
        "<body>" ~
        html ~
        "</body>" ~
        "</html>";

    // Parse DOM
    auto dom = new Document();
    bool caseSensitive = true, strict = true;
    dom.parseUtf8(fullHTML, caseSensitive, strict);

    // Traverse HTML and generate corresponding IFlowDocument commands
    Element bodyNode = dom.root;
    assert(bodyNode !is null);

    void renderNode(Element elem)
    {
        debug(domTraversal) writeln(">", elem.tagName);
        // Enter the node
        switch(elem.tagName)
        {
            case "p": doc.enterParagraph(); break;
            case "b": doc.enterB(); break;
            case "strong": doc.enterStrong(); break;
            case "i": doc.enterI(); break;
            case "em": doc.enterEm(); break;
            case "code": doc.enterCode(); break;
            case "pre": doc.enterPre(); break;
            case "h1": doc.enterH1(); break;
            case "h2": doc.enterH2(); break;
            case "h3": doc.enterH3(); break;
            case "h4": doc.enterH4(); break;
            case "h5": doc.enterH5(); break;
            case "h6": doc.enterH6(); break;
            case "ol": doc.enterOrderedList(); break;
            case "ul": doc.enterUnorderedList(); break;
            case "li": doc.enterListItem(); break;
            case "img": 
            {
                string src = elem.getAttribute("src");
                doc.enterImage(src); 
                break;
            }
            default:
                break;
        }

        // If it's a text node, display text
        if (auto textNode = cast(TextNode)elem)
        {
            string s = textNode.nodeValue();
            doc.text(s);
        }

        // Render children
        foreach(c; elem.children)
            renderNode(c);

        // Exit the node
        switch(elem.tagName)
        {
            case "p": doc.exitParagraph(); break;
            case "b": doc.exitB(); break;
            case "strong": doc.exitStrong(); break;
            case "i": doc.exitI(); break;
            case "em": doc.exitEm(); break;
            case "code": doc.exitCode(); break;
            case "pre": doc.exitPre(); break;
            case "h1": doc.exitH1(); break;
            case "h2": doc.exitH2(); break;
            case "h3": doc.exitH3(); break;
            case "h4": doc.exitH4(); break;
            case "h5": doc.exitH5(); break;
            case "h6": doc.exitH6(); break;
            case "br": doc.br(); break;
            case "ol": doc.exitOrderedList(); break;
            case "ul": doc.exitUnorderedList(); break;
            case "li": doc.exitListItem(); break;
            case "img": doc.exitImage(); break;
            case "page-break": doc.pageSkip(); break;
            default:
                break;
        }
        debug(domTraversal) writeln("<", elem.tagName);
    }
    renderNode(bodyNode);
}
  

bool enableColoredOutput = true;

string white(string s) @property
{
    if (enableColoredOutput) return s.color(fg.light_white);
    return s;
}

string cyan(string s) @property
{
    if (enableColoredOutput) return s.color(fg.light_cyan);
    return s;
}

string green(string s) @property
{
    if (enableColoredOutput) return s.color(fg.light_green);
    return s;
}

string red(string s) @property
{
    if (enableColoredOutput) return s.color(fg.light_red);
    return s;
}

void error(string msg)
{
    cwritefln("error: %s".red, msg);
}

string prettyByteSize(size_t size)
{
    if (size < 10000)
        return format("%s bytes", size);
    else if (size < 1024*1024)
        return format("%s kb", (size + 512) / 1024);
    else
        return format("%s mb", (size + 1024*512) / (1024*1024));
}

int currentYear()
{
    import std.datetime;
    SysTime time = Clock.currTime(UTC());
    return time.year;
}

void drawFrontPage(IRenderingContext2D context, StyleOptions style, Manual manual)
{
    style.onEnterPage(context, 0);

    with(context)
    {
        save;

        float W = pageWidth;
        float H = pageHeight;     

        float x = pageWidth / 2;
        float y = pageHeight / 2;

        strokeStyle = "#2e262411";
        lineWidth(0.12);
        beginPath(W/2, 5 + 8);
        lineTo(0, 180 + 8);
        lineTo(0, H + 8);
        lineTo(W, H + 8);
        lineTo(W, 180 + 8);
        closePath();
        stroke();
        beginPath(x, H);
        lineTo(0, H-180 - 4);
        lineTo(0, - 4);
        lineTo(W, - 4);
        lineTo(W, H-180 - 4);
        closePath();
        stroke();

        strokeStyle = "#2e26241c";

        beginPath(0, y);
        lineTo(W, y);
        stroke();

        beginPath(x, 0);
        lineTo(x, H);
        stroke();

        fillStyle = "black";

        
        fontFace(FONT_FACE);
        fontWeight(FontWeight.bold);
        fontStyle(FontStyle.normal);
        textAlign(TextAlign.center);

        fontSize(36);
        fillText("d-idioms", W / 2, H/2 + 20);

        
        fontSize(14);
        fillText("With great power comes great readability.", pageWidth / 2, y + H/2 + 35);

        fontWeight(FontWeight.normal);
        textAlign(TextAlign.start);

        restore;

        newPage;
    }
}