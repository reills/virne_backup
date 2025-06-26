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
  id 1870
  arrival_time 40994.95342575866
  lifetime 3097.7657108598637
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 16
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 32
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
]
