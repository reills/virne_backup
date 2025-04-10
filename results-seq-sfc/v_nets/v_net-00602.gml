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
  id 602
  arrival_time 12421.439314332532
  lifetime 303.31349914151656
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 40
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 25
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
]
