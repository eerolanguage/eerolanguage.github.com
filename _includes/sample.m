<span class="k">#import</span> <span class="s">&lt;Foundation/Foundation.h&gt</span>

<span class="k">@interface</span> FileHelper : <span class="kt">NSObject</span>

<span class="k">@property</span> (<span class="k">readonly</span>) <span class="kt">NSString*</span> name;
<span class="k">@property</span> (<span class="k">readonly</span>) <span class="kt">NSString*</span> format;

-(<span class="kt">NSFileHandle*</span>) openFile: (<span class="kt">NSString*</span>) path;

-(<span class="kt">NSFileHandle*</span>) openFile: (<span class="kt">NSString*</span>) path
          withPermissions: (<span class="kt">NSString*</span>) permissions;

<span class="k">@end</span>


<span class="k">@implementation</span> FileHelper

-(<span class="kt">NSString*</span>) name {
  <span class="k">return</span> <span class="s">@"Macintosh"</span>;
}

-(<span class="kt">NSString*</span>) format {
  <span class="k">return</span> <span class="s">@"HFS+"</span>;
}

-(<span class="kt">NSFileHandle*</span>) openFile: (<span class="kt">NSString*</span>) path {
  <span class="k">return</span> [<span class="kt">NSFileHandle</span> fileHandleForReadingAtPath: path];
}

-(<span class="kt">NSFileHandle*</span>) openFile: (<span class="kt">NSString*</span>) path
          withPermissions: (<span class="kt">NSString*</span>) permissions {

  <span class="kt">NSFileHandle*</span> handle = <span class="nb">nil</span>;

  <span class="k">if</span> ([permissions isEqualTo: <span class="s">@"readonly"</span>] || [permissions isEqualTo: <span class="s">@"r"</span>]) {
    handle = [<span class="kt">NSFileHandle</span> fileHandleForReadingAtPath: path];

  } <span class="k">else if</span> ([permissions isEqualTo: <span class="s">@"readwrite"</span>] || [permissions isEqualTo: <span class="s">@"rw"</span>]) {
    handle = [<span class="kt">NSFileHandle</span> fileHandleForUpdatingAtPath: path];
  }

  <span class="k">return</span> handle;
}

<span class="k">@end</span>
