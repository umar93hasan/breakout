{application,breakout,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             gettext,phoenix_pubsub,cowboy,phoenix_html,
                             phoenix,phoenix_live_reload]},
              {description,"breakout"},
              {modules,['Elixir.Breakout','Elixir.Breakout.Application',
                        'Elixir.Breakout.Game','Elixir.Breakout.GameBackup',
                        'Elixir.BreakoutWeb','Elixir.BreakoutWeb.Endpoint',
                        'Elixir.BreakoutWeb.ErrorHelpers',
                        'Elixir.BreakoutWeb.ErrorView',
                        'Elixir.BreakoutWeb.GamesChannel',
                        'Elixir.BreakoutWeb.Gettext',
                        'Elixir.BreakoutWeb.LayoutView',
                        'Elixir.BreakoutWeb.PageController',
                        'Elixir.BreakoutWeb.PageView',
                        'Elixir.BreakoutWeb.Router',
                        'Elixir.BreakoutWeb.Router.Helpers',
                        'Elixir.BreakoutWeb.UserSocket']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.Breakout.Application',[]}},
              {extra_applications,[logger,runtime_tools]}]}.