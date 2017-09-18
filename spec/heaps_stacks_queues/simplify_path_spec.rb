<<-DOC
Given an absolute file path (Unix-style), shorten it to the format /<dir1>/<dir2>/<dir3>/....

Here is some info on Unix file system paths:

/ is the root directory; the path should always start with it even if it isn't there in the given path;
/ is also used as a directory separator; for example, /code/fights denotes a fights subfolder in the code folder in the root directory;
this also means that // stands for "change the current directory to the current directory"
. is used to mark the current directory;
.. is used to mark the parent directory; if the current directory is root already, .. does nothing.
Example

For path = "/home/a/./x/../b//c/", the output should be
simplifyPath(path) = "/home/a/b/c".

Here is how this path was simplified:
* /./ means "move to the current directory" and can be replaced with a single /;
* /x/../ means "move into directory x and then return back to the parent directory", so it can replaced with a single /;
* // means "move to the current directory" and can be replaced with a single /.

Input/Output

[time limit] 4000ms (rb)
[input] string path

A line containing a path presented in Unix style format. All directories in the path are guaranteed to consist only of English letters.

Guaranteed constraints:
1 ≤ path.length ≤ 5 · 104.

[output] string

The simplified path.
DOC

describe "simplify_path" do
  def simplify_path(path)
    result = []
    path.split('/').each do |part|
      case part
      when '.'
      when '..'
        result.pop
      when ''
      else
        result.push(part)
      end
    end
    "/" + result.join('/')
  end

  [
    { path: "/home/a/./x/../b//c/", x: '/home/a/b/c' },
    { path: "/a/b/c/../..", x: '/a' },
    { path: "/../", x: '/' },
    { path: "/", x: "/" },
    { path: "//a//b//./././c", x: '/a/b/c' },
    { path: "a/../../b/", x: '/b' },
    { path: "a/b/../c/d/../../e/../../", x: "/" },
    { path: "/.././///", x: "/" },
    { path: "/cHj/T//", x: "/cHj/T" },
    { path: "/////..///K/BruP/RMplU/././", x: "/K/BruP/RMplU" },
    { path: "/mpJN/..///../../ubYgf/tFM/", x: "/ubYgf/tFM" },
    { path: "/N/cKX/bdrC/./ozFyd/NyuwO/", x: "/N/cKX/bdrC/ozFyd/NyuwO" },
    { path: "/home/", x: "/home" },
    { path: "/AagbK/////iavh/M/rmKaS/tXD/././lND//", x: "/AagbK/iavh/M/rmKaS/tXD/lND" },
    { path: "/oCTY/XJwyB/zA/qgfp/RQFl/kY/./Pa/nth/", x: "/oCTY/XJwyB/zA/qgfp/RQFl/kY/Pa/nth" },
    { path: "/home//foo/", x: "/home/foo" },
    { path: "/a/./b/../../c/", x: "/c" },
    { path: "a/b/../c/d/../../e/../../a/", x: "/a" },
  ].each do |x|
    it do
      expect(simplify_path(x[:path])).to eql(x[:x])
    end
  end
end
