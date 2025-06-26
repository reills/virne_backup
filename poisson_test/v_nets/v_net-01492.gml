graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1492
  arrival_time 32962.97413373585
  lifetime 2413.9900326221687
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 44
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 33
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
]
