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
  id 1958
  arrival_time 42914.535853116155
  lifetime 416.23060035346987
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 26
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 0
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
]
