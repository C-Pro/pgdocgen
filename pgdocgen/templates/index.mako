<%inherit file="base.mako" />
<h3>List of schemas:</h3>
<table>
% for s in schemas:
  <tr>
  <td>
    <h3><a href="${s}.html">Schema ${s}</a></h3>
  </td>
  </tr>
% endfor
</table>
