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
  id 1302
  arrival_time 27138.27704555037
  lifetime 1465.611565303019
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 30
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 30
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
]
