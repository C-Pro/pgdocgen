<%inherit file="base.mako" />

<div class="d-function-list d-function-list_maximized_state">
                <div class="d-function-list__content">
                    <ul class="d-function-list__f-level">
                        <li class="d-function-list__item selected">
                            <span class="minus">
                            </span>
                            <a href="#">
                                ${schema_name}
                            </a>
                            <ul class="d-function-list__s-level">
                            % for f in functions:
                                <li class="d-function-list__item">
                                    <a href="#${f.object_name}">
                                        <b>F</b>&nbsp;${f.schema_name}.${f.object_name}
                                    </a>
                                </li>
                            % endfor
                            </ul>
                            <ul class="d-function-list__s-level">
                            % for t in tables:
                                <li class="d-function-list__item">
                                    <a href="#${t.object_name}">
                                        <b>T</b>&nbsp;${t.schema_name}.${t.object_name}
                                    </a>
                                </li>
                            % endfor
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="d-function-list__btn-cover" href="#">
                    <span></span>
                    <a href="#">
                        Contents
                    </a>
                </div>
            </div>
            <a class="d-breadcrumbs" href="index.html">
                <span class="d-breadcrumbs__arrow"></span>
                Back to index
            </a>
            <h1 class="d-heading">
                ${title}
            </h1>

            <div class="d-content">
            % for f in functions:
                <section class="d-function">
                    <h1 class="d-function__title">
                        <a id="${f.object_name}">
                        Function
                            <span class="d-function__title_fname">
                                ${f.schema_name}.${f.object_name}
                            </span>
                        </a>
                    </h1>
                    <p class="d-function__description">
                        ${f.comment}
                    </p>
                    % if len(f.params) > 0:
                    <div class="d-function__parameter">
                        <h2 class="d-function__parameter_title">
                            Parameters:
                        </h2>
                        % for p in f.params:
                        <p class="d-function__parameter_item">
                            <span>
                                ${p[1]}
                            </span>
                        </p>
                        % endfor
                    </div>
                    % endif
                    % if f.returns:
                    <p class="d-function__result">
                        Returns:
                        <span>
                            ${f.returns}
                        </span>
                    </p>
                    % endif
                </section>
            % endfor
            
            % for t in tables:
                <section class="d-function">
                    <h1 class="d-function__title">
                        <a id="${t.object_name}">
                            Table
                            <span class="d-function__title_fname">
                                ${t.schema_name}.${t.object_name}
                            </span>
                        </a>
                    </h1>
                    <p class="d-function__description">
                        ${t.comment}
                    </p>
                    % if len(t.params) > 0:
                    <div class="d-function__parameter">
                        <h2 class="d-function__parameter_title">
                            Fields:
                        </h2>
                        % for p in t.params:
                        <p class="d-function__parameter_item">
                            <span>
                                ${p['name']} (${p['type']}) - ${p['comment']}
                            </span>
                        </p>
                        % endfor
                    </div>
                    % endif
                </section>
            % endfor
            
            </div>
