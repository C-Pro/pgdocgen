<%inherit file="base.mako" />
<h3>List of schemas:</h3>
<table>
% for s in schemas:
  <tr>
  <td>
    <h3><a href="${s.object_name}.html">Schema ${s.object_name}</a></h3>
    % if s.comment:
    <p>${s.comment}</p>
    % endif
  </td>
  </tr>
% endfor
</table>
