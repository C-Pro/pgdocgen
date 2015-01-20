<%inherit file="base.mako" />
<table>
% for f in jdoc:
  <tr>
  <td>
    <h3>Function ${f.schema_name}.${f.object_name}</h3>
    <p><strong>returns:</strong> ${f.returns}</p>
    % if len(f.params) > 0:
      <p><strong>Parameters:</strong>
      <ul>
        % for p in f.params:
          <li><strong>${p[0]}:</strong>&nbsp;${p[1]}</li>
        % endfor
      </ul>
      </p>
    % endif
    <p>${f.comment}</p>
  </td>
  </tr>
% endfor
</table>

