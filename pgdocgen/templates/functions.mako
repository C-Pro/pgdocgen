<html>
<head>
<meta charset="utf-8">
<title>
Stored functions of schema ${schema_name}
</title>
</head>
<body>
<h1>Stored functions of schema ${schema_name}</h1>
<table>
% for f in jdoc:
  <tr>
  <td>
    <h3>Function ${f.schema_name}.${f.object_name}</h3>
    <p>${f.comment}</p>
  </td>
  </tr>
% endfor
</table>
</body>
</html>