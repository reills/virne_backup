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
  id 1615
  arrival_time 36121.410483041065
  lifetime 537.507823697522
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 29
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 18
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 47
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
]
