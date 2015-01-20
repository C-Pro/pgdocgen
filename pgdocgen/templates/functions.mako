<%inherit file="base.mako" />
<table cellpadding = '20px'>
% for f in jdoc:
  <tr>
  <td>
    <h3>Function <span class="code">${f.schema_name}.${f.object_name}</span></h3>
    <p>${f.comment}</p>
    % if len(f.params) > 0:
      <p><strong>Parameters:</strong>
      <ul>
        % for p in f.params:
          <li>${p[1]}</li>
        % endfor
      </ul>
      </p>
    % endif
    <p><strong>Returns:</strong> ${f.returns}</p>
  </td>
  </tr>
% endfor
</table>

