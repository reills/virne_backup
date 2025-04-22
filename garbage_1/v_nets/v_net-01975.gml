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
  id 1975
  arrival_time 43141.372093913014
  lifetime 1362.0476382411593
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 37
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 41
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
]
