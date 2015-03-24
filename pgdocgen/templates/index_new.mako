<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <link rel="stylesheet" href="styles/documentation_index.css" />
    </head>
    <body class="d-page">
        <div class="d-page__wrapper">
            <h1 class="d-heading">
                ${title}
            </h1>
            <div class="d-content">
                <h2 class="d-content__title">
                    List of schemas:
                </h2>
                <ul class="d-list">
                    % for schema in schemas:
                    <li class="d-list__item">
                        <a href="#">
                            Schema ${schema}
                        </a>
                    </li>
                    % endfor
                </ul>
            </div>
        </div>
        <footer class="d-footer">
            <div class="d-footer__content">
                <div class="d-footer__info">
                    <p class="d-footer__info_copyright">
                      PgDocGen:
                    </p>
                    <p class="d-footer__info_page-title">
                        ${title}
                    </p>
                </div>
                <div class="d-footer__generation-time">
                    <p class="d-footer__generation-time_label">
                        Built:
                        <span class="d-footer__generation-time_value">
                          <%!
                            import time
                            gen_time = time.strftime('%Y-%m-%d %H:%M:%S')
                          %>
                          ${gen_time}
                        </span>
                    </p>
                </div>
            </div>
        </footer>
    </body>
</html>