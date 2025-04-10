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
  id 1117
  arrival_time 23263.493078763164
  lifetime 1484.7503757102836
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 36
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 26
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 28
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
]
