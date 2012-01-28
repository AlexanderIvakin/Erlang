{application, ppool,
 [{vsn, "1.0.1"},
  {modules, [ppool, ppool_serv, ppool_sup, ppool_supersup, ppool_worker_sup]},
  {registered, [ppool]},
  {mod, {ppool, []}}
 ]}.