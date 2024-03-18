= Unconditional

Some years ago, while fixing an _UnboundLocalError_ in my code, I realised that I tint my scripts unconsciously with cyclomatic complexity --- an avoidable habit I picked up as a young engineer. Back then, time-sharing was still very much a necessity, and so I would spend much of my time buckling-down and performing hand-calculations instead. Conditional problems worsened this, like for instance, referring to a table to pick an option, and then use its data to perform specific calculations. Also, results for ten options when I needed for one or two, at the time felt both repetitive as well as unnecessary.

Scripts produced from thinking linearly tend to grow verbose is what I've come to realise. Whereas knowing results for the cases (or ranges) that I may not readily be interested-in offers new insights, sans extra labour. And so, running with an entire dataset instead of one value contained within, gives me a high now. To echo the words of Dr Richard Hamming, "The purpose of computing is insight, not numbers."  

Here in examples below, I am trying to calculate bending stresses in piles hung over the aft of a transport vessel. In the first example, I front-load a range of motions for each of which I get to map corresponding bending stresses in a pile section with a certain fixed pile length. See @u1.

In the second, I nail down a motion set (e.g., large barge criteria, but can be anything specific), and map acceptable length of overhang. See @u2. Shaded area indicates exceeding strength limits.

#figure(
  image("/img/unconditional-1.png", width: 100%),
  caption: [
  Generating bending stress in overhung pile for a range of vessel motions (left:from pitch; right:from roll)
  ],
) <u1>

#figure(
  image("/img/unconditional-2.png", width: 100%),
  caption: [
  Generating bending stress for a range of pile overhang for specific vessel motions (left:from pitch; right:from roll)
  ],
) <u2>

#pagebreak(weak: true)

Code for @u1 is as follows. 

#let ptow = read("/src/ptow.py")
#{linebreak();raw(ptow, lang: "python")}

Code for @u2 is as follows.

#let ptow-ls = read("/src/ptow-ls.py")
#{linebreak();raw(ptow-ls, lang: "python")}

$ - * - $