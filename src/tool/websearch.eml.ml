(*
let show_form_stream ?(message="") ?(output="") request response =
  %% response
  <html>
  <body>

    <h1><a href="https://github.com/Deducteam/lambdapi">LambdaPi</a>
     Search Engine</h1>

    <p>
    The <b>search</b> button answers the query. Read the <a
    href="https://lambdapi.readthedocs.io/en/latest/query_language.html">query
    language specification</a> to learn about the query language.<br>
    </p>

    <form method="POST" action="/">
      <%s! Dream.csrf_tag request %>
      <p>
      <input type="search" required="true" size="100"
        name="message" value="<%s message %>"
        onfocus="this.select();" autofocus></p>
      <p>
      <input type="submit" value="search" name="search">
      </p>
    </form>

    <%s! output %>

  </body>
  </html>
*)

let show_form ~from ?(message="") ?output request =
  <html>
  <style>
    .snippet {
      border: 2px solid grey;  /* Bordure grise */
      color: red;              /* Texte en rouge */
      /* padding: 10px;           Espace autour du texte à l'intérieur de la bordure */
    }
    code {
      font-family: "Courier New", Courier, monospace;
      background-color:rgb(8, 8, 8);
      padding: 2px 4px;
      border-radius: 4px;
      color:rgb(43, 230, 52);
      font-size: 1.3em;
      white-space: normal;
    }
    .header {
      position: relative; /* Conteneur pour les liens */
      width: 100%;
      height: 80px;
      background-color: #f1f1f1;
    }
    .top-right-link {
      position: absolute;
      top: 10px;
      right: 10px;
      text-decoration: none;
      background-color: #007BFF;
      color: white;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 18px;
      text-align: center;
    }
    .top-right-link span {
      display: block;
      font-size: 12px;
    }
    .top-right-link:hover {
        background-color: #0056b3;
    }
    .top-left-link {
      position: absolute;
      top: 10px;
      left: 10px;
      text-decoration: none;
      background-color: #007BFF;
      color: white;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 18px;
      text-align: center;
    }
    .top-left-link span {
      display: block;
      font-size: 12px;
    }
    .top-left-link:hover {
        background-color: #0056b3;
    }
  </style>
  <body>

    <div class="header">
      <a href="https://github.com/Deducteam/lambdapi/issues/new" target="_blank" class="top-right-link"><span>Something went wrong?</span>Open an issue</a>
      <a href="https://github.com/Deducteam/lambdapi/discussions/1214" target="_blank" class="top-left-link"><span>Like this tool?</span>Join the discussion</a>
      </div>

    <script>
    function incr(delta) {
      document.getElementById("from").value =
        Math.max(0,delta + Number(document.getElementById("from").value));
      document.getElementById("search").click();
    }
    </script>

    <h1><a href="https://github.com/Deducteam/lambdapi">LambdaPi</a>
     Search Engine</h1>
     

    <p>
    This web page offers facilities to search objects in the <a href="https://github.com/Deducteam/lambdapi">HOL-Light</a> library translated and available in 
    <a href="https://github.com/Deducteam/Dedukti/">Dedukti</a>,
    <a href="https://github.com/Deducteam/lambdapi">Lambdapi</a>  and 
    <a href="https://coq.inria.fr/">Coq/Rocq</a>.
    </p>
    <p>
    The translation has been performed using the <a href="https://github.com/Deducteam/hol2dk">hol2dk</a> tool and the resulting theorems are gathered in the Opam package coq-hol-light available in the Coq Opam repository released.
    It currently contains a translation of the Multivariate library with more than 20,000 theorems on arithmetic, wellfounded relations, lists, real numbers, integers, basic set theory, permutations, group theory, matroids, metric spaces, homology, vectors, determinants, topology, convex sets and functions, paths, polytopes, Brouwer degree, derivatives, Clifford algebra, integration, measure theory, complex numbers and analysis, transcendental numbers, real analysis, complex line integrals, etc.
    </p>
    <p>
    The <b>search</b> button answers the query. Read the <a
    href="https://lambdapi.readthedocs.io/en/latest/query_language.html">query
    language specification</a> to learn about the query language.<br>
    Examples of queries written in the query language are as follows :
    </p>
    <ul>
      <li><span class="snippet">hyp = (num → num) , hyp >= (Real)</span> searches for theorem that have an hypothesis <span class="snippet">num → num</span> and such that <span class="snippet">Real</span> occurs in some (other) hypothesis.
      <li><span class="snippet">concl > real_of_num | HOLLight.theorems</span> searches for theorems having an hypothesis containing <span class="snippet">real_of_num</span> and located in a module whose path is a suffix of <span class="snippet">HOLLight.theorems</span></li>
      <li><span class="snippet">name = num ; name = NUM</span> searches for symbols named either <span class="snippet">num</span> or <span class="snippet">NUM</span></li>
    </ul>

    <form method="POST" action="/" id="form">
      <%s! Dream.csrf_tag request %>
      <p>
      <input type="search" required="true" size="100"
        name="message" value="<%s message %>"
        onfocus="this.select();" autofocus></p>
      <p>
      <input type="submit" value="search" id="search" name="search">
      </p>

%   begin match output with
%   | None ->
       <input type="hidden" name="from" value="<%s string_of_int from %>">
%   | Some output ->
    <p>
    <input type="number" required="true" style="width: 5em" min="0" id="from"
      name="from" value="<%s string_of_int from %>" onfocus="this.select()">
    <input type="button"
      name="prev" value="Prev" onclick="incr(-100)">
    <input type="button"
      name="next" value="Next" onclick="incr(100)">
    </p>
    <%s! output %>
%   end;
    </form>

  </body>
  </html>

let start ss ~port () =
  (*Common.Logger.set_debug true "e" ;*)
  let interface = "0.0.0.0" in
  Dream.run ~port ~interface
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get  "/"
      (fun request ->
        Dream.html (show_form ~from:0 request));

    Dream.post "/"
      (fun request ->
        match%lwt Dream.form request with
        | `Ok [ "from", from; "message", message; "search", _search ] ->
          Dream.log "from1 = %s" from ;
          let from = int_of_string from in (* XXX CSC exception XXX *)
          Dream.log "from2 = %d" from ;
          let output =
            Indexing.search_cmd_html ss ~from ~how_many:100 message in
          Dream.html (show_form ~from ~message ~output request)
          (*Dream.stream (show_form_stream ~message ~output request)*)
        | _ ->
          Dream.log "no match" ;
          Dream.empty `Bad_Request);

  ]
